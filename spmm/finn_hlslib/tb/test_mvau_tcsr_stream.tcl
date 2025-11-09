# TCSR (EOR) test TCL — based on your reference script
# Adjust filenames if your local names differ.

open_project -reset mvau_tcsr_prj

add_files tcsr_mvau_stream_top.cpp -cflags "-std=c++14 -I$::env(FINN_HLS_ROOT) -I$::env(FINN_HLS_ROOT)/tb"
add_files mvau_stream_top.cpp -cflags "-std=c++14 -I$::env(FINN_HLS_ROOT) -I$::env(FINN_HLS_ROOT)/tb"
add_files mvau_stream_top_masked.cpp -cflags "-std=c++14 -I$::env(FINN_HLS_ROOT) -I$::env(FINN_HLS_ROOT)/tb"
add_files -tb tcsr_mvau_stream_tb.cpp -cflags "-std=c++14 -I$::env(FINN_HLS_ROOT) -I$::env(FINN_HLS_ROOT)/tb"
# 








set_top Testbench_mvau_tcsr_stream

open_solution -reset "solution1"

csim_design -O



exit
