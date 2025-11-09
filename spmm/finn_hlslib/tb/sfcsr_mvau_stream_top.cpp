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

#include "sfcsr_mvau.hpp"
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

// 列索引位宽（向上取整的 log2），用于 sf = MatrixW/SIMD
template<unsigned N> struct SfBits {
    enum { Val = (N <= 2) ? 1 :
                 (N <= 4) ? 2 :
                 (N <= 8) ? 3 :
                 (N <= 16)? 4 :
                 (N <= 32)? 5 :
                 (N <= 64)? 6 :
                 (N <= 128)?7 : 8 };
};

// -----------------------------------------------------------------------------
// 2) 用 FINN 原来的 dense param stream → 转成我们的 3 条 SF-CSR stream
//    注意这里的模板参数名已经换成 WBits，避免和 #define WIDTH 冲突
// -----------------------------------------------------------------------------
template<
    unsigned MatrixW,
    unsigned MatrixH,
    unsigned SIMD,
    unsigned PE,
    unsigned WBits,          // ⚠️ 不叫 WIDTH 了
    unsigned SfIdxWidth      // = SfBits<MatrixW/SIMD>::Val
>

void DenseParamStream_to_SFCSR_Streams(
    hls::stream< ap_uint<PE*SIMD*WBits> > &dense_param_stream,
    hls::stream< ap_uint<PE*SIMD*SfIdxWidth> > &sfidx_stream,
    hls::stream< ap_uint<PE*SIMD*WBits> > &val_stream,
    hls::stream< ap_uint<PE*SIMD> > &mask_stream,
    hls::stream< ap_uint<PE*16> > &rowlen_stream,
    unsigned const reps_times_ofm
) {
    const unsigned SF = MatrixW / SIMD;
    const unsigned NF = MatrixH / PE;

    for (unsigned rep = 0; rep < reps_times_ofm; ++rep) {
        for (unsigned nf = 0; nf < NF; ++nf) {

            // 行缓冲
            ap_uint<16>       row_len[PE];
#pragma HLS ARRAY_PARTITION variable=row_len complete dim=0
            ap_uint<WBits>    val_buf[PE][MatrixW];
#pragma HLS ARRAY_PARTITION variable=val_buf complete dim=1
            ap_uint<16>       col_buf[PE][MatrixW];
#pragma HLS ARRAY_PARTITION variable=col_buf complete dim=1

            for (unsigned pe = 0; pe < PE; ++pe) {
#pragma HLS UNROLL
                row_len[pe] = 0;
            }

            // 读 dense 权重，应用稀疏规则，按行收集 (val, col)
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

                        const unsigned col = sf*SIMD + s;
                        bool keep = csr_keep_rule(rep, nf, pe, col, wbits);
                        if (keep) {
                            unsigned pos = (unsigned)row_len[pe];
                            val_buf[pe][pos] = wbits;
                            col_buf[pe][pos] = col;
                            row_len[pe] = pos + 1;
                        }
                    }
                }
            }

            // 写出行长并计算 max_len
            ap_uint<PE*16> packed_len = 0;
            unsigned max_len = 0;
            for (unsigned pe = 0; pe < PE; ++pe) {
#pragma HLS UNROLL
                packed_len.range((pe+1)*16-1, pe*16) = row_len[pe];
                if (row_len[pe] > max_len) max_len = row_len[pe];
            }
            rowlen_stream.write(packed_len);

            // 分桶：按 residue s = col % SIMD；预计算 sf = col / SIMD
            ap_uint<WBits>      bucket_val[PE][SIMD][MatrixW];
#pragma HLS ARRAY_PARTITION variable=bucket_val complete dim=1
#pragma HLS ARRAY_PARTITION variable=bucket_val complete dim=2
            ap_uint<SfIdxWidth> bucket_sf [PE][SIMD][MatrixW];
#pragma HLS ARRAY_PARTITION variable=bucket_sf complete dim=1
#pragma HLS ARRAY_PARTITION variable=bucket_sf complete dim=2
            unsigned            bucket_len[PE][SIMD];
