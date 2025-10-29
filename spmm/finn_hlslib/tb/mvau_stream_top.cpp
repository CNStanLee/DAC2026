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
#include "data/mvau_params.h" // must define: object `activation`

template<
  unsigned MatrixW, unsigned MatrixH, unsigned SIMD, unsigned PE,
  typename TSrcI, typename TDstI, typename TWeightI, typename TW, typename TA, typename R
>
void Testbench_mvau_stream(stream< ap_uint<SIMD * TSrcI::width> > &in,
                           stream< ap_uint<PE   * TDstI::width> > &out,
                           stream< ap_uint<PE * SIMD * TW::width> > &wstream,
                           TA const &activation_obj,
                           const unsigned int numReps) {
  typedef ap_uint<SIMD * TSrcI::width> TI;
  typedef ap_uint<PE * TDstI::width>   TO;

  R r;

  Matrix_Vector_Activate_Stream_Batch<
    MatrixW, MatrixH, SIMD, PE,
    TSrcI, TDstI, TWeightI, TW,
    TI, TO, TA, R
  >(in, out, wstream, activation_obj, numReps, r);
}

// Provide a default instantiation driven by mvau_config.h
void Testbench_mvau_stream_inst(stream< ap_uint<SIMD * TSrcI::width> > &in,
                                stream< ap_uint<PE   * TDstI::width> > &out,
                                stream< ap_uint<PE * SIMD * TWeightI::width> > &wstream,
                                const unsigned int numReps) {
  extern const decltype(activation) activation;
  Testbench_mvau_stream<MatrixW, MatrixH, SIMD, PE, TSrcI, TDstI, TWeightI, TWeightI, decltype(activation), R>(in, out, wstream, activation, numReps);
}