#pragma once
// Minimal configuration for MVAU testbenches.
// You can override any of these via -D macros at compile time.

#include <ap_int.h>

// --- Geometry ---
#ifndef MatrixW
#define MatrixW 64     // input features per neuron
#endif

#ifndef MatrixH
#define MatrixH 32     // number of neurons (outputs)
#endif

#ifndef SIMD
#define SIMD 4         // parallelism over input channels
#endif

#ifndef PE
#define PE 2           // parallelism over output channels
#endif

#ifndef MMV
#define MMV 1          // multi-vector (pixels) parallelism
#endif

#ifndef NUM_REPEAT
#define NUM_REPEAT 1   // default number of repetitions in tb
#endif

// Derived folding factors (compile-time guards)
static_assert((MatrixW % SIMD) == 0, "MatrixW must be divisible by SIMD");
static_assert((MatrixH % PE)   == 0, "MatrixH must be divisible by PE");

#define SF (MatrixW / SIMD)
#define NF (MatrixH / PE)

// Notes:
// - We deliberately do NOT force particular functors for TSrcI/TDstI/TWeightI here.
//   The templates in mvau.hpp default them to Identity, which matches most FINN-HLS examples.
// - The 'R' (resource) template parameter is passed through to mac<>() in mvau.hpp.
//   Your top/tb can pass a dummy tag object if you don't want to specialize resources.


// --- Bitwidth traits for I/O and weights (used by TB packing) ---
struct TSrcI { static const int width = 8;  };
struct TDstI { static const int width = 16; };
struct TWeightI { static const int width = 8; };

// --- Resource tag (forwarded to MVAU template) ---
struct R {};
