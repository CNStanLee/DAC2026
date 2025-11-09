
#ifndef SFCSR_MVAU_HPP
#define SFCSR_MVAU_HPP

#include <hls_stream.h>
#include "ap_int.h"

// SF-CSR MVAU：只传 sf = col/SIMD + mask；隐含 lan = s（方案A，分桶发送）
template<
  unsigned MatrixW,
  unsigned MatrixH,
  unsigned SIMD,
  unsigned PE,
  unsigned SfIdxWidth,
  typename TSrcI,
  typename TDstI,
  typename TWeightI,
  typename TI,
  typename TO,
  typename TA,
  typename TW,
  typename R
>
void sfcsr_mvau(
    hls::stream<TI> &in,                                            // 激活（折成 SF 段）
    hls::stream<ap_uint<PE*SIMD*SfIdxWidth>> &sfidx_stream,         // 每拍每 slot 的 sf（= col/SIMD）
    hls::stream<ap_uint<PE*SIMD*TW::width>>   &val_stream,          // 每拍每 slot 的权重
    hls::stream<ap_uint<PE*SIMD>>             &mask_stream,         // 每拍每 slot 的有效位（1=有效）
    hls::stream<ap_uint<PE*16>>               &rowlen_stream,       // 每行非零个数
    TA  const  &activation,
    int const   reps,
    R   const  &r,
    hls::stream<TO> &out)
{
  const unsigned SF = MatrixW / SIMD;
  const unsigned NF = MatrixH / PE;

  // 缓存输入激活（SF 段）
  TI actBuf[SF];
#pragma HLS ARRAY_PARTITION variable=actBuf complete dim=1

  // 累加器 per-PE
  decltype(activation.init(0,0)) accu[PE];
#pragma HLS ARRAY_PARTITION variable=accu complete dim=0

rep_loop:
  for (int rep = 0; rep < reps; ++rep) {

  // 1) 读取输入向量
  load_act:
    for (unsigned sf = 0; sf < SF; ++sf) {
#pragma HLS PIPELINE II=1
      actBuf[sf] = in.read();
    }

  // 2) 处理每一组 PE 行
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
        accu[pe] = activation.init(nf, pe);
      }

      // 固定上界拍数（与发送端一致，发送端将 <= 此上界）：
      const unsigned tiles_max = max_len;

      // 记录每个 PE 已消费的非零数；当 consumed[pe] == row_len[pe] 时该行完成
      unsigned consumed[PE];
#pragma HLS ARRAY_PARTITION variable=consumed complete dim=0
      for (unsigned pe = 0; pe < PE; ++pe) {
#pragma HLS UNROLL
        consumed[pe] = 0;
      }

    // 3) 主计算：按拍读取 sf/mask/val；隐含 lan = s
    t_loop:
      for (unsigned t = 0; t < tiles_max; ++t) {
#pragma HLS PIPELINE II=1
        ap_uint<PE*SIMD>                    valid_mask = mask_stream.read();
        ap_uint<PE*SIMD*SfIdxWidth>         packed_sf  = sfidx_stream.read();
        ap_uint<PE*SIMD*TW::width>          packed_val = val_stream.read();

      pe_loop:
        for (unsigned pe = 0; pe < PE; ++pe) {
#pragma HLS UNROLL
          unsigned added = 0;
        lane_loop:
          for (unsigned s = 0; s < SIMD; ++s) {
#pragma HLS UNROLL
            const unsigned slot = pe*SIMD + s;
            if (valid_mask[slot]) {
              // 解出 sf（而非 col），隐含 lan = s
              const unsigned sf_lo = slot * SfIdxWidth;
              const unsigned sf_hi = sf_lo + SfIdxWidth - 1;
              ap_uint<SfIdxWidth> sf = packed_sf.range(sf_hi, sf_lo);

              // 取该 sf 的激活向量
              TI inElem = actBuf[(unsigned)sf];
              auto act_vec = TSrcI()(inElem, 0);

              // 取该 slot 的权重词，塞到 lane s，其它 lane 清零
              const unsigned val_lo = slot * TW::width;
              const unsigned val_hi = val_lo + TW::width - 1;
              ap_uint<TW::width> w_lane = packed_val.range(val_hi, val_lo);

              ap_uint<SIMD * TW::width> w_full = 0;
              const unsigned w_lo = s * TW::width;
              const unsigned w_hi = w_lo + TW::width - 1;
              w_full.range(w_hi, w_lo) = w_lane;

              auto wgt = TWeightI()(w_full);
              accu[pe] = mac<SIMD>(accu[pe], wgt, act_vec, r, 0);
              added += 1;
            }
          } // lane_loop
          consumed[pe] += added;
        }   // pe_loop

        // 若所有 PE 行都已消费完，则提前结束
        bool all_done = true;
        for (unsigned pe = 0; pe < PE; ++pe) {
#pragma HLS UNROLL
          if (consumed[pe] < row_len[pe]) { all_done = false; }
        }
        if (all_done) { break; }
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

#endif // SFCSR_MVAU_HPP