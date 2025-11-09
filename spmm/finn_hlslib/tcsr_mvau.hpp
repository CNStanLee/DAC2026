#pragma once
#include "ap_int.h"
#include "hls_stream.h"

// ------------------------------------------------------------
// tcsr_mvau.hpp  (v2)
//   - act_stream: 仅包含 global_mask[sf]==1 的激活 tiles（一次/rep）
//   - val_stream: 以 (sf, nf) 的嵌套顺序输出，对应 mask_nf[nf][sf]==1 才有一个权重 tile
//   - gmask_stream: 每个 rep 一条，SF 比特
//   - nfmask_stream: 每个 rep 有 NF 条，每条 SF 比特；内核在每个 rep 开头读入到寄存器
// ------------------------------------------------------------

template<
    unsigned MatrixW,
    unsigned MatrixH,
    unsigned SIMD,
    unsigned PE,
    unsigned INPW,
    unsigned WBITS,
    unsigned ACTW,
    typename OutContainer
>
void Matrix_Vector_Activate_TCSR_Stream_Batch(
    hls::stream< ap_uint<SIMD*INPW> > &act_stream,
    hls::stream< ap_uint<PE*SIMD*WBITS> > &val_stream,
    hls::stream< ap_uint< (MatrixW/SIMD) > > &gmask_stream,
    hls::stream< ap_uint< (MatrixW/SIMD) > > &nfmask_stream,
    unsigned reps_times_ofm,
    hls::stream< OutContainer > &out_stream
) {
#pragma HLS INLINE off
    const unsigned SF = MatrixW / SIMD;
    const unsigned NF = MatrixH / PE;

    // 主循环：每个 OFM 空间位置（rep）
    for (unsigned rep = 0; rep < reps_times_ofm; ++rep) {
        // 读入本 rep 的 global mask（驱动激活读取）
        ap_uint<SF> gmask = gmask_stream.read();

        // 读入 NF 条 per-nf mask，缓存在寄存器/BRAM
        ap_uint<SF> nfmask[128]; // NF <= 128 假设
#pragma HLS BIND_STORAGE variable=nfmask type=rom_1p impl=lutram
        for (unsigned nf = 0; nf < NF; ++nf) {
#pragma HLS PIPELINE II=1
            nfmask[nf] = nfmask_stream.read();
        }

        // 累加器：为每个 nf 保留一组 PE 累加
        ap_int<ACTW+8> acc[128][PE];
#pragma HLS ARRAY_PARTITION variable=acc complete dim=2
        // 初始化
        for (unsigned nf = 0; nf < NF; ++nf) {
#pragma HLS UNROLL factor=1
            for (unsigned p=0; p<PE; ++p) acc[nf][p] = 0;
        }

        // 遍历 sf：global==1 才读取激活；对所有 nf 检查 mask_nf[nf][sf] 决定是否读权重并 MAC
        for (unsigned sf = 0; sf < SF; ++sf) {
#pragma HLS PIPELINE II=1
            ap_uint<SIMD*INPW> a_word = 0;
            if (gmask[sf]) {
                a_word = act_stream.read();
            }

            for (unsigned nf = 0; nf < NF; ++nf) {
#pragma HLS UNROLL factor=1
                if (nfmask[nf][sf]) {
                    ap_uint<PE*SIMD*WBITS> w_word = val_stream.read();
                    // 逐 lane MAC
                    for (unsigned s = 0; s < SIMD; ++s) {
#pragma HLS UNROLL
                        const unsigned a_lo = s*INPW;
                        const unsigned a_hi = a_lo + INPW - 1;
                        ap_uint<INPW> a = a_word.range(a_hi, a_lo);
                        for (unsigned p = 0; p < PE; ++p) {
#pragma HLS UNROLL
                            const unsigned w_slot = p*SIMD + s;
                            const unsigned w_lo = w_slot*WBITS;
                            const unsigned w_hi = w_lo + WBITS - 1;
                            ap_uint<WBITS> w = w_word.range(w_hi, w_lo);
                            acc[nf][p] += a * w;
                        }
                    }
                }
            }
        }

        // 输出 NF 个结果（每个 nf 一个 FINN 容器）
        for (unsigned nf = 0; nf < NF; ++nf) {
#pragma HLS PIPELINE II=1
            OutContainer outElem;
#pragma HLS AGGREGATE variable=outElem
            for (unsigned p=0; p<PE; ++p) {
#pragma HLS UNROLL
                ap_int<ACTW> q = (ap_int<ACTW>)acc[nf][p];
                outElem(p, 0, 1) = q;
            }
            out_stream.write(outElem);
        }
    }
}
