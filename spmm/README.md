## Instructions
1. Generate `config.h` and `memdata.h` by running gen_weights.py (modify it if you need non-default precision for weights/activations)
``` bash
python spmm/finn-hlslib/tb/data/gen_weigths.py
```
1. Set the FINN_HLS_ROOT to the root folder of the repo, e.g. `setenv FINN_HLS_ROOT <path to repo root>`
``` bash
export FINN_HLS_ROOT=/home/changhong/prj/finn_dev/finn/script/DAC2026/spmm/finn-hlslib
```
1. Run a unit test with Vivado HLS, e.g. `vivado_hls <testname>.tcl`
``` bash
source /tools/Xilinx/Vivado/2022.2/settings64.sh
vivado_hls spmm/finn-hlslib/tb/test_add.tcl
```
source /tools/Xilinx/Vitis_HLS/2022.2/settings64.sh
vitis_hls spmm/finn-hlslib/tb/test_add.tcl


- note: when you run vitis_hls *.tcl, must in tb folder.
``` bash
cd spmm
export FINN_HLS_ROOT=$(pwd)/finn_hlslib
python finn_hlslib/tb/data/gen_weigths.py
source /tools/Xilinx/Vitis_HLS/2022.2/settings64.sh
cd finn_hlslib/tb
vitis_hls test_mvau_stream.tcl
vitis_hls test_mvau_csr_stream.tcl
```