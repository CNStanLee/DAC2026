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

typedef ap_uint<MMV * SIMD * TSrcI::width> TI;
typedef ap_uint<MMV * PE   * TDstI::width> TO;
typedef ap_uint<PE * SIMD * TWeightI::width> WP;

void Testbench_mvau_static_inst(stream<TI> &in, stream<TO> &out, const unsigned int numReps);
void Testbench_mvau_stream_inst(stream< ap_uint<SIMD * TSrcI::width> > &in,
                                stream< ap_uint<PE   * TDstI::width> > &out,
                                stream< WP > &wstream,
                                const unsigned int numReps);

int main() {
stream<TI> in_static("in_static");
  stream<TO> out_static("out_static");

  // also build a matching stream-version pipeline to cross-check
  stream< ap_uint<SIMD * TSrcI::width> > in_stream("in_stream");
  stream< ap_uint<PE   * TDstI::width> > out_stream("out_stream");
  stream< WP > wstream("wstream");

  // Pack weights into weight stream in the same order as MVAU expects
  // Order: tile = nf*SF + sf ; within each tile pack [PE][SIMD] weights, contiguous in 'pe'
  for (unsigned rep = 0; rep < NUM_REPEAT; rep++) {
    for (unsigned nf = 0; nf < NF; nf++) {
      for (unsigned sf = 0; sf < SF; sf++) {
        unsigned tile = nf * SF + sf;
        auto const &wtile = weights.weights(tile);
        WP packet = 0;
        for (unsigned pe = 0; pe < PE; pe++) {
#pragma HLS UNROLL
          ap_uint<SIMD * TWeightI::width> slice = wtile[pe]; // relies on weights tile operator[]
          packet((pe+1)*SIMD*TWeightI::width-1, pe*SIMD*TWeightI::width) = slice;
        }
        wstream.write(packet);
      }
    }
  }

  // Build the same input for both variants
  for (unsigned rep = 0; rep < NUM_REPEAT; rep++) {
    for (unsigned sf = 0; sf < SF; sf++) {
      TI inword = (TI) (rep*SF + sf); // deterministic, like add_tb
      in_static.write(inword);
      // Decompose to the 1x-MMV stream input element-wise for the stream variant (MMV must be 1 there)
      ap_uint<SIMD * TSrcI::width> inword_stream = inword(SIMD*TSrcI::width-1, 0);
      in_stream.write(inword_stream);
    }
  }

  // Run both
  Testbench_mvau_static_inst(in_static, out_static, NUM_REPEAT);
  Testbench_mvau_stream_inst(in_stream, out_stream, wstream, NUM_REPEAT);

  // Compare outputs
  for (unsigned rep = 0; rep < NUM_REPEAT; rep++) {
    for (unsigned nf = 0; nf < NF; nf++) {
      TO a = out_static.read();
      ap_uint<PE * TDstI::width> b = out_stream.read();
      // Compare per-PE first MMV lane (stream has MMV==1)
      bool mismatch = false;
      for (unsigned pe = 0; pe < PE; pe++) {
        ap_uint<TDstI::width> a_lane = a((pe+1)*TDstI::width-1, pe*TDstI::width);
        ap_uint<TDstI::width> b_lane = b((pe+1)*TDstI::width-1, pe*TDstI::width);
        if (a_lane != b_lane) {
          mismatch = true;
        }
      }
      if (mismatch) {
        std::cout << "Mismatch at rep=" << rep << " nf=" << nf << std::endl;
        return 1;
      }
    }
  }

  std::cout << "MVAU static vs stream cross-check PASS" << std::endl;
  return 0;
}