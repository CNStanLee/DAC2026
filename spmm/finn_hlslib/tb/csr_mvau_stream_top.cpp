#include <hls_stream.h>
using namespace hls;
#include "ap_int.h"
#include "bnn-library.h"

#include "activations.hpp"
#include "weights.hpp"
#include "interpret.hpp"
#include "dma.h"
#include "mvau.hpp"
#include "conv.hpp"
#include "data/memdata.h"
#include "data/config.h"

#include "csr_mvau.hpp"
#include "csr_mask.hpp" 
// -----------------------------------------------------------------------------
// 1) FINN 风格输出容器：支持 3 参和 2 参 operator()
// -----------------------------------------------------------------------------
template<unsigned PE, unsigned ACTW>
struct csr_pe_act_t {
    ap_uint<PE*ACTW> v;

    // 3-arg: 内核会用这个：outElem(pe,0,1)=...
    ap_range_ref<PE*ACTW, false> operator()(unsigned pe, unsigned /*mmv*/, unsigned /*en*/) {
        return v.range((pe+1)*ACTW-1, pe*ACTW);
    }
    ap_range_ref<PE*ACTW, false> operator()(unsigned pe, unsigned /*mmv*/, unsigned /*en*/) const {
        return const_cast<ap_uint<PE*ACTW>&>(v).range((pe+1)*ACTW-1, pe*ACTW);
    }

    // 2-arg: FINN 的 Slice<>::Container 在 interpret.hpp 里会调这个
    ap_range_ref<PE*ACTW, false> operator()(unsigned pe, unsigned /*mmv*/) {
        return v.range((pe+1)*ACTW-1, pe*ACTW);
    }
    ap_range_ref<PE*ACTW, false> operator()(unsigned pe, unsigned /*mmv*/) const {
        return const_cast<ap_uint<PE*ACTW>&>(v).range((pe+1)*ACTW-1, pe*ACTW);
    }

    // 自动转成真正的 bit 向量，方便后面给 StreamingDataWidthConverter
    operator ap_uint<PE*ACTW>() const { return v; }
};

// 列索引位宽：MatrixW=36 → 6 bit
template<unsigned N> struct ColBits {
    enum { Val = (N <= 2) ? 1 :
                 (N <= 4) ? 2 :
                 (N <= 8) ? 3 :
                 (N <= 16)? 4 :
                 (N <= 32)? 5 :
                 (N <= 64)? 6 :
                 (N <= 128)?7 : 8 };
};

// -----------------------------------------------------------------------------
// 2) 用 FINN 原来的 dense param stream → 转成我们的 3 条 CSR stream
//    注意这里的模板参数名已经换成 WBits，避免和 #define WIDTH 冲突
// -----------------------------------------------------------------------------
template<
    unsigned MatrixW,
    unsigned MatrixH,
    unsigned SIMD,
    unsigned PE,
    unsigned WBits,          // ⚠️ 不叫 WIDTH 了
    unsigned ColIdxWidth
