create_project finn_vivado_stitch_proj /tmp/finn_dev_changhong/vivado_stitch_proj_6ygkx3ag -part xc7z020clg400-1
set_msg_config -id {[BD 41-1753]} -suppress
set_property ip_repo_paths [list $::env(FINN_ROOT)/finn-rtllib/memstream /tmp/finn_dev_changhong/code_gen_ipgen_StreamingFIFO_rtl_0_dkg4pesd /tmp/finn_dev_changhong/code_gen_ipgen_MVAU_hls_0_2m_dfsz2/project_MVAU_hls_0/sol1/impl/ip /tmp/finn_dev_changhong/code_gen_ipgen_StreamingFIFO_rtl_1_e81tgmyg /tmp/finn_dev_changhong/code_gen_ipgen_MVAU_hls_1_buxdqq4q/project_MVAU_hls_1/sol1/impl/ip /tmp/finn_dev_changhong/code_gen_ipgen_StreamingFIFO_rtl_2_k5_fkpn0 /tmp/finn_dev_changhong/code_gen_ipgen_MVAU_hls_2_77y5pwt9/project_MVAU_hls_2/sol1/impl/ip /tmp/finn_dev_changhong/code_gen_ipgen_StreamingFIFO_rtl_3_4n61fioa /tmp/finn_dev_changhong/code_gen_ipgen_MVAU_hls_3_bvw1qno4/project_MVAU_hls_3/sol1/impl/ip /tmp/finn_dev_changhong/code_gen_ipgen_StreamingFIFO_rtl_4_ijevs4o7] [current_project]
update_ip_catalog
create_bd_design "finn_design"
add_files -norecurse /tmp/finn_dev_changhong/code_gen_ipgen_StreamingFIFO_rtl_0_dkg4pesd/Q_srl.v
add_files -norecurse /tmp/finn_dev_changhong/code_gen_ipgen_StreamingFIFO_rtl_0_dkg4pesd/StreamingFIFO_rtl_0.v
create_bd_cell -type module -reference StreamingFIFO_rtl_0 StreamingFIFO_rtl_0
if {[catch {current_bd_design} _cur_bd]} { set _cur_bd "" }
if {$_cur_bd eq ""} { create_bd_design "finn_design" }
file mkdir ./ip/verilog/rtl_ops/MVAU_hls_0
if {![llength [get_bd_cells -quiet /MVAU_hls_0]]} { create_bd_cell -type hier MVAU_hls_0 }
if {![llength [get_bd_pins -quiet /MVAU_hls_0/ap_clk]]} { create_bd_pin -dir I -type clk /MVAU_hls_0/ap_clk }
if {![llength [get_bd_pins -quiet /MVAU_hls_0/ap_rst_n]]} { create_bd_pin -dir I -type rst /MVAU_hls_0/ap_rst_n }
# no ap_clk2x on parent
if {![llength [get_bd_intf_pins -quiet /MVAU_hls_0/out0_V]]} {   create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 /MVAU_hls_0/out0_V }
if {![llength [get_bd_intf_pins -quiet /MVAU_hls_0/in0_V]]} {   create_bd_intf_pin -mode Slave  -vlnv xilinx.com:interface:axis_rtl:1.0 /MVAU_hls_0/in0_V }
if {![llength [get_bd_cells -quiet /MVAU_hls_0/MVAU_hls_0]]} {   set _defs [get_ipdefs -all -filter "VLNV =~ xilinx.com:hls:MVAU_hls_0:*"];   if {[llength $_defs]} { create_bd_cell -type ip -vlnv [lindex $_defs 0] /MVAU_hls_0/MVAU_hls_0 }   else { error {HLS IP xilinx.com:hls:MVAU_hls_0:* not found} } }
if {[llength [get_bd_pins -quiet /MVAU_hls_0/MVAU_hls_0/ap_rst_n]]} { connect_bd_net [get_bd_pins /MVAU_hls_0/ap_rst_n] [get_bd_pins /MVAU_hls_0/MVAU_hls_0/ap_rst_n] }
if {[llength [get_bd_pins -quiet /MVAU_hls_0/MVAU_hls_0/ap_clk]]} { connect_bd_net [get_bd_pins /MVAU_hls_0/ap_clk] [get_bd_pins /MVAU_hls_0/MVAU_hls_0/ap_clk] }
if {[llength [get_bd_intf_pins -quiet /MVAU_hls_0/MVAU_hls_0/in0_V]]} { connect_bd_intf_net [get_bd_intf_pins /MVAU_hls_0/in0_V] [get_bd_intf_pins /MVAU_hls_0/MVAU_hls_0/in0_V] }
if {[llength [get_bd_intf_pins -quiet /MVAU_hls_0/MVAU_hls_0/out0_V]]} { connect_bd_intf_net [get_bd_intf_pins /MVAU_hls_0/out0_V] [get_bd_intf_pins /MVAU_hls_0/MVAU_hls_0/out0_V] }
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_0 -force -norecurse /tmp/finn_dev_changhong/code_gen_ipgen_MVAU_hls_0_2m_dfsz2/MVAU_hls_0_sfidx_memstream_wrapper.v
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_0 -force -norecurse /home/changhong/prj/finn_cli_fork/finn-rtllib/axi/hdl/axilite.sv
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_0 -force -norecurse /home/changhong/prj/finn_cli_fork/finn-rtllib/memstream/hdl/memstream_axi.sv
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_0 -force -norecurse /home/changhong/prj/finn_cli_fork/finn-rtllib/memstream/hdl/memstream.sv
update_compile_order -fileset sources_1
create_bd_cell -type hier -reference MVAU_hls_0_sfidx_memstream_wrapper /MVAU_hls_0/MVAU_hls_0_wstrm_sfidx
connect_bd_net [get_bd_pins /MVAU_hls_0/ap_clk] [get_bd_pins /MVAU_hls_0/MVAU_hls_0_wstrm_sfidx/ap_clk]
connect_bd_net [get_bd_pins /MVAU_hls_0/ap_rst_n] [get_bd_pins /MVAU_hls_0/MVAU_hls_0_wstrm_sfidx/ap_rst_n]
connect_bd_net [get_bd_pins /MVAU_hls_0/ap_clk] [get_bd_pins /MVAU_hls_0/MVAU_hls_0_wstrm_sfidx/ap_clk2x]
connect_bd_intf_net [get_bd_intf_pins /MVAU_hls_0/MVAU_hls_0_wstrm_sfidx/m_axis_0] [get_bd_intf_pins /MVAU_hls_0/MVAU_hls_0/sfidx_V]
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_0 -force -norecurse /tmp/finn_dev_changhong/code_gen_ipgen_MVAU_hls_0_2m_dfsz2/MVAU_hls_0_val_memstream_wrapper.v
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_0 -force -norecurse /home/changhong/prj/finn_cli_fork/finn-rtllib/axi/hdl/axilite.sv
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_0 -force -norecurse /home/changhong/prj/finn_cli_fork/finn-rtllib/memstream/hdl/memstream_axi.sv
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_0 -force -norecurse /home/changhong/prj/finn_cli_fork/finn-rtllib/memstream/hdl/memstream.sv
update_compile_order -fileset sources_1
create_bd_cell -type hier -reference MVAU_hls_0_val_memstream_wrapper /MVAU_hls_0/MVAU_hls_0_wstrm_val
connect_bd_net [get_bd_pins /MVAU_hls_0/ap_clk] [get_bd_pins /MVAU_hls_0/MVAU_hls_0_wstrm_val/ap_clk]
connect_bd_net [get_bd_pins /MVAU_hls_0/ap_rst_n] [get_bd_pins /MVAU_hls_0/MVAU_hls_0_wstrm_val/ap_rst_n]
connect_bd_net [get_bd_pins /MVAU_hls_0/ap_clk] [get_bd_pins /MVAU_hls_0/MVAU_hls_0_wstrm_val/ap_clk2x]
connect_bd_intf_net [get_bd_intf_pins /MVAU_hls_0/MVAU_hls_0_wstrm_val/m_axis_0] [get_bd_intf_pins /MVAU_hls_0/MVAU_hls_0/val_V]
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_0 -force -norecurse /tmp/finn_dev_changhong/code_gen_ipgen_MVAU_hls_0_2m_dfsz2/MVAU_hls_0_mask_memstream_wrapper.v
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_0 -force -norecurse /home/changhong/prj/finn_cli_fork/finn-rtllib/axi/hdl/axilite.sv
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_0 -force -norecurse /home/changhong/prj/finn_cli_fork/finn-rtllib/memstream/hdl/memstream_axi.sv
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_0 -force -norecurse /home/changhong/prj/finn_cli_fork/finn-rtllib/memstream/hdl/memstream.sv
update_compile_order -fileset sources_1
create_bd_cell -type hier -reference MVAU_hls_0_mask_memstream_wrapper /MVAU_hls_0/MVAU_hls_0_wstrm_mask
connect_bd_net [get_bd_pins /MVAU_hls_0/ap_clk] [get_bd_pins /MVAU_hls_0/MVAU_hls_0_wstrm_mask/ap_clk]
connect_bd_net [get_bd_pins /MVAU_hls_0/ap_rst_n] [get_bd_pins /MVAU_hls_0/MVAU_hls_0_wstrm_mask/ap_rst_n]
connect_bd_net [get_bd_pins /MVAU_hls_0/ap_clk] [get_bd_pins /MVAU_hls_0/MVAU_hls_0_wstrm_mask/ap_clk2x]
connect_bd_intf_net [get_bd_intf_pins /MVAU_hls_0/MVAU_hls_0_wstrm_mask/m_axis_0] [get_bd_intf_pins /MVAU_hls_0/MVAU_hls_0/mask_V]
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_0 -force -norecurse /tmp/finn_dev_changhong/code_gen_ipgen_MVAU_hls_0_2m_dfsz2/MVAU_hls_0_rowlen_memstream_wrapper.v
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_0 -force -norecurse /home/changhong/prj/finn_cli_fork/finn-rtllib/axi/hdl/axilite.sv
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_0 -force -norecurse /home/changhong/prj/finn_cli_fork/finn-rtllib/memstream/hdl/memstream_axi.sv
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_0 -force -norecurse /home/changhong/prj/finn_cli_fork/finn-rtllib/memstream/hdl/memstream.sv
update_compile_order -fileset sources_1
create_bd_cell -type hier -reference MVAU_hls_0_rowlen_memstream_wrapper /MVAU_hls_0/MVAU_hls_0_wstrm_rowlen
connect_bd_net [get_bd_pins /MVAU_hls_0/ap_clk] [get_bd_pins /MVAU_hls_0/MVAU_hls_0_wstrm_rowlen/ap_clk]
connect_bd_net [get_bd_pins /MVAU_hls_0/ap_rst_n] [get_bd_pins /MVAU_hls_0/MVAU_hls_0_wstrm_rowlen/ap_rst_n]
connect_bd_net [get_bd_pins /MVAU_hls_0/ap_clk] [get_bd_pins /MVAU_hls_0/MVAU_hls_0_wstrm_rowlen/ap_clk2x]
connect_bd_intf_net [get_bd_intf_pins /MVAU_hls_0/MVAU_hls_0_wstrm_rowlen/m_axis_0] [get_bd_intf_pins /MVAU_hls_0/MVAU_hls_0/rowlen_V]
if {![llength [get_bd_intf_pins -quiet /MVAU_hls_0/s_axilite_sfidx]]} { create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 /MVAU_hls_0/s_axilite_sfidx }
connect_bd_intf_net [get_bd_intf_pins /MVAU_hls_0/s_axilite_sfidx] [get_bd_intf_pins /MVAU_hls_0/MVAU_hls_0_wstrm_sfidx/s_axilite]
if {![llength [get_bd_intf_pins -quiet /MVAU_hls_0/s_axilite_val]]} { create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 /MVAU_hls_0/s_axilite_val }
connect_bd_intf_net [get_bd_intf_pins /MVAU_hls_0/s_axilite_val] [get_bd_intf_pins /MVAU_hls_0/MVAU_hls_0_wstrm_val/s_axilite]
if {![llength [get_bd_intf_pins -quiet /MVAU_hls_0/s_axilite_mask]]} { create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 /MVAU_hls_0/s_axilite_mask }
connect_bd_intf_net [get_bd_intf_pins /MVAU_hls_0/s_axilite_mask] [get_bd_intf_pins /MVAU_hls_0/MVAU_hls_0_wstrm_mask/s_axilite]
if {![llength [get_bd_intf_pins -quiet /MVAU_hls_0/s_axilite_rowlen]]} { create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 /MVAU_hls_0/s_axilite_rowlen }
connect_bd_intf_net [get_bd_intf_pins /MVAU_hls_0/s_axilite_rowlen] [get_bd_intf_pins /MVAU_hls_0/MVAU_hls_0_wstrm_rowlen/s_axilite]
assign_bd_address
save_bd_design
add_files -norecurse /tmp/finn_dev_changhong/code_gen_ipgen_StreamingFIFO_rtl_1_e81tgmyg/Q_srl.v
add_files -norecurse /tmp/finn_dev_changhong/code_gen_ipgen_StreamingFIFO_rtl_1_e81tgmyg/StreamingFIFO_rtl_1.v
create_bd_cell -type module -reference StreamingFIFO_rtl_1 StreamingFIFO_rtl_1
if {[catch {current_bd_design} _cur_bd]} { set _cur_bd "" }
if {$_cur_bd eq ""} { create_bd_design "finn_design" }
file mkdir ./ip/verilog/rtl_ops/MVAU_hls_1
if {![llength [get_bd_cells -quiet /MVAU_hls_1]]} { create_bd_cell -type hier MVAU_hls_1 }
if {![llength [get_bd_pins -quiet /MVAU_hls_1/ap_clk]]} { create_bd_pin -dir I -type clk /MVAU_hls_1/ap_clk }
if {![llength [get_bd_pins -quiet /MVAU_hls_1/ap_rst_n]]} { create_bd_pin -dir I -type rst /MVAU_hls_1/ap_rst_n }
# no ap_clk2x on parent
if {![llength [get_bd_intf_pins -quiet /MVAU_hls_1/out0_V]]} {   create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 /MVAU_hls_1/out0_V }
if {![llength [get_bd_intf_pins -quiet /MVAU_hls_1/in0_V]]} {   create_bd_intf_pin -mode Slave  -vlnv xilinx.com:interface:axis_rtl:1.0 /MVAU_hls_1/in0_V }
if {![llength [get_bd_cells -quiet /MVAU_hls_1/MVAU_hls_1]]} {   set _defs [get_ipdefs -all -filter "VLNV =~ xilinx.com:hls:MVAU_hls_1:*"];   if {[llength $_defs]} { create_bd_cell -type ip -vlnv [lindex $_defs 0] /MVAU_hls_1/MVAU_hls_1 }   else { error {HLS IP xilinx.com:hls:MVAU_hls_1:* not found} } }
if {[llength [get_bd_pins -quiet /MVAU_hls_1/MVAU_hls_1/ap_rst_n]]} { connect_bd_net [get_bd_pins /MVAU_hls_1/ap_rst_n] [get_bd_pins /MVAU_hls_1/MVAU_hls_1/ap_rst_n] }
if {[llength [get_bd_pins -quiet /MVAU_hls_1/MVAU_hls_1/ap_clk]]} { connect_bd_net [get_bd_pins /MVAU_hls_1/ap_clk] [get_bd_pins /MVAU_hls_1/MVAU_hls_1/ap_clk] }
if {[llength [get_bd_intf_pins -quiet /MVAU_hls_1/MVAU_hls_1/in0_V]]} { connect_bd_intf_net [get_bd_intf_pins /MVAU_hls_1/in0_V] [get_bd_intf_pins /MVAU_hls_1/MVAU_hls_1/in0_V] }
if {[llength [get_bd_intf_pins -quiet /MVAU_hls_1/MVAU_hls_1/out0_V]]} { connect_bd_intf_net [get_bd_intf_pins /MVAU_hls_1/out0_V] [get_bd_intf_pins /MVAU_hls_1/MVAU_hls_1/out0_V] }
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_1 -force -norecurse /tmp/finn_dev_changhong/code_gen_ipgen_MVAU_hls_1_buxdqq4q/MVAU_hls_1_sfidx_memstream_wrapper.v
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_1 -force -norecurse /home/changhong/prj/finn_cli_fork/finn-rtllib/axi/hdl/axilite.sv
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_1 -force -norecurse /home/changhong/prj/finn_cli_fork/finn-rtllib/memstream/hdl/memstream_axi.sv
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_1 -force -norecurse /home/changhong/prj/finn_cli_fork/finn-rtllib/memstream/hdl/memstream.sv
update_compile_order -fileset sources_1
create_bd_cell -type hier -reference MVAU_hls_1_sfidx_memstream_wrapper /MVAU_hls_1/MVAU_hls_1_wstrm_sfidx
connect_bd_net [get_bd_pins /MVAU_hls_1/ap_clk] [get_bd_pins /MVAU_hls_1/MVAU_hls_1_wstrm_sfidx/ap_clk]
connect_bd_net [get_bd_pins /MVAU_hls_1/ap_rst_n] [get_bd_pins /MVAU_hls_1/MVAU_hls_1_wstrm_sfidx/ap_rst_n]
connect_bd_net [get_bd_pins /MVAU_hls_1/ap_clk] [get_bd_pins /MVAU_hls_1/MVAU_hls_1_wstrm_sfidx/ap_clk2x]
connect_bd_intf_net [get_bd_intf_pins /MVAU_hls_1/MVAU_hls_1_wstrm_sfidx/m_axis_0] [get_bd_intf_pins /MVAU_hls_1/MVAU_hls_1/sfidx_V]
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_1 -force -norecurse /tmp/finn_dev_changhong/code_gen_ipgen_MVAU_hls_1_buxdqq4q/MVAU_hls_1_val_memstream_wrapper.v
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_1 -force -norecurse /home/changhong/prj/finn_cli_fork/finn-rtllib/axi/hdl/axilite.sv
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_1 -force -norecurse /home/changhong/prj/finn_cli_fork/finn-rtllib/memstream/hdl/memstream_axi.sv
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_1 -force -norecurse /home/changhong/prj/finn_cli_fork/finn-rtllib/memstream/hdl/memstream.sv
update_compile_order -fileset sources_1
create_bd_cell -type hier -reference MVAU_hls_1_val_memstream_wrapper /MVAU_hls_1/MVAU_hls_1_wstrm_val
connect_bd_net [get_bd_pins /MVAU_hls_1/ap_clk] [get_bd_pins /MVAU_hls_1/MVAU_hls_1_wstrm_val/ap_clk]
connect_bd_net [get_bd_pins /MVAU_hls_1/ap_rst_n] [get_bd_pins /MVAU_hls_1/MVAU_hls_1_wstrm_val/ap_rst_n]
connect_bd_net [get_bd_pins /MVAU_hls_1/ap_clk] [get_bd_pins /MVAU_hls_1/MVAU_hls_1_wstrm_val/ap_clk2x]
connect_bd_intf_net [get_bd_intf_pins /MVAU_hls_1/MVAU_hls_1_wstrm_val/m_axis_0] [get_bd_intf_pins /MVAU_hls_1/MVAU_hls_1/val_V]
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_1 -force -norecurse /tmp/finn_dev_changhong/code_gen_ipgen_MVAU_hls_1_buxdqq4q/MVAU_hls_1_mask_memstream_wrapper.v
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_1 -force -norecurse /home/changhong/prj/finn_cli_fork/finn-rtllib/axi/hdl/axilite.sv
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_1 -force -norecurse /home/changhong/prj/finn_cli_fork/finn-rtllib/memstream/hdl/memstream_axi.sv
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_1 -force -norecurse /home/changhong/prj/finn_cli_fork/finn-rtllib/memstream/hdl/memstream.sv
update_compile_order -fileset sources_1
create_bd_cell -type hier -reference MVAU_hls_1_mask_memstream_wrapper /MVAU_hls_1/MVAU_hls_1_wstrm_mask
connect_bd_net [get_bd_pins /MVAU_hls_1/ap_clk] [get_bd_pins /MVAU_hls_1/MVAU_hls_1_wstrm_mask/ap_clk]
connect_bd_net [get_bd_pins /MVAU_hls_1/ap_rst_n] [get_bd_pins /MVAU_hls_1/MVAU_hls_1_wstrm_mask/ap_rst_n]
connect_bd_net [get_bd_pins /MVAU_hls_1/ap_clk] [get_bd_pins /MVAU_hls_1/MVAU_hls_1_wstrm_mask/ap_clk2x]
connect_bd_intf_net [get_bd_intf_pins /MVAU_hls_1/MVAU_hls_1_wstrm_mask/m_axis_0] [get_bd_intf_pins /MVAU_hls_1/MVAU_hls_1/mask_V]
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_1 -force -norecurse /tmp/finn_dev_changhong/code_gen_ipgen_MVAU_hls_1_buxdqq4q/MVAU_hls_1_rowlen_memstream_wrapper.v
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_1 -force -norecurse /home/changhong/prj/finn_cli_fork/finn-rtllib/axi/hdl/axilite.sv
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_1 -force -norecurse /home/changhong/prj/finn_cli_fork/finn-rtllib/memstream/hdl/memstream_axi.sv
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_1 -force -norecurse /home/changhong/prj/finn_cli_fork/finn-rtllib/memstream/hdl/memstream.sv
update_compile_order -fileset sources_1
create_bd_cell -type hier -reference MVAU_hls_1_rowlen_memstream_wrapper /MVAU_hls_1/MVAU_hls_1_wstrm_rowlen
connect_bd_net [get_bd_pins /MVAU_hls_1/ap_clk] [get_bd_pins /MVAU_hls_1/MVAU_hls_1_wstrm_rowlen/ap_clk]
connect_bd_net [get_bd_pins /MVAU_hls_1/ap_rst_n] [get_bd_pins /MVAU_hls_1/MVAU_hls_1_wstrm_rowlen/ap_rst_n]
connect_bd_net [get_bd_pins /MVAU_hls_1/ap_clk] [get_bd_pins /MVAU_hls_1/MVAU_hls_1_wstrm_rowlen/ap_clk2x]
connect_bd_intf_net [get_bd_intf_pins /MVAU_hls_1/MVAU_hls_1_wstrm_rowlen/m_axis_0] [get_bd_intf_pins /MVAU_hls_1/MVAU_hls_1/rowlen_V]
if {![llength [get_bd_intf_pins -quiet /MVAU_hls_1/s_axilite_sfidx]]} { create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 /MVAU_hls_1/s_axilite_sfidx }
connect_bd_intf_net [get_bd_intf_pins /MVAU_hls_1/s_axilite_sfidx] [get_bd_intf_pins /MVAU_hls_1/MVAU_hls_1_wstrm_sfidx/s_axilite]
if {![llength [get_bd_intf_pins -quiet /MVAU_hls_1/s_axilite_val]]} { create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 /MVAU_hls_1/s_axilite_val }
connect_bd_intf_net [get_bd_intf_pins /MVAU_hls_1/s_axilite_val] [get_bd_intf_pins /MVAU_hls_1/MVAU_hls_1_wstrm_val/s_axilite]
if {![llength [get_bd_intf_pins -quiet /MVAU_hls_1/s_axilite_mask]]} { create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 /MVAU_hls_1/s_axilite_mask }
connect_bd_intf_net [get_bd_intf_pins /MVAU_hls_1/s_axilite_mask] [get_bd_intf_pins /MVAU_hls_1/MVAU_hls_1_wstrm_mask/s_axilite]
if {![llength [get_bd_intf_pins -quiet /MVAU_hls_1/s_axilite_rowlen]]} { create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 /MVAU_hls_1/s_axilite_rowlen }
connect_bd_intf_net [get_bd_intf_pins /MVAU_hls_1/s_axilite_rowlen] [get_bd_intf_pins /MVAU_hls_1/MVAU_hls_1_wstrm_rowlen/s_axilite]
assign_bd_address
save_bd_design
add_files -norecurse /tmp/finn_dev_changhong/code_gen_ipgen_StreamingFIFO_rtl_2_k5_fkpn0/Q_srl.v
add_files -norecurse /tmp/finn_dev_changhong/code_gen_ipgen_StreamingFIFO_rtl_2_k5_fkpn0/StreamingFIFO_rtl_2.v
create_bd_cell -type module -reference StreamingFIFO_rtl_2 StreamingFIFO_rtl_2
if {[catch {current_bd_design} _cur_bd]} { set _cur_bd "" }
if {$_cur_bd eq ""} { create_bd_design "finn_design" }
file mkdir ./ip/verilog/rtl_ops/MVAU_hls_2
if {![llength [get_bd_cells -quiet /MVAU_hls_2]]} { create_bd_cell -type hier MVAU_hls_2 }
if {![llength [get_bd_pins -quiet /MVAU_hls_2/ap_clk]]} { create_bd_pin -dir I -type clk /MVAU_hls_2/ap_clk }
if {![llength [get_bd_pins -quiet /MVAU_hls_2/ap_rst_n]]} { create_bd_pin -dir I -type rst /MVAU_hls_2/ap_rst_n }
# no ap_clk2x on parent
if {![llength [get_bd_intf_pins -quiet /MVAU_hls_2/out0_V]]} {   create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 /MVAU_hls_2/out0_V }
if {![llength [get_bd_intf_pins -quiet /MVAU_hls_2/in0_V]]} {   create_bd_intf_pin -mode Slave  -vlnv xilinx.com:interface:axis_rtl:1.0 /MVAU_hls_2/in0_V }
if {![llength [get_bd_cells -quiet /MVAU_hls_2/MVAU_hls_2]]} {   set _defs [get_ipdefs -all -filter "VLNV =~ xilinx.com:hls:MVAU_hls_2:*"];   if {[llength $_defs]} { create_bd_cell -type ip -vlnv [lindex $_defs 0] /MVAU_hls_2/MVAU_hls_2 }   else { error {HLS IP xilinx.com:hls:MVAU_hls_2:* not found} } }
if {[llength [get_bd_pins -quiet /MVAU_hls_2/MVAU_hls_2/ap_rst_n]]} { connect_bd_net [get_bd_pins /MVAU_hls_2/ap_rst_n] [get_bd_pins /MVAU_hls_2/MVAU_hls_2/ap_rst_n] }
if {[llength [get_bd_pins -quiet /MVAU_hls_2/MVAU_hls_2/ap_clk]]} { connect_bd_net [get_bd_pins /MVAU_hls_2/ap_clk] [get_bd_pins /MVAU_hls_2/MVAU_hls_2/ap_clk] }
if {[llength [get_bd_intf_pins -quiet /MVAU_hls_2/MVAU_hls_2/in0_V]]} { connect_bd_intf_net [get_bd_intf_pins /MVAU_hls_2/in0_V] [get_bd_intf_pins /MVAU_hls_2/MVAU_hls_2/in0_V] }
if {[llength [get_bd_intf_pins -quiet /MVAU_hls_2/MVAU_hls_2/out0_V]]} { connect_bd_intf_net [get_bd_intf_pins /MVAU_hls_2/out0_V] [get_bd_intf_pins /MVAU_hls_2/MVAU_hls_2/out0_V] }
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_2 -force -norecurse /tmp/finn_dev_changhong/code_gen_ipgen_MVAU_hls_2_77y5pwt9/MVAU_hls_2_sfidx_memstream_wrapper.v
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_2 -force -norecurse /home/changhong/prj/finn_cli_fork/finn-rtllib/axi/hdl/axilite.sv
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_2 -force -norecurse /home/changhong/prj/finn_cli_fork/finn-rtllib/memstream/hdl/memstream_axi.sv
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_2 -force -norecurse /home/changhong/prj/finn_cli_fork/finn-rtllib/memstream/hdl/memstream.sv
update_compile_order -fileset sources_1
create_bd_cell -type hier -reference MVAU_hls_2_sfidx_memstream_wrapper /MVAU_hls_2/MVAU_hls_2_wstrm_sfidx
connect_bd_net [get_bd_pins /MVAU_hls_2/ap_clk] [get_bd_pins /MVAU_hls_2/MVAU_hls_2_wstrm_sfidx/ap_clk]
connect_bd_net [get_bd_pins /MVAU_hls_2/ap_rst_n] [get_bd_pins /MVAU_hls_2/MVAU_hls_2_wstrm_sfidx/ap_rst_n]
connect_bd_net [get_bd_pins /MVAU_hls_2/ap_clk] [get_bd_pins /MVAU_hls_2/MVAU_hls_2_wstrm_sfidx/ap_clk2x]
connect_bd_intf_net [get_bd_intf_pins /MVAU_hls_2/MVAU_hls_2_wstrm_sfidx/m_axis_0] [get_bd_intf_pins /MVAU_hls_2/MVAU_hls_2/sfidx_V]
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_2 -force -norecurse /tmp/finn_dev_changhong/code_gen_ipgen_MVAU_hls_2_77y5pwt9/MVAU_hls_2_val_memstream_wrapper.v
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_2 -force -norecurse /home/changhong/prj/finn_cli_fork/finn-rtllib/axi/hdl/axilite.sv
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_2 -force -norecurse /home/changhong/prj/finn_cli_fork/finn-rtllib/memstream/hdl/memstream_axi.sv
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_2 -force -norecurse /home/changhong/prj/finn_cli_fork/finn-rtllib/memstream/hdl/memstream.sv
update_compile_order -fileset sources_1
create_bd_cell -type hier -reference MVAU_hls_2_val_memstream_wrapper /MVAU_hls_2/MVAU_hls_2_wstrm_val
connect_bd_net [get_bd_pins /MVAU_hls_2/ap_clk] [get_bd_pins /MVAU_hls_2/MVAU_hls_2_wstrm_val/ap_clk]
connect_bd_net [get_bd_pins /MVAU_hls_2/ap_rst_n] [get_bd_pins /MVAU_hls_2/MVAU_hls_2_wstrm_val/ap_rst_n]
connect_bd_net [get_bd_pins /MVAU_hls_2/ap_clk] [get_bd_pins /MVAU_hls_2/MVAU_hls_2_wstrm_val/ap_clk2x]
connect_bd_intf_net [get_bd_intf_pins /MVAU_hls_2/MVAU_hls_2_wstrm_val/m_axis_0] [get_bd_intf_pins /MVAU_hls_2/MVAU_hls_2/val_V]
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_2 -force -norecurse /tmp/finn_dev_changhong/code_gen_ipgen_MVAU_hls_2_77y5pwt9/MVAU_hls_2_mask_memstream_wrapper.v
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_2 -force -norecurse /home/changhong/prj/finn_cli_fork/finn-rtllib/axi/hdl/axilite.sv
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_2 -force -norecurse /home/changhong/prj/finn_cli_fork/finn-rtllib/memstream/hdl/memstream_axi.sv
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_2 -force -norecurse /home/changhong/prj/finn_cli_fork/finn-rtllib/memstream/hdl/memstream.sv
update_compile_order -fileset sources_1
create_bd_cell -type hier -reference MVAU_hls_2_mask_memstream_wrapper /MVAU_hls_2/MVAU_hls_2_wstrm_mask
connect_bd_net [get_bd_pins /MVAU_hls_2/ap_clk] [get_bd_pins /MVAU_hls_2/MVAU_hls_2_wstrm_mask/ap_clk]
connect_bd_net [get_bd_pins /MVAU_hls_2/ap_rst_n] [get_bd_pins /MVAU_hls_2/MVAU_hls_2_wstrm_mask/ap_rst_n]
connect_bd_net [get_bd_pins /MVAU_hls_2/ap_clk] [get_bd_pins /MVAU_hls_2/MVAU_hls_2_wstrm_mask/ap_clk2x]
connect_bd_intf_net [get_bd_intf_pins /MVAU_hls_2/MVAU_hls_2_wstrm_mask/m_axis_0] [get_bd_intf_pins /MVAU_hls_2/MVAU_hls_2/mask_V]
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_2 -force -norecurse /tmp/finn_dev_changhong/code_gen_ipgen_MVAU_hls_2_77y5pwt9/MVAU_hls_2_rowlen_memstream_wrapper.v
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_2 -force -norecurse /home/changhong/prj/finn_cli_fork/finn-rtllib/axi/hdl/axilite.sv
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_2 -force -norecurse /home/changhong/prj/finn_cli_fork/finn-rtllib/memstream/hdl/memstream_axi.sv
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_2 -force -norecurse /home/changhong/prj/finn_cli_fork/finn-rtllib/memstream/hdl/memstream.sv
update_compile_order -fileset sources_1
create_bd_cell -type hier -reference MVAU_hls_2_rowlen_memstream_wrapper /MVAU_hls_2/MVAU_hls_2_wstrm_rowlen
connect_bd_net [get_bd_pins /MVAU_hls_2/ap_clk] [get_bd_pins /MVAU_hls_2/MVAU_hls_2_wstrm_rowlen/ap_clk]
connect_bd_net [get_bd_pins /MVAU_hls_2/ap_rst_n] [get_bd_pins /MVAU_hls_2/MVAU_hls_2_wstrm_rowlen/ap_rst_n]
connect_bd_net [get_bd_pins /MVAU_hls_2/ap_clk] [get_bd_pins /MVAU_hls_2/MVAU_hls_2_wstrm_rowlen/ap_clk2x]
connect_bd_intf_net [get_bd_intf_pins /MVAU_hls_2/MVAU_hls_2_wstrm_rowlen/m_axis_0] [get_bd_intf_pins /MVAU_hls_2/MVAU_hls_2/rowlen_V]
if {![llength [get_bd_intf_pins -quiet /MVAU_hls_2/s_axilite_sfidx]]} { create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 /MVAU_hls_2/s_axilite_sfidx }
connect_bd_intf_net [get_bd_intf_pins /MVAU_hls_2/s_axilite_sfidx] [get_bd_intf_pins /MVAU_hls_2/MVAU_hls_2_wstrm_sfidx/s_axilite]
if {![llength [get_bd_intf_pins -quiet /MVAU_hls_2/s_axilite_val]]} { create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 /MVAU_hls_2/s_axilite_val }
connect_bd_intf_net [get_bd_intf_pins /MVAU_hls_2/s_axilite_val] [get_bd_intf_pins /MVAU_hls_2/MVAU_hls_2_wstrm_val/s_axilite]
if {![llength [get_bd_intf_pins -quiet /MVAU_hls_2/s_axilite_mask]]} { create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 /MVAU_hls_2/s_axilite_mask }
connect_bd_intf_net [get_bd_intf_pins /MVAU_hls_2/s_axilite_mask] [get_bd_intf_pins /MVAU_hls_2/MVAU_hls_2_wstrm_mask/s_axilite]
if {![llength [get_bd_intf_pins -quiet /MVAU_hls_2/s_axilite_rowlen]]} { create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 /MVAU_hls_2/s_axilite_rowlen }
connect_bd_intf_net [get_bd_intf_pins /MVAU_hls_2/s_axilite_rowlen] [get_bd_intf_pins /MVAU_hls_2/MVAU_hls_2_wstrm_rowlen/s_axilite]
assign_bd_address
save_bd_design
add_files -norecurse /tmp/finn_dev_changhong/code_gen_ipgen_StreamingFIFO_rtl_3_4n61fioa/Q_srl.v
add_files -norecurse /tmp/finn_dev_changhong/code_gen_ipgen_StreamingFIFO_rtl_3_4n61fioa/StreamingFIFO_rtl_3.v
create_bd_cell -type module -reference StreamingFIFO_rtl_3 StreamingFIFO_rtl_3
file mkdir ./ip/verilog/rtl_ops/MVAU_hls_3
create_bd_cell -type hier MVAU_hls_3
create_bd_pin -dir I -type clk /MVAU_hls_3/ap_clk
create_bd_pin -dir I -type rst /MVAU_hls_3/ap_rst_n
create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 /MVAU_hls_3/out0_V
create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 /MVAU_hls_3/in0_V
create_bd_cell -type ip -vlnv xilinx.com:hls:MVAU_hls_3:1.0 /MVAU_hls_3/MVAU_hls_3
connect_bd_net [get_bd_pins MVAU_hls_3/ap_rst_n] [get_bd_pins MVAU_hls_3/MVAU_hls_3/ap_rst_n]
connect_bd_net [get_bd_pins MVAU_hls_3/ap_clk] [get_bd_pins MVAU_hls_3/MVAU_hls_3/ap_clk]
connect_bd_intf_net [get_bd_intf_pins MVAU_hls_3/in0_V] [get_bd_intf_pins MVAU_hls_3/MVAU_hls_3/in0_V]
connect_bd_intf_net [get_bd_intf_pins MVAU_hls_3/out0_V] [get_bd_intf_pins MVAU_hls_3/MVAU_hls_3/out0_V]
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_3 -norecurse /tmp/finn_dev_changhong/code_gen_ipgen_MVAU_hls_3_bvw1qno4/MVAU_hls_3_memstream_wrapper.v
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_3 -norecurse /home/changhong/prj/finn_cli_fork/finn-rtllib/axi/hdl/axilite.sv
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_3 -norecurse /home/changhong/prj/finn_cli_fork/finn-rtllib/memstream/hdl/memstream_axi.sv
add_files -copy_to ./ip/verilog/rtl_ops/MVAU_hls_3 -norecurse /home/changhong/prj/finn_cli_fork/finn-rtllib/memstream/hdl/memstream.sv
create_bd_cell -type hier -reference MVAU_hls_3_memstream_wrapper /MVAU_hls_3/MVAU_hls_3_wstrm
connect_bd_net [get_bd_pins MVAU_hls_3/ap_clk] [get_bd_pins MVAU_hls_3/MVAU_hls_3_wstrm/ap_clk]
connect_bd_net [get_bd_pins MVAU_hls_3/ap_rst_n] [get_bd_pins MVAU_hls_3/MVAU_hls_3_wstrm/ap_rst_n]
connect_bd_net [get_bd_pins MVAU_hls_3/ap_clk] [get_bd_pins MVAU_hls_3/MVAU_hls_3_wstrm/ap_clk2x]
connect_bd_intf_net [get_bd_intf_pins MVAU_hls_3/MVAU_hls_3_wstrm/m_axis_0] [get_bd_intf_pins MVAU_hls_3/MVAU_hls_3/in1_V]
save_bd_design
add_files -norecurse /tmp/finn_dev_changhong/code_gen_ipgen_StreamingFIFO_rtl_4_ijevs4o7/Q_srl.v
add_files -norecurse /tmp/finn_dev_changhong/code_gen_ipgen_StreamingFIFO_rtl_4_ijevs4o7/StreamingFIFO_rtl_4.v
create_bd_cell -type module -reference StreamingFIFO_rtl_4 StreamingFIFO_rtl_4
make_bd_pins_external [get_bd_pins StreamingFIFO_rtl_0/ap_clk]
set_property name ap_clk [get_bd_ports ap_clk_0]
make_bd_pins_external [get_bd_pins StreamingFIFO_rtl_0/ap_rst_n]
set_property name ap_rst_n [get_bd_ports ap_rst_n_0]
connect_bd_net [get_bd_ports ap_rst_n] [get_bd_pins MVAU_hls_0/ap_rst_n]
connect_bd_net [get_bd_ports ap_clk] [get_bd_pins MVAU_hls_0/ap_clk]
connect_bd_intf_net [get_bd_intf_pins StreamingFIFO_rtl_0/out0_V] [get_bd_intf_pins MVAU_hls_0/in0_V]
connect_bd_net [get_bd_ports ap_rst_n] [get_bd_pins StreamingFIFO_rtl_1/ap_rst_n]
connect_bd_net [get_bd_ports ap_clk] [get_bd_pins StreamingFIFO_rtl_1/ap_clk]
connect_bd_intf_net [get_bd_intf_pins MVAU_hls_0/out0_V] [get_bd_intf_pins StreamingFIFO_rtl_1/in0_V]
connect_bd_net [get_bd_ports ap_rst_n] [get_bd_pins MVAU_hls_1/ap_rst_n]
connect_bd_net [get_bd_ports ap_clk] [get_bd_pins MVAU_hls_1/ap_clk]
connect_bd_intf_net [get_bd_intf_pins StreamingFIFO_rtl_1/out0_V] [get_bd_intf_pins MVAU_hls_1/in0_V]
connect_bd_net [get_bd_ports ap_rst_n] [get_bd_pins StreamingFIFO_rtl_2/ap_rst_n]
connect_bd_net [get_bd_ports ap_clk] [get_bd_pins StreamingFIFO_rtl_2/ap_clk]
connect_bd_intf_net [get_bd_intf_pins MVAU_hls_1/out0_V] [get_bd_intf_pins StreamingFIFO_rtl_2/in0_V]
connect_bd_net [get_bd_ports ap_rst_n] [get_bd_pins MVAU_hls_2/ap_rst_n]
connect_bd_net [get_bd_ports ap_clk] [get_bd_pins MVAU_hls_2/ap_clk]
connect_bd_intf_net [get_bd_intf_pins StreamingFIFO_rtl_2/out0_V] [get_bd_intf_pins MVAU_hls_2/in0_V]
connect_bd_net [get_bd_ports ap_rst_n] [get_bd_pins StreamingFIFO_rtl_3/ap_rst_n]
connect_bd_net [get_bd_ports ap_clk] [get_bd_pins StreamingFIFO_rtl_3/ap_clk]
connect_bd_intf_net [get_bd_intf_pins MVAU_hls_2/out0_V] [get_bd_intf_pins StreamingFIFO_rtl_3/in0_V]
connect_bd_net [get_bd_ports ap_rst_n] [get_bd_pins MVAU_hls_3/ap_rst_n]
connect_bd_net [get_bd_ports ap_clk] [get_bd_pins MVAU_hls_3/ap_clk]
connect_bd_intf_net [get_bd_intf_pins StreamingFIFO_rtl_3/out0_V] [get_bd_intf_pins MVAU_hls_3/in0_V]
connect_bd_net [get_bd_ports ap_rst_n] [get_bd_pins StreamingFIFO_rtl_4/ap_rst_n]
connect_bd_net [get_bd_ports ap_clk] [get_bd_pins StreamingFIFO_rtl_4/ap_clk]
connect_bd_intf_net [get_bd_intf_pins MVAU_hls_3/out0_V] [get_bd_intf_pins StreamingFIFO_rtl_4/in0_V]
make_bd_intf_pins_external [get_bd_intf_pins StreamingFIFO_rtl_0/in0_V]
set_property name s_axis_0 [get_bd_intf_ports in0_V_0]
make_bd_intf_pins_external [get_bd_intf_pins StreamingFIFO_rtl_4/out0_V]
set_property name m_axis_0 [get_bd_intf_ports out0_V_0]
set_property CONFIG.FREQ_HZ 100000000 [get_bd_ports /ap_clk]
validate_bd_design
save_bd_design
make_wrapper -files [get_files /tmp/finn_dev_changhong/vivado_stitch_proj_6ygkx3ag/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/finn_design.bd] -top
add_files -norecurse /tmp/finn_dev_changhong/vivado_stitch_proj_6ygkx3ag/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/hdl/finn_design_wrapper.v
set_property top finn_design_wrapper [current_fileset]
ipx::package_project -root_dir /tmp/finn_dev_changhong/vivado_stitch_proj_6ygkx3ag/ip -vendor xilinx_finn -library finn -taxonomy /UserIP -module finn_design -import_files
set_property ipi_drc {ignore_freq_hz true} [ipx::current_core]
ipx::remove_segment -quiet m_axi_gmem0:APERTURE_0 [ipx::get_address_spaces m_axi_gmem0 -of_objects [ipx::current_core]]
set_property core_revision 2 [ipx::find_open_core xilinx_finn:finn:finn_design:1.0]
ipx::create_xgui_files [ipx::find_open_core xilinx_finn:finn:finn_design:1.0]
set_property value_resolve_type user [ipx::get_bus_parameters -of [ipx::get_bus_interfaces -of [ipx::current_core ]]]