#pragma HLS ARRAY_PARTITION variable=bucket_len complete dim=1
#pragma HLS ARRAY_PARTITION variable=bucket_len complete dim=2

            for (unsigned pe = 0; pe < PE; ++pe) {
#pragma HLS UNROLL
                for (unsigned s = 0; s < SIMD; ++s) {
#pragma HLS UNROLL
                    bucket_len[pe][s] = 0;
                }
            }

            for (unsigned pe = 0; pe < PE; ++pe) {
#pragma HLS UNROLL
                const unsigned rl = (unsigned)row_len[pe];
                for (unsigned i = 0; i < rl; ++i) {
#pragma HLS PIPELINE II=1
                    ap_uint<16> col = col_buf[pe][i];
                    unsigned s = ((unsigned)col) % SIMD;
                    unsigned idx = bucket_len[pe][s]++;
                    bucket_val[pe][s][idx] = val_buf[pe][i];
                    bucket_sf [pe][s][idx] = (unsigned)col / SIMD;
                }
            }

            // 以分桶后的最大桶长作为拍数（最小必要拍数）
            unsigned tiles_max = 0;
            for (unsigned pe = 0; pe < PE; ++pe) {
#pragma HLS UNROLL
                unsigned pe_max = 0;
                for (unsigned s = 0; s < SIMD; ++s) {
#pragma HLS UNROLL
                    if (bucket_len[pe][s] > pe_max) pe_max = bucket_len[pe][s];
                }
                if (pe_max > tiles_max) tiles_max = pe_max;
            }

            // 每拍打包：slot = pe*SIMD + s；取桶的第 t 个元素，不存在则 mask=0
            for (unsigned t = 0; t < tiles_max; ++t) {
#pragma HLS PIPELINE II=1
                ap_uint<PE*SIMD*SfIdxWidth> packed_sf  = 0;
                ap_uint<PE*SIMD*WBits>      packed_val = 0;
                ap_uint<PE*SIMD>            packed_mask= 0;

                for (unsigned pe = 0; pe < PE; ++pe) {
#pragma HLS UNROLL
                    for (unsigned s = 0; s < SIMD; ++s) {
#pragma HLS UNROLL
                        const unsigned slot = pe*SIMD + s;
                        if (t < bucket_len[pe][s]) {
                            ap_uint<SfIdxWidth> sf_idx = bucket_sf[pe][s][t];
                            ap_uint<WBits>      v      = bucket_val[pe][s][t];

                            const unsigned sf_lo  = slot * SfIdxWidth;
                            const unsigned sf_hi  = sf_lo + SfIdxWidth - 1;
                            const unsigned val_lo = slot * WBits;
                            const unsigned val_hi = val_lo + WBits - 1;

                            packed_sf .range(sf_hi, sf_lo)   = sf_idx;
                            packed_val.range(val_hi, val_lo) = v;
                            packed_mask[slot] = 1;
                        } else {
                            packed_mask[slot] = 0;
                        }
                    }
                }

                sfidx_stream.write(packed_sf);
                val_stream.write(packed_val);
                mask_stream.write(packed_mask);
            }
        }
    }
}
// -----------------------------------------------------------------------------
// 3) TOP：接口保持和原 FINN 的 mvau_stream_top 一样
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
void Testbench_mvau_sfcsr_stream(hls::stream<ap_uint<IFM_Channels1*INPUT_PRECISION> > & in,
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
    hls::stream< ap_uint<PE1*SIMD1*SfBits<(MatrixW/SIMD1)>::Val> > sfidx_stream;
    hls::stream< ap_uint<PE1*SIMD1*WIDTH> >                 val_stream;
    hls::stream< ap_uint<PE1*SIMD1> >                      mask_stream;
    hls::stream< ap_uint<PE1*16> >                          rowlen_stream;

    // 用“不会和 #define WIDTH 冲突”的函数名和模板参数把它转成 CSR
    DenseParamStream_to_SFCSR_Streams<
        MatrixW, MatrixH, SIMD1, PE1, WIDTH, SfBits<(MatrixW/SIMD1)>::Val
    >(
        dense_param_stream,
        sfidx_stream,
        val_stream,
        mask_stream,
        rowlen_stream,
        RepsTimesOfm
    );

    // CSR 内核输出（FINN 风格）
    hls::stream< csr_pe_act_t<PE1, ACTIVATION_PRECISION> > mvOut_csr;
    // 再转成真正的 ap_uint，接 FINN 的宽度转换
    hls::stream< ap_uint<PE1*ACTIVATION_PRECISION> > mvOut_flat;

    // 调 CSR 内核 —— 内核里还是那句 outElem(pe,0,1)=...
    sfcsr_mvau<
        MatrixW, MatrixH, SIMD1, PE1, SfBits<(MatrixW/SIMD1)>::Val,
        Slice<ap_uint<INPUT_PRECISION> >,
        Slice<ap_int<ACTIVATION_PRECISION> >,
        Identity,
        ap_uint<SIMD1*INPUT_PRECISION>,
        csr_pe_act_t<PE1, ACTIVATION_PRECISION>,
        PassThroughActivation<ap_uint<16> >,
        ap_uint<WIDTH>
    >(
        convInp,
        sfidx_stream,
        val_stream,
        mask_stream,
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