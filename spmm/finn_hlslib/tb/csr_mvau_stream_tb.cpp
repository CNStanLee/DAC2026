#include <iostream>
#include <cmath>
#include <ctime>
#include <cstring>
#include <hls_stream.h>
#include <cstdlib>
#define AP_INT_MAX_W 8191
#include "ap_int.h"
#include "weights.hpp"
#include "bnn-library.h"
#include "data/memdata_csr.h"
#include "data/config_csr.h"
#include "activations.hpp"
#include "interpret.hpp"
#include "mvau.hpp"
#include "conv.hpp"
#include <chrono>

#include "csr_mask.hpp"   // ← 新增：和 top 用同一条 keep 规则

using namespace std::chrono;
using namespace hls;
using namespace std;

#define MAX_IMAGES 1

// dense top (from user's project)
void Testbench_mvau_stream_masked(stream<ap_uint<IFM_Channels1*INPUT_PRECISION> > & in,
                           stream<ap_uint<OFM_Channels1*ACTIVATION_PRECISION> > & out,
                           unsigned int numReps);

// csr top (this project)
void Testbench_mvau_csr_stream(stream<ap_uint<IFM_Channels1*INPUT_PRECISION> > & in,
                               stream<ap_uint<OFM_Channels1*ACTIVATION_PRECISION> > & out,
                               unsigned int numReps);

