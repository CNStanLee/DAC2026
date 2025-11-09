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

#include "tcsr_mvau.hpp"
#include "tcsr_mask.hpp"

// FINN 风格输出容器（与 CSR 版本一致）
template<unsigned PE, unsigned ACTW>
struct tcsr_pe_act_t {
    ap_uint<PE*ACTW> v;
    ap_range_ref<PE*ACTW, false> operator()(unsigned pe, unsigned, unsigned) {
        return v.range((pe+1)*ACTW-1, pe*ACTW);
    }
    ap_range_ref<PE*ACTW, false> operator()(unsigned pe, unsigned, unsigned) const {
        return const_cast<ap_uint<PE*ACTW>&>(v).range((pe+1)*ACTW-1, pe*ACTW);
    }
    ap_range_ref<PE*ACTW, false> operator()(unsigned pe, unsigned) {
        return v.range((pe+1)*ACTW-1, pe*ACTW);
    }
    ap_range_ref<PE*ACTW, false> operator()(unsigned pe, unsigned) const {
        return const_cast<ap_uint<PE*ACTW>&>(v).range((pe+1)*ACTW-1, pe*ACTW);
    }
    operator ap_uint<PE*ACTW>() const { return v; }
};

// dense → TCSR：输出三条流
//   - gmask_stream: 每 rep 1 条（SF bits，nf OR）
//   - nfmask_stream: 每 rep*NF 条（每条 SF bits）
//   - val_stream: 以 (sf,nf) 顺序发，仅当 nfmask[nf][sf]==1 时发一个 tile
template<
    unsigned MatrixW,
    unsigned MatrixH,
    unsigned SIMD,
    unsigned PE,
    unsigned WBITS
>
void DenseParamStream_to_TCSR_Streams(
    hls::stream< ap_uint<PE*SIMD*WBITS> > &dense_param_stream,
    hls::stream< ap_uint< (MatrixW/SIMD) > > &gmask_stream,
    hls::stream< ap_uint< (MatrixW/SIMD) > > &nfmask_stream,
    hls::stream< ap_uint<PE*SIMD*WBITS> > &val_stream,
    unsigned reps_times_ofm
) {
    const unsigned SF = MatrixW / SIMD;
    const unsigned NF = MatrixH / PE;

    // 局部缓存
    ap_uint< (MatrixW/SIMD) > nf_mask[128];                   // NF 个掩码
#pragma HLS BIND_STORAGE variable=nf_mask type=ram_1p impl=lutram
    ap_uint<PE*SIMD*WBITS> tile_buf[128][512];                // [NF][最多SF] 权重临存
#pragma HLS BIND_STORAGE variable=tile_buf type=ram_1p impl=bram

    for (unsigned rep = 0; rep < reps_times_ofm; ++rep) {
        // 逐 nf 读取 SF 个 dense tiles，决定保留并缓存，同时构建 per-nf mask
        for (unsigned nf = 0; nf < NF; ++nf) {
            nf_mask[nf] = 0;
            unsigned kept = 0;
            for (unsigned sf = 0; sf < SF; ++sf) {
#pragma HLS PIPELINE II=1
                ap_uint<PE*SIMD*WBITS> word = dense_param_stream.read();
                bool keep = tcsr_keep_tile(rep, nf, sf, (ap_uint<1024>)word);
                if (keep) {
                    nf_mask[nf][sf] = 1;
                    tile_buf[nf][kept++] = word;
                }
            }
            // 用 nf_mask[nf] 的 popcount 决定之后会从 tile_buf[nf][*] 取多少个
            // （无需在此处输出）
        }

        // 生成并输出 global 掩码 = 所有 nf 掩码 OR
        ap_uint<SF> gmask = 0;
        for (unsigned nf = 0; nf < NF; ++nf) gmask |= nf_mask[nf];
        gmask_stream.write(gmask);

        // 先输出所有 per-nf 掩码（供内核预读）
        for (unsigned nf = 0; nf < NF; ++nf) {
#pragma HLS PIPELINE II=1
            nfmask_stream.write(nf_mask[nf]);
        }

        // 再按照 (sf, nf) 的顺序输出每一个被保留的 tile 值
        // 注意：为了顺序正确，这里需要“游标”记住每个 nf 已输出多少个 tile
        unsigned cursor[128];
#pragma HLS ARRAY_PARTITION variable=cursor complete
        for (unsigned nf=0; nf<NF; ++nf) cursor[nf]=0;

        for (unsigned sf = 0; sf < SF; ++sf) {
#pragma HLS PIPELINE II=1
            if (gmask[sf]) {
                for (unsigned nf = 0; nf < NF; ++nf) {
#pragma HLS UNROLL factor=1
                    if (nf_mask[nf][sf]) {
                        ap_uint<PE*SIMD*WBITS> w = tile_buf[nf][ cursor[nf]++ ];
                        val_stream.write(w);
                    }
                }
            }
        }
    }
}

// 利用 global 掩码对卷积输入 tiles 做过滤
template<
    unsigned MatrixW,
    unsigned SIMD,
    unsigned INPW