set core [ipx::current_core]

# Add rudimentary driver
file copy -force data ip/
set file_group [ipx::add_file_group -type software_driver {} $core]
set_property type mdd       [ipx::add_file data/finn_design.mdd $file_group]
set_property type tclSource [ipx::add_file data/finn_design.tcl $file_group]

# Remove all XCI references to subcores
set impl_files [ipx::get_file_groups xilinx_implementation -of $core]
foreach xci [ipx::get_files -of $impl_files {*.xci}] {
    ipx::remove_file [get_property NAME $xci] $impl_files
}

# Construct a single flat memory map for each AXI-lite interface port
foreach port [get_bd_intf_ports -filter {CONFIG.PROTOCOL==AXI4LITE}] {
    set pin $port
    set awidth ""
    while { $awidth == "" } {
        set pins [get_bd_intf_pins -of [get_bd_intf_nets -boundary_type lower -of $pin]]
        set kill [lsearch $pins $pin]
        if { $kill >= 0 } { set pins [lreplace $pins $kill $kill] }
        if { [llength $pins] != 1 } { break }
        set pin [lindex $pins 0]
        set awidth [get_property CONFIG.ADDR_WIDTH $pin]
    }
    if { $awidth == "" } {
       puts "CRITICAL WARNING: Unable to construct address map for $port."
    } {
       set range [expr 2**$awidth]
       set range [expr $range < 4096 ? 4096 : $range]
       puts "INFO: Building address map for $port: 0+:$range"
       set name [get_property NAME $port]
       set addr_block [ipx::add_address_block Reg0 [ipx::add_memory_map $name $core]]
       set_property range $range $addr_block
       set_property slave_memory_map_ref $name [ipx::get_bus_interfaces $name -of $core]
    }
}