int main()
{
    // ----------------------------------------
    // 1. 构造输入，和原 dense TB 完全一致
    // ----------------------------------------
    static ap_uint<INPUT_PRECISION> IMAGE[MAX_IMAGES][IFMDim1*IFMDim1][IFM_Channels1];
    static ap_int<ACTIVATION_PRECISION> TEST[MAX_IMAGES][OFMDim1][OFMDim1][OFM_Channels1];

    stream<ap_uint<IFM_Channels1*INPUT_PRECISION> > input_stream("input_stream");
    stream<ap_uint<OFM_Channels1*ACTIVATION_PRECISION> > out_dense("out_dense");
    stream<ap_uint<OFM_Channels1*ACTIVATION_PRECISION> > out_csr("out_csr");

    unsigned int counter = 0;
    for (unsigned int n_image = 0; n_image < MAX_IMAGES; n_image++) {
        for (unsigned int oy = 0; oy < IFMDim1; oy++) {
            for (unsigned int ox = 0; ox < IFMDim1; ox++) {
                ap_uint<INPUT_PRECISION*IFM_Channels1> input_channel = 0;
                for(unsigned int channel = 0; channel < IFM_Channels1; channel++)
                {
                    ap_uint<INPUT_PRECISION> input = (ap_uint<INPUT_PRECISION>)(counter);
                    IMAGE[n_image][oy*IFMDim1+ox][channel]= input;
                    input_channel = input_channel >> INPUT_PRECISION;
                    input_channel(IFM_Channels1*INPUT_PRECISION-1,(IFM_Channels1-1)*INPUT_PRECISION)=input;
                    counter++;
                }
                input_stream.write(input_channel);
            }
        }
    }

    // ----------------------------------------
    // 2. 按 FINN 的方式，把 PARAM::weights 展开成 4D，用来做 golden conv()
    //    这里是关键改动：在写 W1[...] 之前，也跑一遍 csr_keep_rule(...)
    // ----------------------------------------
    static ap_uint<WIDTH> W1[OFM_Channels1][KERNEL_DIM][KERNEL_DIM][IFM_Channels1];

    // 这两条是和你原来 TB 一样的
    constexpr int TX = (IFM_Channels1*KERNEL_DIM*KERNEL_DIM) / SIMD1;  // = #tiles per ofm-rowgroup
    constexpr int TY = OFM_Channels1 / PE1;                             // = #rowgroups
    unsigned int kx=0, ky=0, chan_count=0, out_chan_count=0;

    for (unsigned int oy = 0; oy < TY; oy++) {        // row group → nf
        for(unsigned int pe=0; pe < PE1; pe++){
            for (unsigned int ox = 0; ox < TX; ox++) { // tile in this row
                for(unsigned int simd=0; simd < SIMD1; simd++){
                    // 原始 dense 权重
                    ap_uint<WIDTH> w = PARAM::weights.weights(oy*TX + ox)[pe][simd];

                    // 这个权重在“展开成一整行”之后对应的列号是多少：
                    // 和 top 里生成 CSR 时的写法一致：col = sf*SIMD + s = ox*SIMD1 + simd
                    unsigned col = ox * SIMD1 + simd;

                    // 用和 CSR top 一样的规则决定要不要这个权重
                    bool keep = csr_keep_rule(/*rep=*/0,
                                              /*nf =*/ oy,
                                              /*pe =*/ pe,
                                              /*col =*/ col,
                                              /*wbits =*/ w);

                    if (keep)
                        W1[out_chan_count][kx][ky][chan_count] = w;
                    else
                        W1[out_chan_count][kx][ky][chan_count] = 0;

                    // 下面这段是你原来就有的“4D 展开指针推进”
                    chan_count++;
                    if (chan_count==IFM_Channels1){
                        chan_count=0;
                        kx++;
                        if (kx==KERNEL_DIM){
                            kx=0;
                            ky++;
                            if (ky==KERNEL_DIM){
                                ky=0;
                                out_chan_count++;
                                if (out_chan_count==OFM_Channels1){
                                    out_chan_count=0;
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    // ----------------------------------------
    // 3. Golden conv，用的是“已经按同一把剪刀剪过的 W1”
    // ----------------------------------------
    conv<MAX_IMAGES,
         IFMDim1,
         OFMDim1,
         IFM_Channels1,
         OFM_Channels1,
         KERNEL_DIM,
         1,
         ap_uint<INPUT_PRECISION> >(IMAGE, W1, TEST);

    // ----------------------------------------
    // 4. 跑 dense 顶层（原始）
    // ----------------------------------------
    auto start_dense = high_resolution_clock::now();
    Testbench_mvau_stream_masked(input_stream, out_dense, MAX_IMAGES);
    auto end_dense = high_resolution_clock::now();
    auto dur_dense = duration_cast<microseconds>(end_dense - start_dense);

    // ----------------------------------------
    // 5. 重喂一遍输入，跑 CSR 顶层
    // ----------------------------------------
    stream<ap_uint<IFM_Channels1*INPUT_PRECISION> > input_stream2("input_stream2");
    counter = 0;
    for (unsigned int n_image = 0; n_image < MAX_IMAGES; n_image++) {
        for (unsigned int oy = 0; oy < IFMDim1; oy++) {
            for (unsigned int ox = 0; ox < IFMDim1; ox++) {
                ap_uint<INPUT_PRECISION*IFM_Channels1> input_channel = 0;
                for(unsigned int channel = 0; channel < IFM_Channels1; channel++)
                {
                    ap_uint<INPUT_PRECISION> input = (ap_uint<INPUT_PRECISION>)(counter);
                    input_channel = input_channel >> INPUT_PRECISION;
                    input_channel(IFM_Channels1*INPUT_PRECISION-1,(IFM_Channels1-1)*INPUT_PRECISION)=input;
                    counter++;
                }
                input_stream2.write(input_channel);
            }
        }
    }

    auto start_csr = high_resolution_clock::now();
    Testbench_mvau_csr_stream(input_stream2, out_csr, MAX_IMAGES);
    auto end_csr = high_resolution_clock::now();
    auto dur_csr = duration_cast<microseconds>(end_csr - start_csr);

    // ----------------------------------------
    // 6. 校验：现在 dense / CSR / golden 三者都是同一把剪刀剪出来的
    // ----------------------------------------
    int err_dense = 0, err_csr = 0;
    for (unsigned int n_image = 0; n_image < MAX_IMAGES; n_image++) {
        for (unsigned int oy = 0; oy < OFMDim1; oy++) {
            for (unsigned int ox = 0; ox < OFMDim1; ox++) {
                ap_uint<OFM_Channels1*ACTIVATION_PRECISION> outDenseElem = out_dense.read();
                ap_uint<OFM_Channels1*ACTIVATION_PRECISION> outCsrElem   = out_csr.read();
                for(unsigned int channel = 0; channel < OFM_Channels1; channel++){
                    ap_int<ACTIVATION_PRECISION> exp = TEST[n_image][ox][oy][channel];
                    ap_int<ACTIVATION_PRECISION> got_dense, got_csr;
                    got_dense = outDenseElem((channel + 1)*ACTIVATION_PRECISION-1,channel*ACTIVATION_PRECISION);
                    got_csr   = outCsrElem((channel + 1)*ACTIVATION_PRECISION-1,channel*ACTIVATION_PRECISION);

                    if (exp != got_dense) {
                        std::cout << "[DENSE] Mismatch at ("<<oy<<","<<ox<<","<<channel<<") exp="<<exp<<" got="<<got_dense<<std::endl;
                        err_dense++;
                    }
                    if (exp != got_csr) {
                        std::cout << "[CSR]   Mismatch at ("<<oy<<","<<ox<<","<<channel<<") exp="<<exp<<" got="<<got_csr<<std::endl;
                        err_csr++;
                    }
                }
            }
        }
    }

    std::cout << "Dense time: " << dur_dense.count() << " us\n";
    std::cout << "CSR   time: " << dur_csr.count()   << " us\n";
    if (dur_csr.count() > 0) {
        double speedup = double(dur_dense.count()) / double(dur_csr.count());
        std::cout << "Effective speedup (dense/CSR): " << speedup << "x\n";
    }

    if (err_dense == 0) std::cout << "Dense check: PASS\n"; else std::cout << "Dense check: FAIL ("<<err_dense<<")\n";
    if (err_csr   == 0) std::cout << "CSR   check: PASS\n"; else std::cout << "CSR   check: FAIL ("<<err_csr<<")\n";

    return (err_dense==0 && err_csr==0) ? 0 : 1;
}
