#include <iostream>
#include <hls_stream.h>
#include "ap_int.h"
#include <cstdlib>
#include "bnn-library.h"

#include "mvau.hpp"
#include "weights.hpp"
#include "activations.hpp"
#include "interpret.hpp"

#include "data/mvau_config.h"
#include "data/mvau_params.h"

#ifndef NUM_REPEAT
#define NUM_REPEAT 1
#endif


using namespace std;
using namespace hls;

typedef ap_uint<SIMD * TSrcI::width> TI_s;
typedef ap_uint<PE   * TDstI::width> TO_s;
typedef ap_uint<MMV * SIMD * TSrcI::width> TI;
typedef ap_uint<MMV * PE   * TDstI::width> TO;
typedef ap_uint<PE * SIMD * TWeightI::width> WP;

void Testbench_mvau_stream_inst(stream<TI_s> &in,
                                stream<TO_s> &out,
                                stream< WP > &wstream,
                                const unsigned int numReps);
void Testbench_mvau_static_inst(stream<TI> &in, stream<TO> &out, const unsigned int numReps);

int main() {
stream<TI_s> in_stream("in_stream");
  stream<TO_s> out_stream("out_stream");
  stream< WP > wstream("wstream");

  // Also run the static variant for golden comparison
  stream<TI> in_static("in_static");
  stream<TO> out_static("out_static");

  // Prepare weights stream from the same weights object
  for (unsigned rep = 0; rep < NUM_REPEAT; rep++) {
    for (unsigned nf = 0; nf < NF; nf++) {
      for (unsigned sf = 0; sf < SF; sf++) {
        unsigned tile = nf * SF + sf;
        auto const &wtile = weights.weights(tile);
        WP packet = 0;
        for (unsigned pe = 0; pe < PE; pe++) {
#pragma HLS UNROLL
          ap_uint<SIMD * TWeightI::width> slice = wtile[pe];
          packet((pe+1)*SIMD*TWeightI::width-1, pe*SIMD*TWeightI::width) = slice;
        }
        wstream.write(packet);
      }
    }
  }

  // Inputs
  for (unsigned rep = 0; rep < NUM_REPEAT; rep++) {
    for (unsigned sf = 0; sf < SF; sf++) {
      ap_uint<SIMD * TSrcI::width> inword_stream = (ap_uint<SIMD * TSrcI::width>)(rep*SF + sf);
      in_stream.write(inword_stream);

      TI inword_static = 0;
      inword_static(SIMD*TSrcI::width-1, 0) = inword_stream;
      in_static.write(inword_static);
    }
  }

  // Run
  Testbench_mvau_stream_inst(in_stream, out_stream, wstream, NUM_REPEAT);
  Testbench_mvau_static_inst(in_static, out_static, NUM_REPEAT);

  // Compare
  for (unsigned rep = 0; rep < NUM_REPEAT; rep++) {
    for (unsigned nf = 0; nf < NF; nf++) {
      TO golden = out_static.read();
      TO_s dut  = out_stream.read();
      bool mismatch = false;
      for (unsigned pe = 0; pe < PE; pe++) {
        ap_uint<TDstI::width> g_lane = golden((pe+1)*TDstI::width-1, pe*TDstI::width);
        ap_uint<TDstI::width> d_lane = dut((pe+1)*TDstI::width-1, pe*TDstI::width);
        if (g_lane != d_lane) mismatch = true;
      }
      if (mismatch) {
        std::cout << "Mismatch at rep=" << rep << " nf=" << nf << std::endl;
        return 1;
      }
    }
  }

  std::cout << "MVAU stream TB PASS" << std::endl;
  return 0;
}