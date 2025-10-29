#include <hls_stream.h>
using namespace hls;
#include "ap_int.h"
#include "bnn-library.h"

#include "mvau.hpp"
#include "weights.hpp"
#include "activations.hpp"
#include "interpret.hpp"

// user-provided configuration & params
#include "data/mvau_config.h"
#include "data/mvau_params.h" // must define: object `weights` and object `activation`

template<
  unsigned MatrixW, unsigned MatrixH, unsigned SIMD, unsigned PE, unsigned MMV,
  typename TSrcI, typename TDstI, typename TWeightI, typename TW, typename TA, typename R
>
void Testbench_mvau_static(stream< ap_uint<MMV * SIMD * TSrcI::width> > &in,
                           stream< ap_uint<MMV * PE   * TDstI::width> > &out,
                           TW const &weights_obj,
                           TA const &activation_obj,
                           const unsigned int numReps) {
  typedef ap_uint<MMV * SIMD * TSrcI::width> TI;
  typedef ap_uint<MMV * PE * TDstI::width>   TO;

  R r;

  Matrix_Vector_Activate_Batch<
    MatrixW, MatrixH, SIMD, PE, MMV,
    TSrcI, TDstI, TWeightI,
    TI, TO,
    TW, TA, R
  >(in, out, weights_obj, activation_obj, numReps, r);
}

// Provide a default instantiation driven by mvau_config.h and params in mvau_params.h
void Testbench_mvau_static_inst(stream< ap_uint<MMV * SIMD * TSrcI::width> > &in,
                                stream< ap_uint<MMV * PE   * TDstI::width> > &out,
                                const unsigned int numReps) {
  extern const decltype(weights) weights;
  extern const decltype(activation) activation;
  Testbench_mvau_static<MatrixW, MatrixH, SIMD, PE, MMV, TSrcI, TDstI, TWeightI, decltype(weights), decltype(activation), R>(in, out, weights, activation, numReps);
}