# Finalize and Save
ipx::update_checksums $core
ipx::save_core $core

# Remove stale subcore references from component.xml
file rename -force ip/component.xml ip/component.bak
set ifile [open ip/component.bak r]
set ofile [open ip/component.xml w]
set buf [list]
set kill 0
while { [eof $ifile] != 1 } {
    gets $ifile line
    if { [string match {*<spirit:fileSet>*} $line] == 1 } {
        foreach l $buf { puts $ofile $l }
        set buf [list $line]
    } elseif { [llength $buf] > 0 } {
        lappend buf $line

        if { [string match {*</spirit:fileSet>*} $line] == 1 } {
            if { $kill == 0 } { foreach l $buf { puts $ofile $l } }
            set buf [list]
            set kill 0
        } elseif { [string match {*<xilinx:subCoreRef>*} $line] == 1 } {
            set kill 1
        }
    } else {
        puts $ofile $line
    }
}
close $ifile
close $ofile

set all_v_files [get_files -filter {USED_IN_SYNTHESIS == 1 && (FILE_TYPE == Verilog || FILE_TYPE == SystemVerilog || FILE_TYPE =="Verilog Header")}]
set fp [open /tmp/finn_dev_changhong/vivado_stitch_proj_6ygkx3ag/all_verilog_srcs.txt w]
foreach vf $all_v_files {puts $fp $vf}
close $fp
