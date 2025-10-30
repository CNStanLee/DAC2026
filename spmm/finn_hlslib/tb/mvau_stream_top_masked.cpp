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

#include "csr_mask.hpp"

// ============================================================================
// 把一条 FINN 原生的权重参数流做“同一把剪枝”
// in  : ap_uint<PE*SIMD*WBits>
// out : ap_uint<PE*SIMD*WBits> (被清零的 lane 全部变 0)
// ============================================================================
template<
    unsigned MatrixW,
    unsigned MatrixH,
    unsigned SIMD,
    unsigned PE,
    unsigned WBits
>
void MaskParamStream(
    hls::stream< ap_uint<PE*SIMD*WBits> > &in,
    hls::stream< ap_uint<PE*SIMD*WBits> > &out,
    unsigned const reps_times_ofm
) {
    const unsigned SF = MatrixW / SIMD;   // 水平折叠数
    const unsigned NF = MatrixH / PE;     // 垂直折叠数
    const unsigned TOTAL = SF * NF;

    for (unsigned rep = 0; rep < reps_times_ofm; ++rep) {
        for (unsigned tile = 0; tile < TOTAL; ++tile) {
        #pragma HLS PIPELINE II=1
            ap_uint<PE*SIMD*WBits> word = in.read();

            unsigned nf = tile / SF;
            unsigned sf = tile % SF;

            // 针对本 tile 里的所有 (pe, lane) 决定要不要留
            for (unsigned pe = 0; pe < PE; ++pe) {
            #pragma HLS UNROLL
                for (unsigned s = 0; s < SIMD; ++s) {
                #pragma HLS UNROLL
                    const unsigned slot = pe*SIMD + s;
                    const unsigned lo   = slot * WBits;
                    const unsigned hi   = lo + WBits - 1;

                    ap_uint<WBits> wbits = word.range(hi, lo);
                    unsigned col = sf*SIMD + s;

                    bool keep = csr_keep_rule(
                        /*rep=*/rep,
                        /*nf =*/nf,
                        /*pe =*/pe,
                        /*col=*/col,
                        /*wbits=*/wbits
                    );

                    if (!keep) {
                        // 这一 lane 不要 → 清 0
                        word.range(hi, lo) = 0;
                    }
                }
            }

            out.write(word);
        }
    }
}

// ============================================================================
// dense 顶层的“带 mask”版本
// 和你原来项目里的 Testbench_mvau_stream 一样的接口
// ============================================================================
void Testbench_mvau_stream_masked(
    hls::stream<ap_uint<IFM_Channels1*INPUT_PRECISION> > & in,
    hls::stream<ap_uint<OFM_Channels1*ACTIVATION_PRECISION> > & out,
    unsigned int numReps)
{
#pragma HLS DATAFLOW
    // ---- 和原 dense 顶层一样的常量 ----
    const unsigned MatrixW = KERNEL_DIM * KERNEL_DIM * IFM_Channels1;
    const unsigned MatrixH = OFM_Channels1;
    const unsigned InpPerImage = IFMDim1 * IFMDim1;
    const unsigned RepsTimesOfm = numReps * OFMDim1 * OFMDim1;

    // ---- 输入路径：IFM → SIMD ----
    hls::stream<ap_uint<SIMD1*INPUT_PRECISION> > wa_in;
    hls::stream<ap_uint<SIMD1*INPUT_PRECISION> > convInp;
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

    // ---- 原生 dense 权重流（FINN 的顺序）----
    hls::stream< ap_uint<PE1*SIMD1*WIDTH> > paramStreamOut;
    GenParamStream<TILE1, SIMD1, PE1, WIDTH>(
        PARAM::weights,
        paramStreamOut,
        RepsTimesOfm
    );

    // ---- 新增：对权重流做 mask ----
    hls::stream< ap_uint<PE1*SIMD1*WIDTH> > paramStreamMasked;
    MaskParamStream<
        MatrixW,
        MatrixH,
        SIMD1,
        PE1,
        WIDTH
    >(
        paramStreamOut,
        paramStreamMasked,
        RepsTimesOfm
    );

    // ---- MVAU 输出流（PE 宽）----
    hls::stream< ap_uint<PE1*ACTIVATION_PRECISION> > mvOut;

    // ❗❗ 这里是你刚才出错的地方：
    // 不要手写 TI / TO / TA / R，让编译器自己从下面的实参推
    Matrix_Vector_Activate_Stream_Batch<
        MatrixW,
        MatrixH,
        SIMD1,
        PE1,
        Slice<ap_uint<INPUT_PRECISION> >,
        Slice<ap_int<ACTIVATION_PRECISION> >,
        Identity,
        ap_uint<WIDTH>
    >(
        convInp,               // TI 由这里推 → stream<ap_uint<SIMD1*INPUT_PRECISION>>
        mvOut,                 // TO 由这里推 → stream<ap_uint<PE1*ACTIVATION_PRECISION>>
        paramStreamMasked,     // weights → stream<ap_uint<PE1*SIMD1*WIDTH>>
        PassThroughActivation<ap_uint<16> >(),
        RepsTimesOfm,
        ap_resource_dsp()
    );

    // ---- 和原项目一样：把 PE 宽扩成 OFM 宽 ----
    StreamingDataWidthConverter_Batch<
        PE1*ACTIVATION_PRECISION,
        OFM_Channels1*ACTIVATION_PRECISION,
        OFMDim1 * OFMDim1 * (OFM_Channels1 / PE1)
    >(mvOut, out, numReps);
}
