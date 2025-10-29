###############################################################################
# Tcl script for HLS csim, synthesis and cosim of the MVAU static-weights variant
###############################################################################
open_project hls-syn-mvau-static
add_files mvau_static_top.cpp -cflags "-std=c++14 -I$::env(FINN_HLS_ROOT) -I$::env(FINN_HLS_ROOT)/tb"
add_files -tb mvau_static_tb.cpp -cflags "-std=c++14 -I$::env(FINN_HLS_ROOT) -I$::env(FINN_HLS_ROOT)/tb"
set_top Testbench_mvau_static_inst
open_solution sol1
set_part {xczu3eg-sbva484-1-i}
create_clock -period 5 -name default
csim_design
csynth_design
cosim_design
exit