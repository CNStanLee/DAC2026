#ifndef CSR_MVAU_HPP
#define CSR_MVAU_HPP

#include <hls_stream.h>
#include "ap_int.h"

// 真·CSR：每个 lane 都用自己的列号去抓激活，然后再调一次和 FINN 一样的 mac<SIMD>
template<
  unsigned MatrixW,
  unsigned MatrixH,
  unsigned SIMD,
  unsigned PE,
  unsigned ColIdxWidth,
  typename TSrcI,
  typename TDstI,
  typename TWeightI,
  typename TI,
  typename TO,
  typename TA,
  typename TW,
  typename R
>
void Matrix_Vector_Activate_CSR_Stream_Batch(
    hls::stream<TI> &in,                                      // 输入激活流（折成 SF 段）
    hls::stream<ap_uint<PE*SIMD*ColIdxWidth>> &colidx_stream, // 每拍的列号（已经压缩过）
    hls::stream<ap_uint<PE*SIMD*TW::width>>   &val_stream,    // 每拍的权重（已经压缩过）
    hls::stream<ap_uint<PE*16>>               &rowlen_stream, // 每行非零个数
    TA  const  &activation,
    int const   reps,
    R   const  &r,
    hls::stream<TO> &out)
{
  // dense 的 SF / NF 一样
  const unsigned SF = MatrixW / SIMD;
  const unsigned NF = MatrixH / PE;

  // 1) 把一整条输入向量先缓存起来，后面按列号随机访问
  TI actBuf[SF];
#pragma HLS ARRAY_PARTITION variable=actBuf complete dim=1

  // 2) 累加器 per-PE
  decltype(activation.init(0,0)) accu[PE];
#pragma HLS ARRAY_PARTITION variable=accu complete dim=0

rep_loop:
  for (int rep = 0; rep < reps; ++rep) {

    // 1) 读取这一幅图的输入向量（按 dense 的顺序 0..SF-1）
  load_act:
    for (unsigned sf = 0; sf < SF; ++sf) {
#pragma HLS PIPELINE II=1
      actBuf[sf] = in.read();
    }

    // 2) 对每一组 PE 行
  nf_loop:
    for (unsigned nf = 0; nf < NF; ++nf) {

      // 行长
      ap_uint<PE*16> packed_len = rowlen_stream.read();
      unsigned row_len[PE];
#pragma HLS ARRAY_PARTITION variable=row_len complete dim=0

      unsigned max_len = 0;

    init_pe:
      for (unsigned pe = 0; pe < PE; ++pe) {
#pragma HLS UNROLL
        unsigned rl = packed_len.range((pe+1)*16-1, pe*16);
        row_len[pe] = rl;
        if (rl > max_len) max_len = rl;
        // 初始化阈值/accu
        accu[pe] = activation.init(nf, pe);
      }

      // 需要几拍来把这一组 PE 的所有非零吃完
      const unsigned tiles_needed = (max_len + SIMD - 1) / SIMD;

    // 3) 真·CSR 乘加
    t_loop:
      for (unsigned t = 0; t < tiles_needed; ++t) {
#pragma HLS PIPELINE II=1
        // 拿到这一拍所有 PE×SIMD 的列号和权重
        ap_uint<PE*SIMD*ColIdxWidth> packed_idx = colidx_stream.read();
        ap_uint<PE*SIMD*TW::width>   packed_val = val_stream.read();

      pe_loop:
        for (unsigned pe = 0; pe < PE; ++pe) {
#pragma HLS UNROLL
          // 这一拍之前已经消费了多少个非零
          const unsigned consumed  = t * SIMD;
          // 这一行还剩多少个非零没处理
          const unsigned remaining = (row_len[pe] > consumed) ? (row_len[pe] - consumed) : 0;
          // 这一拍实际有几个 lane 是真的
          const unsigned lanes_this_time = (remaining > SIMD) ? SIMD : remaining;

        lane_loop:
          for (unsigned s = 0; s < SIMD; ++s) {
#pragma HLS UNROLL
            if (s < lanes_this_time) {
              // -------------- ① 取出这一 lane 的列号 --------------
              const unsigned slot   = pe*SIMD + s;
              const unsigned idx_lo = slot * ColIdxWidth;
              const unsigned idx_hi = idx_lo + ColIdxWidth - 1;
              ap_uint<ColIdxWidth> col = packed_idx.range(idx_hi, idx_lo);

              // 列号 → 属于哪个 sf、是那个 sf 里的哪个 lane
              const unsigned sf  = col / SIMD;
              const unsigned lan = col % SIMD;

              // -------------- ② 取这一列对应的激活 tile --------------
              TI inElem = actBuf[sf];

              // 完整的一条 SIMD 激活（和 dense 一模一样）
              auto act_vec = TSrcI()(inElem, 0);

              // -------------- ③ 把这一 lane 的权重放到对应 lane 上 --------------
              const unsigned val_lo = slot * TW::width;
              const unsigned val_hi = val_lo + TW::width - 1;
              ap_uint<TW::width> w_lane = packed_val.range(val_hi, val_lo);

              // 我们要喂给 mac<SIMD> 的是“一整条权重词”，其他 lane 都是 0
              ap_uint<SIMD * TW::width> w_full = 0;
              const unsigned w_lo = lan * TW::width;
              const unsigned w_hi = w_lo + TW::width - 1;
              w_full.range(w_hi, w_lo) = w_lane;

              // 按 FINN 的方式做一次真正的 SIMD MAC
              auto wgt = TWeightI()(w_full);
              accu[pe] = mac<SIMD>(accu[pe], wgt, act_vec, r, 0);
            }
          } // lane_loop
        }   // pe_loop
      }     // t_loop

      // 4) 输出这一组 PE 的结果
      TO outElem = TDstI().template operator()<TO>();
    out_pe:
      for (unsigned pe = 0; pe < PE; ++pe) {
#pragma HLS UNROLL
        outElem(pe, 0, 1) = activation.activate(nf, pe, accu[pe]);
      }
      out.write(outElem);

    } // nf_loop
  }   // rep_loop
}

#endif // CSR_MVAU_HPP