>
void DenseParamStream_to_CSR_Streams(
    hls::stream< ap_uint<PE*SIMD*WBits> > &dense_param_stream,
    hls::stream< ap_uint<PE*SIMD*ColIdxWidth> > &colidx_stream,
    hls::stream< ap_uint<PE*SIMD*WBits> > &val_stream,
    hls::stream< ap_uint<PE*16> > &rowlen_stream,
    unsigned const reps_times_ofm
) {
    const unsigned SF = MatrixW / SIMD;   // e.g. 36/2 = 18
    const unsigned NF = MatrixH / PE;     // e.g. 16/2 = 8

    // 对每一个输出像素（OFM tile）都要走一遍
    for (unsigned rep = 0; rep < reps_times_ofm; ++rep) {
        for (unsigned nf = 0; nf < NF; ++nf) {

            // 把这一组 PE 行的东西先拉到本地
            ap_uint<ColIdxWidth> idx_buf[PE][MatrixW];
#pragma HLS ARRAY_PARTITION variable=idx_buf complete dim=1
            ap_uint<WBits>       val_buf[PE][MatrixW];
#pragma HLS ARRAY_PARTITION variable=val_buf complete dim=1
            unsigned row_len[PE];
#pragma HLS ARRAY_PARTITION variable=row_len complete dim=0

            for (unsigned pe = 0; pe < PE; ++pe) {
#pragma HLS UNROLL
                row_len[pe] = 0;
            }

            // 读这一组的所有 dense tiles（这里顺序就是 FINN 的顺序）
            for (unsigned sf = 0; sf < SF; ++sf) {
#pragma HLS PIPELINE II=1
                ap_uint<PE*SIMD*WBits> word = dense_param_stream.read();

                for (unsigned pe = 0; pe < PE; ++pe) {
#pragma HLS UNROLL
                    for (unsigned s = 0; s < SIMD; ++s) {
#pragma HLS UNROLL
                        const unsigned slot = pe*SIMD + s;
                        const unsigned lo = slot * WBits;
                        const unsigned hi = lo + WBits - 1;
                        ap_uint<WBits> wbits = word.range(hi, lo);

                        // 这里先不要真稀疏，保证数值对齐
                        // const bool keep = false;     // (wbits != 0);

                        // if (keep) {
                        //     unsigned pos = row_len[pe];
                        //     idx_buf[pe][pos] = sf*SIMD + s;   // 真正的列号
                        //     val_buf[pe][pos] = wbits;
                        //     row_len[pe] = pos + 1;
                        // }
                        bool keep = csr_keep_rule(rep, nf, pe, sf*SIMD + s, wbits);
                        if (keep) {
                            unsigned pos = row_len[pe];
                            idx_buf[pe][pos] = sf*SIMD + s;
                            val_buf[pe][pos] = wbits;
                            row_len[pe] = pos + 1;
                        }
                    }
                }
            }

            // 行长先发出去
            ap_uint<PE*16> packed_len = 0;
            unsigned max_len = 0;
            for (unsigned pe = 0; pe < PE; ++pe) {
#pragma HLS UNROLL
                packed_len.range((pe+1)*16-1, pe*16) = row_len[pe];
                if (row_len[pe] > max_len) max_len = row_len[pe];
            }
            rowlen_stream.write(packed_len);

            // 这一组最多要几拍
            const unsigned tiles_needed = (max_len + SIMD - 1) / SIMD;

            // 按拍输出 CSR
            for (unsigned t = 0; t < tiles_needed; ++t) {
#pragma HLS PIPELINE II=1
                ap_uint<PE*SIMD*ColIdxWidth> packed_idx = 0;
                ap_uint<PE*SIMD*WBits>       packed_val = 0;

                for (unsigned pe = 0; pe < PE; ++pe) {
#pragma HLS UNROLL
                    const unsigned start  = t * SIMD;
                    const unsigned remain = (row_len[pe] > start) ? (row_len[pe] - start) : 0;
                    const unsigned lanes  = (remain > SIMD) ? SIMD : remain;

                    for (unsigned s = 0; s < SIMD; ++s) {
#pragma HLS UNROLL
                        const unsigned slot = pe*SIMD + s;
                        if (s < lanes) {
                            ap_uint<ColIdxWidth> col = idx_buf[pe][start + s];
                            ap_uint<WBits>       val = val_buf[pe][start + s];
                            const unsigned idx_lo = slot * ColIdxWidth;
                            const unsigned idx_hi = idx_lo + ColIdxWidth - 1;
                            const unsigned val_lo = slot * WBits;
                            const unsigned val_hi = val_lo + WBits - 1;
                            packed_idx.range(idx_hi, idx_lo) = col;
                            packed_val.range(val_hi, val_lo) = val;
                        }
                        // 多出来的 lane 默认就是 0，占位
                    }
                }

                colidx_stream.write(packed_idx);
                val_stream.write(packed_val);
            }
        }
    }
}

