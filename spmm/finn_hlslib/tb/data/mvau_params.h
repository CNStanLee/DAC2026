#pragma once
// Parameters (weights/thresholds/bias) for MVAU testbenches.
// This header MUST define an 'activation' object with .init() and .activate() as
// expected by mvau.hpp.

#include <ap_int.h>
#include "data/mvau_config.h"

// A very simple activation/bias helper that complies with mvau.hpp expectations.
// - init(nf, pe) returns the accumulator reset value (use as bias per PE if desired).
// - activate(nf, pe, acc) applies nonlinearity / quantization and returns output element.
// For quick bring-up we implement identity with optional per-PE bias.
struct MVAUActivation {
  // Accumulator type (you can widen this if your MAC grows larger)
  using accum_t = ap_int<32>;

  // Optional biases per PE (default zero). You can edit these or generate them.
  // Size is PE; if you want per-fold/per-PE bias, extend indexing with nf.
  static accum_t kBias(unsigned pe) {
    (void)pe;
    return 0;
  }

  // Reset accumulator for a given folded neuron (nf) and PE lane.
  inline accum_t init(unsigned /*nf*/, unsigned pe) const {
    return kBias(pe);
  }

  // Identity activation: simply forward the accumulator.
  // You can replace this with thresholding (e.g., return acc > thr ? 1 : 0;)
  template <typename ACC_T>
  inline ACC_T activate(unsigned /*nf*/, unsigned /*pe*/, const ACC_T &acc) const {
    return acc;
  }
};

// Provide the required global 'activation' object.
// Use 'inline' to avoid multiple-definition across translation units (C++17).
static const MVAUActivation activation{};



// Minimal weights provider to satisfy testbench expectations for static and stream modes.
// Provides a .weights(tile) accessor returning PE slices of SIMD*TWeightI::width bits each.
struct DummyWeights {
  typedef ap_uint<SIMD * TWeightI::width> slice_t;
  // Return a pointer to PE slices; here we just return zeros for all tiles/PEs.
  const slice_t* weights(unsigned /*tile*/) const {
    // static so the pointer remains valid after return
    static slice_t pack[PE];
#pragma HLS ARRAY_PARTITION variable=pack complete dim=1
    for (int pe = 0; pe < PE; ++pe) pack[pe] = 0;
    return pack;
  }
};

// Global weights object
static const DummyWeights weights;
