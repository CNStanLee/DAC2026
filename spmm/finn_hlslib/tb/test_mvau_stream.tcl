###############################################################################
# Tcl script for HLS csim, synthesis and cosim of the MVAU streamed-weights variant
###############################################################################
open_project hls-syn-mvau-stream
add_files mvau_stream_top.cpp -cflags "-std=c++14 -I$::env(FINN_HLS_ROOT) -I$::env(FINN_HLS_ROOT)/tb"
add_files -tb mvau_stream_tb.cpp -cflags "-std=c++14 -I$::env(FINN_HLS_ROOT) -I$::env(FINN_HLS_ROOT)/tb"
set_top Testbench_mvau_stream_inst
open_solution sol1
set_part {xczu3eg-sbva484-1-i}
create_clock -period 5 -name default
csim_design
csynth_design
cosim_design
exit