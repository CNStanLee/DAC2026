
open_project -reset mvau_csr_prj

# Add sources
add_files csr_mvau_stream_top.cpp -cflags "-std=c++14 -I$::env(FINN_HLS_ROOT) -I$::env(FINN_HLS_ROOT)/tb"
add_files mvau_stream_top.cpp -cflags "-std=c++14 -I$::env(FINN_HLS_ROOT) -I$::env(FINN_HLS_ROOT)/tb"
add_files mvau_stream_top_masked.cpp -cflags "-std=c++14 -I$::env(FINN_HLS_ROOT) -I$::env(FINN_HLS_ROOT)/tb"
#add_files csr_mvau.hpp
#add_files mvau_stream_top.cpp
add_files -tb csr_mvau_stream_tb.cpp -cflags "-std=c++14 -I$::env(FINN_HLS_ROOT) -I$::env(FINN_HLS_ROOT)/tb"
# add_files data/config_csr.h
# add_files data/memdata_csr.h

# Top for HLS (function under test used inside TB)
set_top Testbench_mvau_csr_stream

open_solution -reset "solution1"
# You can set a specific part if needed, but for csim it's not necessary
# set_part {xcku115-flvb2104-2-i}
# create_clock -period 5 -name default

csim_design -O

# Optionally run C synthesis to check resource estimation (uncomment below)
# csynth_design

exit
