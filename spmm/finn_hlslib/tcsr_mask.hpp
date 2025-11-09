#pragma once
#include "ap_int.h"

// ------------------------------------------------------------
// tcsr_mask.hpp
// 目的：定义 tile 级稀疏规则（是否保留某个 sf tile）。
// - 接口：bool tcsr_keep_tile(rep, nf, sf, packed_word)
// - 缺省规则：只要 packed_word(PE*SIMD*WBits) 非零，就保留该 tile。
// - 也可以把你自己的 bitmask 编译进去（例如通过外部生成的 LUT）。
// ------------------------------------------------------------

static inline bool tcsr_keep_tile(
    unsigned /*rep*/,
    unsigned /*nf*/,
    unsigned /*sf*/,
    ap_uint<1024> packed_word_any_width // 只用于零判断，位宽不重要
) {
    // 缺省策略：非零即保留
    return (packed_word_any_width != 0);
}

// 可选：如果你有预先计算好的 tile 掩码（例如 NF x SF 的二维表），可以把它编进来。
// 下面给出一个例子（关掉注释即可启用）：
//
// constexpr unsigned TCSR_NF = 8;     // = MatrixH/PE
// constexpr unsigned TCSR_SF = 18;    // = MatrixW/SIMD
// static const bool TCSR_TILE_MASK[TCSR_NF][TCSR_SF] = { /* ... */ };
//
// static inline bool tcsr_keep_tile(
//     unsigned /*rep*/, unsigned nf, unsigned sf, ap_uint<1> /*unused*/) {
//     return TCSR_TILE_MASK[nf][sf];
// }