// -----------------------------------------------------------------------------
// 3) TOP：接口保持和原 FINN 的 mvau_stream_top 一样
// -----------------------------------------------------------------------------
void Testbench_mvau_csr_stream(hls::stream<ap_uint<IFM_Channels1*INPUT_PRECISION> > & in,
                               hls::stream<ap_uint<OFM_Channels1*ACTIVATION_PRECISION> > & out,
                               unsigned int numReps)
{
#pragma HLS DATAFLOW
    const unsigned MatrixW = KERNEL_DIM * KERNEL_DIM * IFM_Channels1;  // e.g. 36
    const unsigned MatrixH = OFM_Channels1;                            // e.g. 16
    const unsigned InpPerImage = IFMDim1*IFMDim1;
    const unsigned OfmTilesPerImage = OFMDim1 * OFMDim1;
    const unsigned RepsTimesOfm = numReps * OfmTilesPerImage;

    // 输入路径（跟原来 dense 版完全一样）
    hls::stream<ap_uint<SIMD1*INPUT_PRECISION> > convInp;
    hls::stream<ap_uint<SIMD1*INPUT_PRECISION> > wa_in;

    StreamingDataWidthConverter_Batch<
        IFM_Channels1*INPUT_PRECISION,
        SIMD1*INPUT_PRECISION,
        InpPerImage
    >(in, wa_in, numReps);

    ConvolutionInputGenerator<
        KERNEL_DIM,
        IFM_Channels1,
        INPUT_PRECISION,
        IFMDim1,
        OFMDim1,
        SIMD1,
        1
    >(wa_in, convInp, numReps, ap_resource_dflt());

    // 这条是 FINN 原生的 dense 权重流（一定是对的顺序）
    hls::stream< ap_uint<PE1*SIMD1*WIDTH> > dense_param_stream;
    GenParamStream<TILE1, SIMD1, PE1, WIDTH>(
        PARAM::weights,
        dense_param_stream,
        RepsTimesOfm
    );

    // 我们要喂给 CSR 内核的 3 条流
    hls::stream< ap_uint<PE1*SIMD1*ColBits<MatrixW>::Val> > colidx_stream;
    hls::stream< ap_uint<PE1*SIMD1*WIDTH> >                 val_stream;
    hls::stream< ap_uint<PE1*16> >                          rowlen_stream;

    // 用“不会和 #define WIDTH 冲突”的函数名和模板参数把它转成 CSR
    DenseParamStream_to_CSR_Streams<
        MatrixW, MatrixH, SIMD1, PE1, WIDTH, ColBits<MatrixW>::Val
    >(
        dense_param_stream,
        colidx_stream,
        val_stream,
        rowlen_stream,
        RepsTimesOfm
    );

    // CSR 内核输出（FINN 风格）
    hls::stream< csr_pe_act_t<PE1, ACTIVATION_PRECISION> > mvOut_csr;
    // 再转成真正的 ap_uint，接 FINN 的宽度转换
    hls::stream< ap_uint<PE1*ACTIVATION_PRECISION> > mvOut_flat;

    // 调 CSR 内核 —— 内核里还是那句 outElem(pe,0,1)=...
    Matrix_Vector_Activate_CSR_Stream_Batch<
        MatrixW, MatrixH, SIMD1, PE1, ColBits<MatrixW>::Val,
        Slice<ap_uint<INPUT_PRECISION> >,
        Slice<ap_int<ACTIVATION_PRECISION> >,
        Identity,
        ap_uint<SIMD1*INPUT_PRECISION>,
        csr_pe_act_t<PE1, ACTIVATION_PRECISION>,
        PassThroughActivation<ap_uint<16> >,
        ap_uint<WIDTH>
    >(
        convInp,
        colidx_stream,
        val_stream,
        rowlen_stream,
        PassThroughActivation<ap_uint<16> >(),
        RepsTimesOfm,
        ap_resource_dsp(),
        mvOut_csr
    );

    // FINN 容器 → 普通 bit 流
convert_loop:
    for (unsigned i = 0; i < RepsTimesOfm * (OFM_Channels1 / PE1); ++i) {
#pragma HLS PIPELINE II=1
        csr_pe_act_t<PE1, ACTIVATION_PRECISION> tmp = mvOut_csr.read();
        mvOut_flat.write( (ap_uint<PE1*ACTIVATION_PRECISION>) tmp );
    }

    // 和原来 mvau_stream_top 一样的最后一步
    StreamingDataWidthConverter_Batch<
        PE1*ACTIVATION_PRECISION,
        OFM_Channels1*ACTIVATION_PRECISION,
        OFMDim1 * OFMDim1 * (OFM_Channels1 / PE1)
    >(mvOut_flat, out, numReps);
}
