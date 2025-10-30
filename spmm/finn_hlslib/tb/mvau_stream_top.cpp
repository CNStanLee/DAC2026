#include <hls_stream.h>
using namespace hls;
#include "ap_int.h"
#include "bnn-library.h"

#include "activations.hpp"
#include "weights.hpp"
#include "activations.hpp"
#include "interpret.hpp"
#include "dma.h"
#include "mvau.hpp"
#include "conv.hpp"
#include "data/memdata.h"
#include "data/config.h"

void Testbench_mvau_stream(stream<ap_uint<IFM_Channels1*INPUT_PRECISION> > & in, stream<ap_uint<OFM_Channels1*ACTIVATION_PRECISION> > & out, unsigned int numReps){
#pragma HLS DATAFLOW

    unsigned const MatrixW = KERNEL_DIM * KERNEL_DIM * IFM_Channels1;
    unsigned const MatrixH = OFM_Channels1;
    unsigned const InpPerImage = IFMDim1*IFMDim1;

    hls::stream<ap_uint<SIMD1*INPUT_PRECISION> > convInp;
    hls::stream<ap_uint<SIMD1*PE1*WIDTH> > paramStreamOut;
    hls::stream<ap_uint<SIMD1*INPUT_PRECISION> > wa_in;
    hls::stream<ap_uint<PE1*ACTIVATION_PRECISION> > mvOut;
    GenParamStream<TILE1, SIMD1, PE1, WIDTH>(PARAM::weights, paramStreamOut, numReps * OFMDim1 * OFMDim1);

    StreamingDataWidthConverter_Batch<IFM_Channels1*INPUT_PRECISION, SIMD1*INPUT_PRECISION, InpPerImage>(in, wa_in, numReps);
    ConvolutionInputGenerator<KERNEL_DIM, IFM_Channels1, INPUT_PRECISION, IFMDim1, OFMDim1, SIMD1, 1>(wa_in, convInp, numReps, ap_resource_dflt());

    Matrix_Vector_Activate_Stream_Batch<MatrixW, MatrixH, SIMD1, PE1, Slice<ap_uint<INPUT_PRECISION> >, Slice<ap_int<ACTIVATION_PRECISION> >, Identity, ap_uint<WIDTH> >
    (    static_cast<hls::stream<ap_uint<SIMD1*INPUT_PRECISION>>&>(convInp),
         static_cast<hls::stream<ap_uint<PE1*ACTIVATION_PRECISION>>&>  (mvOut),
         paramStreamOut, PassThroughActivation<ap_uint<16>>(), numReps* OFMDim1 * OFMDim1, ap_resource_dsp()    );
	
	StreamingDataWidthConverter_Batch<PE1*ACTIVATION_PRECISION, OFM_Channels1*ACTIVATION_PRECISION, OFMDim1 * OFMDim1 * (OFM_Channels1 / PE1)>(mvOut, out, numReps);

}
