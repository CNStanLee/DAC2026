// csr_mask.hpp
#pragma once
#include "ap_int.h"

// 统一的稀疏规则：现在就是你刚才的 keep = false
// 后面你想换成 (wbits != 0) 或者读一张 mask 表都可以改这里
inline bool csr_keep_rule(
    unsigned rep,
    unsigned nf,
    unsigned pe,
    unsigned col,
    ap_uint<WIDTH> wbits
) {
    //return (wbits != 0);      // 原版：和dense一样
    return (col % 2) == 0;    // 示例：剪一半
    //return (col % 10) == 0;    // 示例：剪90%
    //return false;                // 你现在的实验：全剪
}