>
void Filter_Activation_Tiles(
    hls::stream< ap_uint<SIMD*INPW> > &dense_act,
    hls::stream< ap_uint< (MatrixW/SIMD) > > &gmask_stream,
    unsigned reps_times_ofm,
    hls::stream< ap_uint<SIMD*INPW> > &act_kept
) {
    const unsigned SF = MatrixW / SIMD;

    for (unsigned rep = 0; rep < reps_times_ofm; ++rep) {
        ap_uint<SF> gmask = gmask_stream.read();
        for (unsigned sf = 0; sf < SF; ++sf) {
#pragma HLS PIPELINE II=1
            ap_uint<SIMD*INPW> a = dense_act.read();
            if (gmask[sf]) act_kept.write(a);
        }
    }
}

// -------------------------------
// TOP：接口保持与原 dense/CSR 一样
// -------------------------------
void Testbench_mvau_tcsr_stream(hls::stream<ap_uint<IFM_Channels1*INPUT_PRECISION> > & in,
                                hls::stream<ap_uint<OFM_Channels1*ACTIVATION_PRECISION> > & out,
                                unsigned int numReps)
{
#pragma HLS DATAFLOW
    const unsigned MatrixW = KERNEL_DIM * KERNEL_DIM * IFM_Channels1;
    const unsigned MatrixH = OFM_Channels1;
    const unsigned SF = MatrixW / SIMD1;
    const unsigned NF = MatrixH / PE1;
    const unsigned InpPerImage = IFMDim1 * IFMDim1;
    const unsigned OfmTilesPerImage = OFMDim1 * OFMDim1;
    const unsigned RepsTimesOfm = numReps * OfmTilesPerImage;

    // 1) 输入路径：宽度转换 + 卷积输入生成（全量）
    hls::stream<ap_uint<SIMD1*INPUT_PRECISION> > wa_in;
    hls::stream<ap_uint<SIMD1*INPUT_PRECISION> > convInp_dense;
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
    >(wa_in, convInp_dense, numReps, ap_resource_dflt());

    // 2) 参数路径：生成 FINN 原生 dense param stream（每 rep 提供 NF*SF 次）
    hls::stream< ap_uint<PE1*SIMD1*WIDTH> > dense_param_stream;
    GenParamStream<TILE1, SIMD1, PE1, WIDTH>(
        PARAM::weights,
        dense_param_stream,
        RepsTimesOfm
    );

    // 3) dense → TCSR：得到 gmask、nfmask、val 三条流
    hls::stream< ap_uint<SF> > gmask_stream_from_param;
    hls::stream< ap_uint<SF> > nfmask_stream;
    hls::stream< ap_uint<PE1*SIMD1*WIDTH> > val_stream;
    DenseParamStream_to_TCSR_Streams<
        MatrixW, MatrixH, SIMD1, PE1, WIDTH
    >(
        dense_param_stream,
        gmask_stream_from_param,
        nfmask_stream,
        val_stream,
        RepsTimesOfm
    );

    // 4) 复制 global 掩码：一份给激活过滤，一份给内核
    hls::stream< ap_uint<SF> > gmask_to_filter, gmask_to_kernel;
    for (unsigned i = 0; i < RepsTimesOfm; ++i) {
#pragma HLS PIPELINE II=1
        ap_uint<SF> g = gmask_stream_from_param.read();
        gmask_to_filter.write(g);
        gmask_to_kernel.write(g);
    }

    // 5) 用 global 掩码过滤激活 tiles（把 SF 压缩成 |gmask|）
    hls::stream< ap_uint<SIMD1*INPUT_PRECISION> > convInp_kept;
    Filter_Activation_Tiles<
        MatrixW, SIMD1, INPUT_PRECISION
    >(convInp_dense, gmask_to_filter, RepsTimesOfm, convInp_kept);

    // 6) 调用 TCSR 内核，生成 FINN 风格输出容器
    hls::stream< tcsr_pe_act_t<PE1, ACTIVATION_PRECISION> > mvOut_tcsr;
    Matrix_Vector_Activate_TCSR_Stream_Batch<
        MatrixW, MatrixH, SIMD1, PE1,
        INPUT_PRECISION, WIDTH, ACTIVATION_PRECISION,
        tcsr_pe_act_t<PE1, ACTIVATION_PRECISION>
    >(
        convInp_kept,
        val_stream,
        gmask_to_kernel,
        nfmask_stream,
        RepsTimesOfm,
        mvOut_tcsr
    );

    // 7) 容器 → bit 流 → 最终宽度转换
    hls::stream< ap_uint<PE1*ACTIVATION_PRECISION> > mvOut_flat;
    for (unsigned i = 0; i < RepsTimesOfm * NF; ++i) {
#pragma HLS PIPELINE II=1
        tcsr_pe_act_t<PE1, ACTIVATION_PRECISION> tmp = mvOut_tcsr.read();
        mvOut_flat.write( (ap_uint<PE1*ACTIVATION_PRECISION>) tmp );
    }

    StreamingDataWidthConverter_Batch<
        PE1*ACTIVATION_PRECISION,
        OFM_Channels1*ACTIVATION_PRECISION,
        OFMDim1 * OFMDim1 * (OFM_Channels1 / PE1)
    >(mvOut_flat, out, numReps);
}
