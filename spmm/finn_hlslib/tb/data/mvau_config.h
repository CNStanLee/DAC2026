// #pragma once
// // Minimal configuration for MVAU testbenches.
// // You can override any of these via -D macros at compile time.

// #include <ap_int.h>

// // --- Geometry ---
// #ifndef MatrixW
// #define MatrixW 64     // input features per neuron
// #endif

// #ifndef MatrixH
// #define MatrixH 32     // number of neurons (outputs)
// #endif

// #ifndef SIMD
// #define SIMD 4         // parallelism over input channels
// #endif

// #ifndef PE
// #define PE 2           // parallelism over output channels
// #endif

// #ifndef MMV
// #define MMV 1          // multi-vector (pixels) parallelism
// #endif

// #ifndef NUM_REPEAT
// #define NUM_REPEAT 1   // default number of repetitions in tb
// #endif

// // Derived folding factors (compile-time guards)
// static_assert((MatrixW % SIMD) == 0, "MatrixW must be divisible by SIMD");
// static_assert((MatrixH % PE)   == 0, "MatrixH must be divisible by PE");

// #define SF (MatrixW / SIMD)
// #define NF (MatrixH / PE)

// // Notes:
// // - We deliberately do NOT force particular functors for TSrcI/TDstI/TWeightI here.
// //   The templates in mvau.hpp default them to Identity, which matches most FINN-HLS examples.
// // - The 'R' (resource) template parameter is passed through to mac<>() in mvau.hpp.
// //   Your top/tb can pass a dummy tag object if you don't want to specialize resources.


// // --- Bitwidth traits for I/O and weights (used by TB packing) ---
// struct TSrcI { static const int width = 8;  };
// struct TDstI { static const int width = 16; };
// struct TWeightI { static const int width = 8; };

// // --- Resource tag (forwarded to MVAU template) ---
// struct R {};
#pragma once
// Configuration for MVAU testbenches.

#include <ap_int.h>

// ============================================================
// 矩阵尺寸 & 并行度
// ============================================================

#ifndef MatrixW
#define MatrixW 64     // input features per neuron
#endif

#ifndef MatrixH
#define MatrixH 32     // number of neurons (outputs)
#endif

#ifndef SIMD
#define SIMD 4         // SIMD lanes
#endif

#ifndef PE
#define PE 2           // processing elements
#endif

#ifndef MMV
#define MMV 1          // multi-vector
#endif

// folds，和 mvau.hpp 里的一致：
// NF = MatrixH / PE  (垂直方向折叠数)
// SF = MatrixW / SIMD(水平方向折叠数)
#ifndef NF
#define NF (MatrixH / PE)
#endif

#ifndef SF
#define SF (MatrixW / SIMD)
#endif

// ============================================================
// Bitwidth & Interface Traits
// 这些类型在 mvau.hpp 中作为模板参数 TSrcI/TDstI/TWeightI 使用，
// 并且会以仿函数形式被调用：
//   TWeightI()(w[pe])
//   TSrcI()(inElem, mmv)
//   TDstI().template operator()<TO>()
// ============================================================

// 输入 bitwidth + 读取/解释输入的 functor
struct TSrcI {
  // 单个通道的位宽
  static const int width = 8;

  // inElem: 打包后的输入（例如 ap_uint<MMV * SIMD * width>）
  // mmv   : multi-vector index（简单实现里可以忽略）
  template<typename TIn>
  TIn operator()(const TIn &inElem, const unsigned & /*mmv*/) const {
    // 最简单：直接返回整块数据，由 MVAU 内部再按位切分
    return inElem;
  }
};

// 输出 bitwidth + 构造输出元素的 functor
struct TDstI {
  static const int width = 16;

  // mvau.hpp 里用：TDstI().template operator()<TO>()
  template<typename TOut>
  TOut operator()() const {
    // 零初始化，后续会被写入真正结果
    return 0;
  }
};

// 权重 bitwidth + 从权重存储中取出一片的 functor
struct TWeightI {
  static const int width = 8;

  // w_slice 一般是 ap_uint<SIMD * width> 或类似打包类型
  template<typename TSlice>
  TSlice operator()(const TSlice &w_slice) const {
    // 简单 identity：原样返回
    return w_slice;
  }
};

// 资源标记类型，直接透传给 Matrix_Vector_Activate_Batch 的模板参数
// struct R {};
using R = ap_resource_lut;

