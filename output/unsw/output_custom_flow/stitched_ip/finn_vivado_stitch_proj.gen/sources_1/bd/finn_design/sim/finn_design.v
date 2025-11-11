//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
//Date        : Mon Nov 10 16:58:04 2025
//Host        : finn_dev_changhong running 64-bit Ubuntu 22.04.1 LTS
//Command     : generate_target finn_design.bd
//Design      : finn_design
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module MVAU_hls_0_imp_7OH4JA
   (ap_clk,
    ap_rst_n,
    in0_V_tdata,
    in0_V_tready,
    in0_V_tvalid,
    out0_V_tdata,
    out0_V_tready,
    out0_V_tvalid,
    s_axilite_mask_araddr,
    s_axilite_mask_arprot,
    s_axilite_mask_arready,
    s_axilite_mask_arvalid,
    s_axilite_mask_awaddr,
    s_axilite_mask_awprot,
    s_axilite_mask_awready,
    s_axilite_mask_awvalid,
    s_axilite_mask_bready,
    s_axilite_mask_bresp,
    s_axilite_mask_bvalid,
    s_axilite_mask_rdata,
    s_axilite_mask_rready,
    s_axilite_mask_rresp,
    s_axilite_mask_rvalid,
    s_axilite_mask_wdata,
    s_axilite_mask_wready,
    s_axilite_mask_wstrb,
    s_axilite_mask_wvalid,
    s_axilite_rowlen_araddr,
    s_axilite_rowlen_arprot,
    s_axilite_rowlen_arready,
    s_axilite_rowlen_arvalid,
    s_axilite_rowlen_awaddr,
    s_axilite_rowlen_awprot,
    s_axilite_rowlen_awready,
    s_axilite_rowlen_awvalid,
    s_axilite_rowlen_bready,
    s_axilite_rowlen_bresp,
    s_axilite_rowlen_bvalid,
    s_axilite_rowlen_rdata,
    s_axilite_rowlen_rready,
    s_axilite_rowlen_rresp,
    s_axilite_rowlen_rvalid,
    s_axilite_rowlen_wdata,
    s_axilite_rowlen_wready,
    s_axilite_rowlen_wstrb,
    s_axilite_rowlen_wvalid,
    s_axilite_sfidx_araddr,
    s_axilite_sfidx_arprot,
    s_axilite_sfidx_arready,
    s_axilite_sfidx_arvalid,
    s_axilite_sfidx_awaddr,
    s_axilite_sfidx_awprot,
    s_axilite_sfidx_awready,
    s_axilite_sfidx_awvalid,
    s_axilite_sfidx_bready,
    s_axilite_sfidx_bresp,
    s_axilite_sfidx_bvalid,
    s_axilite_sfidx_rdata,
    s_axilite_sfidx_rready,
    s_axilite_sfidx_rresp,
    s_axilite_sfidx_rvalid,
    s_axilite_sfidx_wdata,
    s_axilite_sfidx_wready,
    s_axilite_sfidx_wstrb,
    s_axilite_sfidx_wvalid,
    s_axilite_val_araddr,
    s_axilite_val_arprot,
    s_axilite_val_arready,
    s_axilite_val_arvalid,
    s_axilite_val_awaddr,
    s_axilite_val_awprot,
    s_axilite_val_awready,
    s_axilite_val_awvalid,
    s_axilite_val_bready,
    s_axilite_val_bresp,
    s_axilite_val_bvalid,
    s_axilite_val_rdata,
    s_axilite_val_rready,
    s_axilite_val_rresp,
    s_axilite_val_rvalid,
    s_axilite_val_wdata,
    s_axilite_val_wready,
    s_axilite_val_wstrb,
    s_axilite_val_wvalid);
  input ap_clk;
  input ap_rst_n;
  input [7:0]in0_V_tdata;
  output in0_V_tready;
  input in0_V_tvalid;
  output [7:0]out0_V_tdata;
  input out0_V_tready;
  output out0_V_tvalid;
  input s_axilite_mask_araddr;
  input s_axilite_mask_arprot;
  output s_axilite_mask_arready;
  input s_axilite_mask_arvalid;
  input s_axilite_mask_awaddr;
  input s_axilite_mask_awprot;
  output s_axilite_mask_awready;
  input s_axilite_mask_awvalid;
  input s_axilite_mask_bready;
  output s_axilite_mask_bresp;
  output s_axilite_mask_bvalid;
  output s_axilite_mask_rdata;
  input s_axilite_mask_rready;
  output s_axilite_mask_rresp;
  output s_axilite_mask_rvalid;
  input s_axilite_mask_wdata;
  output s_axilite_mask_wready;
  input s_axilite_mask_wstrb;
  input s_axilite_mask_wvalid;
  input s_axilite_rowlen_araddr;
  input s_axilite_rowlen_arprot;
  output s_axilite_rowlen_arready;
  input s_axilite_rowlen_arvalid;
  input s_axilite_rowlen_awaddr;
  input s_axilite_rowlen_awprot;
  output s_axilite_rowlen_awready;
  input s_axilite_rowlen_awvalid;
  input s_axilite_rowlen_bready;
  output s_axilite_rowlen_bresp;
  output s_axilite_rowlen_bvalid;
  output s_axilite_rowlen_rdata;
  input s_axilite_rowlen_rready;
  output s_axilite_rowlen_rresp;
  output s_axilite_rowlen_rvalid;
  input s_axilite_rowlen_wdata;
  output s_axilite_rowlen_wready;
  input s_axilite_rowlen_wstrb;
  input s_axilite_rowlen_wvalid;
  input s_axilite_sfidx_araddr;
  input s_axilite_sfidx_arprot;
  output s_axilite_sfidx_arready;
  input s_axilite_sfidx_arvalid;
  input s_axilite_sfidx_awaddr;
  input s_axilite_sfidx_awprot;
  output s_axilite_sfidx_awready;
  input s_axilite_sfidx_awvalid;
  input s_axilite_sfidx_bready;
  output s_axilite_sfidx_bresp;
  output s_axilite_sfidx_bvalid;
  output s_axilite_sfidx_rdata;
  input s_axilite_sfidx_rready;
  output s_axilite_sfidx_rresp;
  output s_axilite_sfidx_rvalid;
  input s_axilite_sfidx_wdata;
  output s_axilite_sfidx_wready;
  input s_axilite_sfidx_wstrb;
  input s_axilite_sfidx_wvalid;
  input s_axilite_val_araddr;
  input s_axilite_val_arprot;
  output s_axilite_val_arready;
  input s_axilite_val_arvalid;
  input s_axilite_val_awaddr;
  input s_axilite_val_awprot;
  output s_axilite_val_awready;
  input s_axilite_val_awvalid;
  input s_axilite_val_bready;
  output s_axilite_val_bresp;
  output s_axilite_val_bvalid;
  output s_axilite_val_rdata;
  input s_axilite_val_rready;
  output s_axilite_val_rresp;
  output s_axilite_val_rvalid;
  input s_axilite_val_wdata;
  output s_axilite_val_wready;
  input s_axilite_val_wstrb;
  input s_axilite_val_wvalid;

  wire [7:0]MVAU_hls_0_out0_V_TDATA;
  wire MVAU_hls_0_out0_V_TREADY;
  wire MVAU_hls_0_out0_V_TVALID;
  wire [7:0]MVAU_hls_0_wstrm_mask_m_axis_0_TDATA;
  wire MVAU_hls_0_wstrm_mask_m_axis_0_TREADY;
  wire MVAU_hls_0_wstrm_mask_m_axis_0_TVALID;
  wire [15:0]MVAU_hls_0_wstrm_rowlen_m_axis_0_TDATA;
  wire MVAU_hls_0_wstrm_rowlen_m_axis_0_TREADY;
  wire MVAU_hls_0_wstrm_rowlen_m_axis_0_TVALID;
  wire [31:0]MVAU_hls_0_wstrm_sfidx_m_axis_0_TDATA;
  wire MVAU_hls_0_wstrm_sfidx_m_axis_0_TREADY;
  wire MVAU_hls_0_wstrm_sfidx_m_axis_0_TVALID;
  wire [7:0]MVAU_hls_0_wstrm_val_m_axis_0_TDATA;
  wire MVAU_hls_0_wstrm_val_m_axis_0_TREADY;
  wire MVAU_hls_0_wstrm_val_m_axis_0_TVALID;
  wire ap_clk_1;
  wire ap_rst_n_1;
  wire [7:0]in0_V_1_TDATA;
  wire in0_V_1_TREADY;
  wire in0_V_1_TVALID;
  wire s_axilite_mask_1_ARADDR;
  wire s_axilite_mask_1_ARPROT;
  wire s_axilite_mask_1_ARREADY;
  wire s_axilite_mask_1_ARVALID;
  wire s_axilite_mask_1_AWADDR;
  wire s_axilite_mask_1_AWPROT;
  wire s_axilite_mask_1_AWREADY;
  wire s_axilite_mask_1_AWVALID;
  wire s_axilite_mask_1_BREADY;
  wire [1:0]s_axilite_mask_1_BRESP;
  wire s_axilite_mask_1_BVALID;
  wire [31:0]s_axilite_mask_1_RDATA;
  wire s_axilite_mask_1_RREADY;
  wire [1:0]s_axilite_mask_1_RRESP;
  wire s_axilite_mask_1_RVALID;
  wire s_axilite_mask_1_WDATA;
  wire s_axilite_mask_1_WREADY;
  wire s_axilite_mask_1_WSTRB;
  wire s_axilite_mask_1_WVALID;
  wire s_axilite_rowlen_1_ARADDR;
  wire s_axilite_rowlen_1_ARPROT;
  wire s_axilite_rowlen_1_ARREADY;
  wire s_axilite_rowlen_1_ARVALID;
  wire s_axilite_rowlen_1_AWADDR;
  wire s_axilite_rowlen_1_AWPROT;
  wire s_axilite_rowlen_1_AWREADY;
  wire s_axilite_rowlen_1_AWVALID;
  wire s_axilite_rowlen_1_BREADY;
  wire [1:0]s_axilite_rowlen_1_BRESP;
  wire s_axilite_rowlen_1_BVALID;
  wire [31:0]s_axilite_rowlen_1_RDATA;
  wire s_axilite_rowlen_1_RREADY;
  wire [1:0]s_axilite_rowlen_1_RRESP;
  wire s_axilite_rowlen_1_RVALID;
  wire s_axilite_rowlen_1_WDATA;
  wire s_axilite_rowlen_1_WREADY;
  wire s_axilite_rowlen_1_WSTRB;
  wire s_axilite_rowlen_1_WVALID;
  wire s_axilite_sfidx_1_ARADDR;
  wire s_axilite_sfidx_1_ARPROT;
  wire s_axilite_sfidx_1_ARREADY;
  wire s_axilite_sfidx_1_ARVALID;
  wire s_axilite_sfidx_1_AWADDR;
  wire s_axilite_sfidx_1_AWPROT;
  wire s_axilite_sfidx_1_AWREADY;
  wire s_axilite_sfidx_1_AWVALID;
  wire s_axilite_sfidx_1_BREADY;
  wire [1:0]s_axilite_sfidx_1_BRESP;
  wire s_axilite_sfidx_1_BVALID;
  wire [31:0]s_axilite_sfidx_1_RDATA;
  wire s_axilite_sfidx_1_RREADY;
  wire [1:0]s_axilite_sfidx_1_RRESP;
  wire s_axilite_sfidx_1_RVALID;
  wire s_axilite_sfidx_1_WDATA;
  wire s_axilite_sfidx_1_WREADY;
  wire s_axilite_sfidx_1_WSTRB;
  wire s_axilite_sfidx_1_WVALID;
  wire s_axilite_val_1_ARADDR;
  wire s_axilite_val_1_ARPROT;
  wire s_axilite_val_1_ARREADY;
  wire s_axilite_val_1_ARVALID;
  wire s_axilite_val_1_AWADDR;
  wire s_axilite_val_1_AWPROT;
  wire s_axilite_val_1_AWREADY;
  wire s_axilite_val_1_AWVALID;
  wire s_axilite_val_1_BREADY;
  wire [1:0]s_axilite_val_1_BRESP;
  wire s_axilite_val_1_BVALID;
  wire [31:0]s_axilite_val_1_RDATA;
  wire s_axilite_val_1_RREADY;
  wire [1:0]s_axilite_val_1_RRESP;
  wire s_axilite_val_1_RVALID;
  wire s_axilite_val_1_WDATA;
  wire s_axilite_val_1_WREADY;
  wire s_axilite_val_1_WSTRB;
  wire s_axilite_val_1_WVALID;

  assign MVAU_hls_0_out0_V_TREADY = out0_V_tready;
  assign ap_clk_1 = ap_clk;
  assign ap_rst_n_1 = ap_rst_n;
  assign in0_V_1_TDATA = in0_V_tdata[7:0];
  assign in0_V_1_TVALID = in0_V_tvalid;
  assign in0_V_tready = in0_V_1_TREADY;
  assign out0_V_tdata[7:0] = MVAU_hls_0_out0_V_TDATA;
  assign out0_V_tvalid = MVAU_hls_0_out0_V_TVALID;
  assign s_axilite_mask_1_ARADDR = s_axilite_mask_araddr;
  assign s_axilite_mask_1_ARPROT = s_axilite_mask_arprot;
  assign s_axilite_mask_1_ARVALID = s_axilite_mask_arvalid;
  assign s_axilite_mask_1_AWADDR = s_axilite_mask_awaddr;
  assign s_axilite_mask_1_AWPROT = s_axilite_mask_awprot;
  assign s_axilite_mask_1_AWVALID = s_axilite_mask_awvalid;
  assign s_axilite_mask_1_BREADY = s_axilite_mask_bready;
  assign s_axilite_mask_1_RREADY = s_axilite_mask_rready;
  assign s_axilite_mask_1_WDATA = s_axilite_mask_wdata;
  assign s_axilite_mask_1_WSTRB = s_axilite_mask_wstrb;
  assign s_axilite_mask_1_WVALID = s_axilite_mask_wvalid;
  assign s_axilite_mask_arready = s_axilite_mask_1_ARREADY;
  assign s_axilite_mask_awready = s_axilite_mask_1_AWREADY;
  assign s_axilite_mask_bresp = s_axilite_mask_1_BRESP[0];
  assign s_axilite_mask_bvalid = s_axilite_mask_1_BVALID;
  assign s_axilite_mask_rdata = s_axilite_mask_1_RDATA[0];
  assign s_axilite_mask_rresp = s_axilite_mask_1_RRESP[0];
  assign s_axilite_mask_rvalid = s_axilite_mask_1_RVALID;
  assign s_axilite_mask_wready = s_axilite_mask_1_WREADY;
  assign s_axilite_rowlen_1_ARADDR = s_axilite_rowlen_araddr;
  assign s_axilite_rowlen_1_ARPROT = s_axilite_rowlen_arprot;
  assign s_axilite_rowlen_1_ARVALID = s_axilite_rowlen_arvalid;
  assign s_axilite_rowlen_1_AWADDR = s_axilite_rowlen_awaddr;
  assign s_axilite_rowlen_1_AWPROT = s_axilite_rowlen_awprot;
  assign s_axilite_rowlen_1_AWVALID = s_axilite_rowlen_awvalid;
  assign s_axilite_rowlen_1_BREADY = s_axilite_rowlen_bready;
  assign s_axilite_rowlen_1_RREADY = s_axilite_rowlen_rready;
  assign s_axilite_rowlen_1_WDATA = s_axilite_rowlen_wdata;
  assign s_axilite_rowlen_1_WSTRB = s_axilite_rowlen_wstrb;
  assign s_axilite_rowlen_1_WVALID = s_axilite_rowlen_wvalid;
  assign s_axilite_rowlen_arready = s_axilite_rowlen_1_ARREADY;
  assign s_axilite_rowlen_awready = s_axilite_rowlen_1_AWREADY;
  assign s_axilite_rowlen_bresp = s_axilite_rowlen_1_BRESP[0];
  assign s_axilite_rowlen_bvalid = s_axilite_rowlen_1_BVALID;
  assign s_axilite_rowlen_rdata = s_axilite_rowlen_1_RDATA[0];
  assign s_axilite_rowlen_rresp = s_axilite_rowlen_1_RRESP[0];
  assign s_axilite_rowlen_rvalid = s_axilite_rowlen_1_RVALID;
  assign s_axilite_rowlen_wready = s_axilite_rowlen_1_WREADY;
  assign s_axilite_sfidx_1_ARADDR = s_axilite_sfidx_araddr;
  assign s_axilite_sfidx_1_ARPROT = s_axilite_sfidx_arprot;
  assign s_axilite_sfidx_1_ARVALID = s_axilite_sfidx_arvalid;
  assign s_axilite_sfidx_1_AWADDR = s_axilite_sfidx_awaddr;
  assign s_axilite_sfidx_1_AWPROT = s_axilite_sfidx_awprot;
  assign s_axilite_sfidx_1_AWVALID = s_axilite_sfidx_awvalid;
  assign s_axilite_sfidx_1_BREADY = s_axilite_sfidx_bready;
  assign s_axilite_sfidx_1_RREADY = s_axilite_sfidx_rready;
  assign s_axilite_sfidx_1_WDATA = s_axilite_sfidx_wdata;
  assign s_axilite_sfidx_1_WSTRB = s_axilite_sfidx_wstrb;
  assign s_axilite_sfidx_1_WVALID = s_axilite_sfidx_wvalid;
  assign s_axilite_sfidx_arready = s_axilite_sfidx_1_ARREADY;
  assign s_axilite_sfidx_awready = s_axilite_sfidx_1_AWREADY;
  assign s_axilite_sfidx_bresp = s_axilite_sfidx_1_BRESP[0];
  assign s_axilite_sfidx_bvalid = s_axilite_sfidx_1_BVALID;
  assign s_axilite_sfidx_rdata = s_axilite_sfidx_1_RDATA[0];
  assign s_axilite_sfidx_rresp = s_axilite_sfidx_1_RRESP[0];
  assign s_axilite_sfidx_rvalid = s_axilite_sfidx_1_RVALID;
  assign s_axilite_sfidx_wready = s_axilite_sfidx_1_WREADY;
  assign s_axilite_val_1_ARADDR = s_axilite_val_araddr;
  assign s_axilite_val_1_ARPROT = s_axilite_val_arprot;
  assign s_axilite_val_1_ARVALID = s_axilite_val_arvalid;
  assign s_axilite_val_1_AWADDR = s_axilite_val_awaddr;
  assign s_axilite_val_1_AWPROT = s_axilite_val_awprot;
  assign s_axilite_val_1_AWVALID = s_axilite_val_awvalid;
  assign s_axilite_val_1_BREADY = s_axilite_val_bready;
  assign s_axilite_val_1_RREADY = s_axilite_val_rready;
  assign s_axilite_val_1_WDATA = s_axilite_val_wdata;
  assign s_axilite_val_1_WSTRB = s_axilite_val_wstrb;
  assign s_axilite_val_1_WVALID = s_axilite_val_wvalid;
  assign s_axilite_val_arready = s_axilite_val_1_ARREADY;
  assign s_axilite_val_awready = s_axilite_val_1_AWREADY;
  assign s_axilite_val_bresp = s_axilite_val_1_BRESP[0];
  assign s_axilite_val_bvalid = s_axilite_val_1_BVALID;
  assign s_axilite_val_rdata = s_axilite_val_1_RDATA[0];
  assign s_axilite_val_rresp = s_axilite_val_1_RRESP[0];
  assign s_axilite_val_rvalid = s_axilite_val_1_RVALID;
  assign s_axilite_val_wready = s_axilite_val_1_WREADY;
  finn_design_MVAU_hls_0_0 MVAU_hls_0
       (.ap_clk(ap_clk_1),
        .ap_rst_n(ap_rst_n_1),
        .in0_V_TDATA(in0_V_1_TDATA),
        .in0_V_TREADY(in0_V_1_TREADY),
        .in0_V_TVALID(in0_V_1_TVALID),
        .mask_V_TDATA(MVAU_hls_0_wstrm_mask_m_axis_0_TDATA),
        .mask_V_TREADY(MVAU_hls_0_wstrm_mask_m_axis_0_TREADY),
        .mask_V_TVALID(MVAU_hls_0_wstrm_mask_m_axis_0_TVALID),
        .out0_V_TDATA(MVAU_hls_0_out0_V_TDATA),
        .out0_V_TREADY(MVAU_hls_0_out0_V_TREADY),
        .out0_V_TVALID(MVAU_hls_0_out0_V_TVALID),
        .rowlen_V_TDATA(MVAU_hls_0_wstrm_rowlen_m_axis_0_TDATA),
        .rowlen_V_TREADY(MVAU_hls_0_wstrm_rowlen_m_axis_0_TREADY),
        .rowlen_V_TVALID(MVAU_hls_0_wstrm_rowlen_m_axis_0_TVALID),
        .sfidx_V_TDATA(MVAU_hls_0_wstrm_sfidx_m_axis_0_TDATA),
        .sfidx_V_TREADY(MVAU_hls_0_wstrm_sfidx_m_axis_0_TREADY),
        .sfidx_V_TVALID(MVAU_hls_0_wstrm_sfidx_m_axis_0_TVALID),
        .val_V_TDATA(MVAU_hls_0_wstrm_val_m_axis_0_TDATA),
        .val_V_TREADY(MVAU_hls_0_wstrm_val_m_axis_0_TREADY),
        .val_V_TVALID(MVAU_hls_0_wstrm_val_m_axis_0_TVALID));
  finn_design_MVAU_hls_0_wstrm_mask_0 MVAU_hls_0_wstrm_mask
       (.ap_clk(ap_clk_1),
        .ap_clk2x(ap_clk_1),
        .ap_rst_n(ap_rst_n_1),
        .m_axis_0_tdata(MVAU_hls_0_wstrm_mask_m_axis_0_TDATA),
        .m_axis_0_tready(MVAU_hls_0_wstrm_mask_m_axis_0_TREADY),
        .m_axis_0_tvalid(MVAU_hls_0_wstrm_mask_m_axis_0_TVALID),
        .s_axilite_ARADDR({s_axilite_mask_1_ARADDR,s_axilite_mask_1_ARADDR,s_axilite_mask_1_ARADDR,s_axilite_mask_1_ARADDR,s_axilite_mask_1_ARADDR,s_axilite_mask_1_ARADDR,s_axilite_mask_1_ARADDR,s_axilite_mask_1_ARADDR,s_axilite_mask_1_ARADDR,s_axilite_mask_1_ARADDR,s_axilite_mask_1_ARADDR,s_axilite_mask_1_ARADDR}),
        .s_axilite_ARPROT({s_axilite_mask_1_ARPROT,s_axilite_mask_1_ARPROT,s_axilite_mask_1_ARPROT}),
        .s_axilite_ARREADY(s_axilite_mask_1_ARREADY),
        .s_axilite_ARVALID(s_axilite_mask_1_ARVALID),
        .s_axilite_AWADDR({s_axilite_mask_1_AWADDR,s_axilite_mask_1_AWADDR,s_axilite_mask_1_AWADDR,s_axilite_mask_1_AWADDR,s_axilite_mask_1_AWADDR,s_axilite_mask_1_AWADDR,s_axilite_mask_1_AWADDR,s_axilite_mask_1_AWADDR,s_axilite_mask_1_AWADDR,s_axilite_mask_1_AWADDR,s_axilite_mask_1_AWADDR,s_axilite_mask_1_AWADDR}),
        .s_axilite_AWPROT({s_axilite_mask_1_AWPROT,s_axilite_mask_1_AWPROT,s_axilite_mask_1_AWPROT}),
        .s_axilite_AWREADY(s_axilite_mask_1_AWREADY),
        .s_axilite_AWVALID(s_axilite_mask_1_AWVALID),
        .s_axilite_BREADY(s_axilite_mask_1_BREADY),
        .s_axilite_BRESP(s_axilite_mask_1_BRESP),
        .s_axilite_BVALID(s_axilite_mask_1_BVALID),
        .s_axilite_RDATA(s_axilite_mask_1_RDATA),
        .s_axilite_RREADY(s_axilite_mask_1_RREADY),
        .s_axilite_RRESP(s_axilite_mask_1_RRESP),
        .s_axilite_RVALID(s_axilite_mask_1_RVALID),
        .s_axilite_WDATA({s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA}),
        .s_axilite_WREADY(s_axilite_mask_1_WREADY),
        .s_axilite_WSTRB({s_axilite_mask_1_WSTRB,s_axilite_mask_1_WSTRB,s_axilite_mask_1_WSTRB,s_axilite_mask_1_WSTRB}),
        .s_axilite_WVALID(s_axilite_mask_1_WVALID),
        .s_axis_0_tdata(1'b0),
        .s_axis_0_tvalid(1'b0));
  finn_design_MVAU_hls_0_wstrm_rowlen_0 MVAU_hls_0_wstrm_rowlen
       (.ap_clk(ap_clk_1),
        .ap_clk2x(ap_clk_1),
        .ap_rst_n(ap_rst_n_1),
        .m_axis_0_tdata(MVAU_hls_0_wstrm_rowlen_m_axis_0_TDATA),
        .m_axis_0_tready(MVAU_hls_0_wstrm_rowlen_m_axis_0_TREADY),
        .m_axis_0_tvalid(MVAU_hls_0_wstrm_rowlen_m_axis_0_TVALID),
        .s_axilite_ARADDR({s_axilite_rowlen_1_ARADDR,s_axilite_rowlen_1_ARADDR,s_axilite_rowlen_1_ARADDR,s_axilite_rowlen_1_ARADDR,s_axilite_rowlen_1_ARADDR,s_axilite_rowlen_1_ARADDR,s_axilite_rowlen_1_ARADDR,s_axilite_rowlen_1_ARADDR,s_axilite_rowlen_1_ARADDR,s_axilite_rowlen_1_ARADDR,s_axilite_rowlen_1_ARADDR,s_axilite_rowlen_1_ARADDR}),
        .s_axilite_ARPROT({s_axilite_rowlen_1_ARPROT,s_axilite_rowlen_1_ARPROT,s_axilite_rowlen_1_ARPROT}),
        .s_axilite_ARREADY(s_axilite_rowlen_1_ARREADY),
        .s_axilite_ARVALID(s_axilite_rowlen_1_ARVALID),
        .s_axilite_AWADDR({s_axilite_rowlen_1_AWADDR,s_axilite_rowlen_1_AWADDR,s_axilite_rowlen_1_AWADDR,s_axilite_rowlen_1_AWADDR,s_axilite_rowlen_1_AWADDR,s_axilite_rowlen_1_AWADDR,s_axilite_rowlen_1_AWADDR,s_axilite_rowlen_1_AWADDR,s_axilite_rowlen_1_AWADDR,s_axilite_rowlen_1_AWADDR,s_axilite_rowlen_1_AWADDR,s_axilite_rowlen_1_AWADDR}),
        .s_axilite_AWPROT({s_axilite_rowlen_1_AWPROT,s_axilite_rowlen_1_AWPROT,s_axilite_rowlen_1_AWPROT}),
        .s_axilite_AWREADY(s_axilite_rowlen_1_AWREADY),
        .s_axilite_AWVALID(s_axilite_rowlen_1_AWVALID),
        .s_axilite_BREADY(s_axilite_rowlen_1_BREADY),
        .s_axilite_BRESP(s_axilite_rowlen_1_BRESP),
        .s_axilite_BVALID(s_axilite_rowlen_1_BVALID),
        .s_axilite_RDATA(s_axilite_rowlen_1_RDATA),
        .s_axilite_RREADY(s_axilite_rowlen_1_RREADY),
        .s_axilite_RRESP(s_axilite_rowlen_1_RRESP),
        .s_axilite_RVALID(s_axilite_rowlen_1_RVALID),
        .s_axilite_WDATA({s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA}),
        .s_axilite_WREADY(s_axilite_rowlen_1_WREADY),
        .s_axilite_WSTRB({s_axilite_rowlen_1_WSTRB,s_axilite_rowlen_1_WSTRB,s_axilite_rowlen_1_WSTRB,s_axilite_rowlen_1_WSTRB}),
        .s_axilite_WVALID(s_axilite_rowlen_1_WVALID),
        .s_axis_0_tdata(1'b0),
        .s_axis_0_tvalid(1'b0));
  finn_design_MVAU_hls_0_wstrm_sfidx_0 MVAU_hls_0_wstrm_sfidx
       (.ap_clk(ap_clk_1),
        .ap_clk2x(ap_clk_1),
        .ap_rst_n(ap_rst_n_1),
        .m_axis_0_tdata(MVAU_hls_0_wstrm_sfidx_m_axis_0_TDATA),
        .m_axis_0_tready(MVAU_hls_0_wstrm_sfidx_m_axis_0_TREADY),
        .m_axis_0_tvalid(MVAU_hls_0_wstrm_sfidx_m_axis_0_TVALID),
        .s_axilite_ARADDR({s_axilite_sfidx_1_ARADDR,s_axilite_sfidx_1_ARADDR,s_axilite_sfidx_1_ARADDR,s_axilite_sfidx_1_ARADDR,s_axilite_sfidx_1_ARADDR,s_axilite_sfidx_1_ARADDR,s_axilite_sfidx_1_ARADDR,s_axilite_sfidx_1_ARADDR,s_axilite_sfidx_1_ARADDR,s_axilite_sfidx_1_ARADDR,s_axilite_sfidx_1_ARADDR,s_axilite_sfidx_1_ARADDR}),
        .s_axilite_ARPROT({s_axilite_sfidx_1_ARPROT,s_axilite_sfidx_1_ARPROT,s_axilite_sfidx_1_ARPROT}),
        .s_axilite_ARREADY(s_axilite_sfidx_1_ARREADY),
        .s_axilite_ARVALID(s_axilite_sfidx_1_ARVALID),
        .s_axilite_AWADDR({s_axilite_sfidx_1_AWADDR,s_axilite_sfidx_1_AWADDR,s_axilite_sfidx_1_AWADDR,s_axilite_sfidx_1_AWADDR,s_axilite_sfidx_1_AWADDR,s_axilite_sfidx_1_AWADDR,s_axilite_sfidx_1_AWADDR,s_axilite_sfidx_1_AWADDR,s_axilite_sfidx_1_AWADDR,s_axilite_sfidx_1_AWADDR,s_axilite_sfidx_1_AWADDR,s_axilite_sfidx_1_AWADDR}),
        .s_axilite_AWPROT({s_axilite_sfidx_1_AWPROT,s_axilite_sfidx_1_AWPROT,s_axilite_sfidx_1_AWPROT}),
        .s_axilite_AWREADY(s_axilite_sfidx_1_AWREADY),
        .s_axilite_AWVALID(s_axilite_sfidx_1_AWVALID),
        .s_axilite_BREADY(s_axilite_sfidx_1_BREADY),
        .s_axilite_BRESP(s_axilite_sfidx_1_BRESP),
        .s_axilite_BVALID(s_axilite_sfidx_1_BVALID),
        .s_axilite_RDATA(s_axilite_sfidx_1_RDATA),
        .s_axilite_RREADY(s_axilite_sfidx_1_RREADY),
        .s_axilite_RRESP(s_axilite_sfidx_1_RRESP),
        .s_axilite_RVALID(s_axilite_sfidx_1_RVALID),
        .s_axilite_WDATA({s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA}),
        .s_axilite_WREADY(s_axilite_sfidx_1_WREADY),
        .s_axilite_WSTRB({s_axilite_sfidx_1_WSTRB,s_axilite_sfidx_1_WSTRB,s_axilite_sfidx_1_WSTRB,s_axilite_sfidx_1_WSTRB}),
        .s_axilite_WVALID(s_axilite_sfidx_1_WVALID),
        .s_axis_0_tdata(1'b0),
        .s_axis_0_tvalid(1'b0));
  finn_design_MVAU_hls_0_wstrm_val_0 MVAU_hls_0_wstrm_val
       (.ap_clk(ap_clk_1),
        .ap_clk2x(ap_clk_1),
        .ap_rst_n(ap_rst_n_1),
        .m_axis_0_tdata(MVAU_hls_0_wstrm_val_m_axis_0_TDATA),
        .m_axis_0_tready(MVAU_hls_0_wstrm_val_m_axis_0_TREADY),
        .m_axis_0_tvalid(MVAU_hls_0_wstrm_val_m_axis_0_TVALID),
        .s_axilite_ARADDR({s_axilite_val_1_ARADDR,s_axilite_val_1_ARADDR,s_axilite_val_1_ARADDR,s_axilite_val_1_ARADDR,s_axilite_val_1_ARADDR,s_axilite_val_1_ARADDR,s_axilite_val_1_ARADDR,s_axilite_val_1_ARADDR,s_axilite_val_1_ARADDR,s_axilite_val_1_ARADDR,s_axilite_val_1_ARADDR,s_axilite_val_1_ARADDR}),
        .s_axilite_ARPROT({s_axilite_val_1_ARPROT,s_axilite_val_1_ARPROT,s_axilite_val_1_ARPROT}),
        .s_axilite_ARREADY(s_axilite_val_1_ARREADY),
        .s_axilite_ARVALID(s_axilite_val_1_ARVALID),
        .s_axilite_AWADDR({s_axilite_val_1_AWADDR,s_axilite_val_1_AWADDR,s_axilite_val_1_AWADDR,s_axilite_val_1_AWADDR,s_axilite_val_1_AWADDR,s_axilite_val_1_AWADDR,s_axilite_val_1_AWADDR,s_axilite_val_1_AWADDR,s_axilite_val_1_AWADDR,s_axilite_val_1_AWADDR,s_axilite_val_1_AWADDR,s_axilite_val_1_AWADDR}),
        .s_axilite_AWPROT({s_axilite_val_1_AWPROT,s_axilite_val_1_AWPROT,s_axilite_val_1_AWPROT}),
        .s_axilite_AWREADY(s_axilite_val_1_AWREADY),
        .s_axilite_AWVALID(s_axilite_val_1_AWVALID),
        .s_axilite_BREADY(s_axilite_val_1_BREADY),
        .s_axilite_BRESP(s_axilite_val_1_BRESP),
        .s_axilite_BVALID(s_axilite_val_1_BVALID),
        .s_axilite_RDATA(s_axilite_val_1_RDATA),
        .s_axilite_RREADY(s_axilite_val_1_RREADY),
        .s_axilite_RRESP(s_axilite_val_1_RRESP),
        .s_axilite_RVALID(s_axilite_val_1_RVALID),
        .s_axilite_WDATA({s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA}),
        .s_axilite_WREADY(s_axilite_val_1_WREADY),
        .s_axilite_WSTRB({s_axilite_val_1_WSTRB,s_axilite_val_1_WSTRB,s_axilite_val_1_WSTRB,s_axilite_val_1_WSTRB}),
        .s_axilite_WVALID(s_axilite_val_1_WVALID),
        .s_axis_0_tdata(1'b0),
        .s_axis_0_tvalid(1'b0));
endmodule

module MVAU_hls_1_imp_ZIW0NT
   (ap_clk,
    ap_rst_n,
    in0_V_tdata,
    in0_V_tready,
    in0_V_tvalid,
    out0_V_tdata,
    out0_V_tready,
    out0_V_tvalid,
    s_axilite_mask_araddr,
    s_axilite_mask_arprot,
    s_axilite_mask_arready,
    s_axilite_mask_arvalid,
    s_axilite_mask_awaddr,
    s_axilite_mask_awprot,
    s_axilite_mask_awready,
    s_axilite_mask_awvalid,
    s_axilite_mask_bready,
    s_axilite_mask_bresp,
    s_axilite_mask_bvalid,
    s_axilite_mask_rdata,
    s_axilite_mask_rready,
    s_axilite_mask_rresp,
    s_axilite_mask_rvalid,
    s_axilite_mask_wdata,
    s_axilite_mask_wready,
    s_axilite_mask_wstrb,
    s_axilite_mask_wvalid,
    s_axilite_rowlen_araddr,
    s_axilite_rowlen_arprot,
    s_axilite_rowlen_arready,
    s_axilite_rowlen_arvalid,
    s_axilite_rowlen_awaddr,
    s_axilite_rowlen_awprot,
    s_axilite_rowlen_awready,
    s_axilite_rowlen_awvalid,
    s_axilite_rowlen_bready,
    s_axilite_rowlen_bresp,
    s_axilite_rowlen_bvalid,
    s_axilite_rowlen_rdata,
    s_axilite_rowlen_rready,
    s_axilite_rowlen_rresp,
    s_axilite_rowlen_rvalid,
    s_axilite_rowlen_wdata,
    s_axilite_rowlen_wready,
    s_axilite_rowlen_wstrb,
    s_axilite_rowlen_wvalid,
    s_axilite_sfidx_araddr,
    s_axilite_sfidx_arprot,
    s_axilite_sfidx_arready,
    s_axilite_sfidx_arvalid,
    s_axilite_sfidx_awaddr,
    s_axilite_sfidx_awprot,
    s_axilite_sfidx_awready,
    s_axilite_sfidx_awvalid,
    s_axilite_sfidx_bready,
    s_axilite_sfidx_bresp,
    s_axilite_sfidx_bvalid,
    s_axilite_sfidx_rdata,
    s_axilite_sfidx_rready,
    s_axilite_sfidx_rresp,
    s_axilite_sfidx_rvalid,
    s_axilite_sfidx_wdata,
    s_axilite_sfidx_wready,
    s_axilite_sfidx_wstrb,
    s_axilite_sfidx_wvalid,
    s_axilite_val_araddr,
    s_axilite_val_arprot,
    s_axilite_val_arready,
    s_axilite_val_arvalid,
    s_axilite_val_awaddr,
    s_axilite_val_awprot,
    s_axilite_val_awready,
    s_axilite_val_awvalid,
    s_axilite_val_bready,
    s_axilite_val_bresp,
    s_axilite_val_bvalid,
    s_axilite_val_rdata,
    s_axilite_val_rready,
    s_axilite_val_rresp,
    s_axilite_val_rvalid,
    s_axilite_val_wdata,
    s_axilite_val_wready,
    s_axilite_val_wstrb,
    s_axilite_val_wvalid);
  input ap_clk;
  input ap_rst_n;
  input [7:0]in0_V_tdata;
  output in0_V_tready;
  input in0_V_tvalid;
  output [7:0]out0_V_tdata;
  input out0_V_tready;
  output out0_V_tvalid;
  input s_axilite_mask_araddr;
  input s_axilite_mask_arprot;
  output s_axilite_mask_arready;
  input s_axilite_mask_arvalid;
  input s_axilite_mask_awaddr;
  input s_axilite_mask_awprot;
  output s_axilite_mask_awready;
  input s_axilite_mask_awvalid;
  input s_axilite_mask_bready;
  output s_axilite_mask_bresp;
  output s_axilite_mask_bvalid;
  output s_axilite_mask_rdata;
  input s_axilite_mask_rready;
  output s_axilite_mask_rresp;
  output s_axilite_mask_rvalid;
  input s_axilite_mask_wdata;
  output s_axilite_mask_wready;
  input s_axilite_mask_wstrb;
  input s_axilite_mask_wvalid;
  input s_axilite_rowlen_araddr;
  input s_axilite_rowlen_arprot;
  output s_axilite_rowlen_arready;
  input s_axilite_rowlen_arvalid;
  input s_axilite_rowlen_awaddr;
  input s_axilite_rowlen_awprot;
  output s_axilite_rowlen_awready;
  input s_axilite_rowlen_awvalid;
  input s_axilite_rowlen_bready;
  output s_axilite_rowlen_bresp;
  output s_axilite_rowlen_bvalid;
  output s_axilite_rowlen_rdata;
  input s_axilite_rowlen_rready;
  output s_axilite_rowlen_rresp;
  output s_axilite_rowlen_rvalid;
  input s_axilite_rowlen_wdata;
  output s_axilite_rowlen_wready;
  input s_axilite_rowlen_wstrb;
  input s_axilite_rowlen_wvalid;
  input s_axilite_sfidx_araddr;
  input s_axilite_sfidx_arprot;
  output s_axilite_sfidx_arready;
  input s_axilite_sfidx_arvalid;
  input s_axilite_sfidx_awaddr;
  input s_axilite_sfidx_awprot;
  output s_axilite_sfidx_awready;
  input s_axilite_sfidx_awvalid;
  input s_axilite_sfidx_bready;
  output s_axilite_sfidx_bresp;
  output s_axilite_sfidx_bvalid;
  output s_axilite_sfidx_rdata;
  input s_axilite_sfidx_rready;
  output s_axilite_sfidx_rresp;
  output s_axilite_sfidx_rvalid;
  input s_axilite_sfidx_wdata;
  output s_axilite_sfidx_wready;
  input s_axilite_sfidx_wstrb;
  input s_axilite_sfidx_wvalid;
  input s_axilite_val_araddr;
  input s_axilite_val_arprot;
  output s_axilite_val_arready;
  input s_axilite_val_arvalid;
  input s_axilite_val_awaddr;
  input s_axilite_val_awprot;
  output s_axilite_val_awready;
  input s_axilite_val_awvalid;
  input s_axilite_val_bready;
  output s_axilite_val_bresp;
  output s_axilite_val_bvalid;
  output s_axilite_val_rdata;
  input s_axilite_val_rready;
  output s_axilite_val_rresp;
  output s_axilite_val_rvalid;
  input s_axilite_val_wdata;
  output s_axilite_val_wready;
  input s_axilite_val_wstrb;
  input s_axilite_val_wvalid;

  wire [7:0]MVAU_hls_1_out0_V_TDATA;
  wire MVAU_hls_1_out0_V_TREADY;
  wire MVAU_hls_1_out0_V_TVALID;
  wire [7:0]MVAU_hls_1_wstrm_mask_m_axis_0_TDATA;
  wire MVAU_hls_1_wstrm_mask_m_axis_0_TREADY;
  wire MVAU_hls_1_wstrm_mask_m_axis_0_TVALID;
  wire [15:0]MVAU_hls_1_wstrm_rowlen_m_axis_0_TDATA;
  wire MVAU_hls_1_wstrm_rowlen_m_axis_0_TREADY;
  wire MVAU_hls_1_wstrm_rowlen_m_axis_0_TVALID;
  wire [7:0]MVAU_hls_1_wstrm_sfidx_m_axis_0_TDATA;
  wire MVAU_hls_1_wstrm_sfidx_m_axis_0_TREADY;
  wire MVAU_hls_1_wstrm_sfidx_m_axis_0_TVALID;
  wire [7:0]MVAU_hls_1_wstrm_val_m_axis_0_TDATA;
  wire MVAU_hls_1_wstrm_val_m_axis_0_TREADY;
  wire MVAU_hls_1_wstrm_val_m_axis_0_TVALID;
  wire ap_clk_1;
  wire ap_rst_n_1;
  wire [7:0]in0_V_1_TDATA;
  wire in0_V_1_TREADY;
  wire in0_V_1_TVALID;
  wire s_axilite_mask_1_ARADDR;
  wire s_axilite_mask_1_ARPROT;
  wire s_axilite_mask_1_ARREADY;
  wire s_axilite_mask_1_ARVALID;
  wire s_axilite_mask_1_AWADDR;
  wire s_axilite_mask_1_AWPROT;
  wire s_axilite_mask_1_AWREADY;
  wire s_axilite_mask_1_AWVALID;
  wire s_axilite_mask_1_BREADY;
  wire [1:0]s_axilite_mask_1_BRESP;
  wire s_axilite_mask_1_BVALID;
  wire [31:0]s_axilite_mask_1_RDATA;
  wire s_axilite_mask_1_RREADY;
  wire [1:0]s_axilite_mask_1_RRESP;
  wire s_axilite_mask_1_RVALID;
  wire s_axilite_mask_1_WDATA;
  wire s_axilite_mask_1_WREADY;
  wire s_axilite_mask_1_WSTRB;
  wire s_axilite_mask_1_WVALID;
  wire s_axilite_rowlen_1_ARADDR;
  wire s_axilite_rowlen_1_ARPROT;
  wire s_axilite_rowlen_1_ARREADY;
  wire s_axilite_rowlen_1_ARVALID;
  wire s_axilite_rowlen_1_AWADDR;
  wire s_axilite_rowlen_1_AWPROT;
  wire s_axilite_rowlen_1_AWREADY;
  wire s_axilite_rowlen_1_AWVALID;
  wire s_axilite_rowlen_1_BREADY;
  wire [1:0]s_axilite_rowlen_1_BRESP;
  wire s_axilite_rowlen_1_BVALID;
  wire [31:0]s_axilite_rowlen_1_RDATA;
  wire s_axilite_rowlen_1_RREADY;
  wire [1:0]s_axilite_rowlen_1_RRESP;
  wire s_axilite_rowlen_1_RVALID;
  wire s_axilite_rowlen_1_WDATA;
  wire s_axilite_rowlen_1_WREADY;
  wire s_axilite_rowlen_1_WSTRB;
  wire s_axilite_rowlen_1_WVALID;
  wire s_axilite_sfidx_1_ARADDR;
  wire s_axilite_sfidx_1_ARPROT;
  wire s_axilite_sfidx_1_ARREADY;
  wire s_axilite_sfidx_1_ARVALID;
  wire s_axilite_sfidx_1_AWADDR;
  wire s_axilite_sfidx_1_AWPROT;
  wire s_axilite_sfidx_1_AWREADY;
  wire s_axilite_sfidx_1_AWVALID;
  wire s_axilite_sfidx_1_BREADY;
  wire [1:0]s_axilite_sfidx_1_BRESP;
  wire s_axilite_sfidx_1_BVALID;
  wire [31:0]s_axilite_sfidx_1_RDATA;
  wire s_axilite_sfidx_1_RREADY;
  wire [1:0]s_axilite_sfidx_1_RRESP;
  wire s_axilite_sfidx_1_RVALID;
  wire s_axilite_sfidx_1_WDATA;
  wire s_axilite_sfidx_1_WREADY;
  wire s_axilite_sfidx_1_WSTRB;
  wire s_axilite_sfidx_1_WVALID;
  wire s_axilite_val_1_ARADDR;
  wire s_axilite_val_1_ARPROT;
  wire s_axilite_val_1_ARREADY;
  wire s_axilite_val_1_ARVALID;
  wire s_axilite_val_1_AWADDR;
  wire s_axilite_val_1_AWPROT;
  wire s_axilite_val_1_AWREADY;
  wire s_axilite_val_1_AWVALID;
  wire s_axilite_val_1_BREADY;
  wire [1:0]s_axilite_val_1_BRESP;
  wire s_axilite_val_1_BVALID;
  wire [31:0]s_axilite_val_1_RDATA;
  wire s_axilite_val_1_RREADY;
  wire [1:0]s_axilite_val_1_RRESP;
  wire s_axilite_val_1_RVALID;
  wire s_axilite_val_1_WDATA;
  wire s_axilite_val_1_WREADY;
  wire s_axilite_val_1_WSTRB;
  wire s_axilite_val_1_WVALID;

  assign MVAU_hls_1_out0_V_TREADY = out0_V_tready;
  assign ap_clk_1 = ap_clk;
  assign ap_rst_n_1 = ap_rst_n;
  assign in0_V_1_TDATA = in0_V_tdata[7:0];
  assign in0_V_1_TVALID = in0_V_tvalid;
  assign in0_V_tready = in0_V_1_TREADY;
  assign out0_V_tdata[7:0] = MVAU_hls_1_out0_V_TDATA;
  assign out0_V_tvalid = MVAU_hls_1_out0_V_TVALID;
  assign s_axilite_mask_1_ARADDR = s_axilite_mask_araddr;
  assign s_axilite_mask_1_ARPROT = s_axilite_mask_arprot;
  assign s_axilite_mask_1_ARVALID = s_axilite_mask_arvalid;
  assign s_axilite_mask_1_AWADDR = s_axilite_mask_awaddr;
  assign s_axilite_mask_1_AWPROT = s_axilite_mask_awprot;
  assign s_axilite_mask_1_AWVALID = s_axilite_mask_awvalid;
  assign s_axilite_mask_1_BREADY = s_axilite_mask_bready;
  assign s_axilite_mask_1_RREADY = s_axilite_mask_rready;
  assign s_axilite_mask_1_WDATA = s_axilite_mask_wdata;
  assign s_axilite_mask_1_WSTRB = s_axilite_mask_wstrb;
  assign s_axilite_mask_1_WVALID = s_axilite_mask_wvalid;
  assign s_axilite_mask_arready = s_axilite_mask_1_ARREADY;
  assign s_axilite_mask_awready = s_axilite_mask_1_AWREADY;
  assign s_axilite_mask_bresp = s_axilite_mask_1_BRESP[0];
  assign s_axilite_mask_bvalid = s_axilite_mask_1_BVALID;
  assign s_axilite_mask_rdata = s_axilite_mask_1_RDATA[0];
  assign s_axilite_mask_rresp = s_axilite_mask_1_RRESP[0];
  assign s_axilite_mask_rvalid = s_axilite_mask_1_RVALID;
  assign s_axilite_mask_wready = s_axilite_mask_1_WREADY;
  assign s_axilite_rowlen_1_ARADDR = s_axilite_rowlen_araddr;
  assign s_axilite_rowlen_1_ARPROT = s_axilite_rowlen_arprot;
  assign s_axilite_rowlen_1_ARVALID = s_axilite_rowlen_arvalid;
  assign s_axilite_rowlen_1_AWADDR = s_axilite_rowlen_awaddr;
  assign s_axilite_rowlen_1_AWPROT = s_axilite_rowlen_awprot;
  assign s_axilite_rowlen_1_AWVALID = s_axilite_rowlen_awvalid;
  assign s_axilite_rowlen_1_BREADY = s_axilite_rowlen_bready;
  assign s_axilite_rowlen_1_RREADY = s_axilite_rowlen_rready;
  assign s_axilite_rowlen_1_WDATA = s_axilite_rowlen_wdata;
  assign s_axilite_rowlen_1_WSTRB = s_axilite_rowlen_wstrb;
  assign s_axilite_rowlen_1_WVALID = s_axilite_rowlen_wvalid;
  assign s_axilite_rowlen_arready = s_axilite_rowlen_1_ARREADY;
  assign s_axilite_rowlen_awready = s_axilite_rowlen_1_AWREADY;
  assign s_axilite_rowlen_bresp = s_axilite_rowlen_1_BRESP[0];
  assign s_axilite_rowlen_bvalid = s_axilite_rowlen_1_BVALID;
  assign s_axilite_rowlen_rdata = s_axilite_rowlen_1_RDATA[0];
  assign s_axilite_rowlen_rresp = s_axilite_rowlen_1_RRESP[0];
  assign s_axilite_rowlen_rvalid = s_axilite_rowlen_1_RVALID;
  assign s_axilite_rowlen_wready = s_axilite_rowlen_1_WREADY;
  assign s_axilite_sfidx_1_ARADDR = s_axilite_sfidx_araddr;
  assign s_axilite_sfidx_1_ARPROT = s_axilite_sfidx_arprot;
  assign s_axilite_sfidx_1_ARVALID = s_axilite_sfidx_arvalid;
  assign s_axilite_sfidx_1_AWADDR = s_axilite_sfidx_awaddr;
  assign s_axilite_sfidx_1_AWPROT = s_axilite_sfidx_awprot;
  assign s_axilite_sfidx_1_AWVALID = s_axilite_sfidx_awvalid;
  assign s_axilite_sfidx_1_BREADY = s_axilite_sfidx_bready;
  assign s_axilite_sfidx_1_RREADY = s_axilite_sfidx_rready;
  assign s_axilite_sfidx_1_WDATA = s_axilite_sfidx_wdata;
  assign s_axilite_sfidx_1_WSTRB = s_axilite_sfidx_wstrb;
  assign s_axilite_sfidx_1_WVALID = s_axilite_sfidx_wvalid;
  assign s_axilite_sfidx_arready = s_axilite_sfidx_1_ARREADY;
  assign s_axilite_sfidx_awready = s_axilite_sfidx_1_AWREADY;
  assign s_axilite_sfidx_bresp = s_axilite_sfidx_1_BRESP[0];
  assign s_axilite_sfidx_bvalid = s_axilite_sfidx_1_BVALID;
  assign s_axilite_sfidx_rdata = s_axilite_sfidx_1_RDATA[0];
  assign s_axilite_sfidx_rresp = s_axilite_sfidx_1_RRESP[0];
  assign s_axilite_sfidx_rvalid = s_axilite_sfidx_1_RVALID;
  assign s_axilite_sfidx_wready = s_axilite_sfidx_1_WREADY;
  assign s_axilite_val_1_ARADDR = s_axilite_val_araddr;
  assign s_axilite_val_1_ARPROT = s_axilite_val_arprot;
  assign s_axilite_val_1_ARVALID = s_axilite_val_arvalid;
  assign s_axilite_val_1_AWADDR = s_axilite_val_awaddr;
  assign s_axilite_val_1_AWPROT = s_axilite_val_awprot;
  assign s_axilite_val_1_AWVALID = s_axilite_val_awvalid;
  assign s_axilite_val_1_BREADY = s_axilite_val_bready;
  assign s_axilite_val_1_RREADY = s_axilite_val_rready;
  assign s_axilite_val_1_WDATA = s_axilite_val_wdata;
  assign s_axilite_val_1_WSTRB = s_axilite_val_wstrb;
  assign s_axilite_val_1_WVALID = s_axilite_val_wvalid;
  assign s_axilite_val_arready = s_axilite_val_1_ARREADY;
  assign s_axilite_val_awready = s_axilite_val_1_AWREADY;
  assign s_axilite_val_bresp = s_axilite_val_1_BRESP[0];
  assign s_axilite_val_bvalid = s_axilite_val_1_BVALID;
  assign s_axilite_val_rdata = s_axilite_val_1_RDATA[0];
  assign s_axilite_val_rresp = s_axilite_val_1_RRESP[0];
  assign s_axilite_val_rvalid = s_axilite_val_1_RVALID;
  assign s_axilite_val_wready = s_axilite_val_1_WREADY;
  finn_design_MVAU_hls_1_0 MVAU_hls_1
       (.ap_clk(ap_clk_1),
        .ap_rst_n(ap_rst_n_1),
        .in0_V_TDATA(in0_V_1_TDATA),
        .in0_V_TREADY(in0_V_1_TREADY),
        .in0_V_TVALID(in0_V_1_TVALID),
        .mask_V_TDATA(MVAU_hls_1_wstrm_mask_m_axis_0_TDATA),
        .mask_V_TREADY(MVAU_hls_1_wstrm_mask_m_axis_0_TREADY),
        .mask_V_TVALID(MVAU_hls_1_wstrm_mask_m_axis_0_TVALID),
        .out0_V_TDATA(MVAU_hls_1_out0_V_TDATA),
        .out0_V_TREADY(MVAU_hls_1_out0_V_TREADY),
        .out0_V_TVALID(MVAU_hls_1_out0_V_TVALID),
        .rowlen_V_TDATA(MVAU_hls_1_wstrm_rowlen_m_axis_0_TDATA),
        .rowlen_V_TREADY(MVAU_hls_1_wstrm_rowlen_m_axis_0_TREADY),
        .rowlen_V_TVALID(MVAU_hls_1_wstrm_rowlen_m_axis_0_TVALID),
        .sfidx_V_TDATA(MVAU_hls_1_wstrm_sfidx_m_axis_0_TDATA),
        .sfidx_V_TREADY(MVAU_hls_1_wstrm_sfidx_m_axis_0_TREADY),
        .sfidx_V_TVALID(MVAU_hls_1_wstrm_sfidx_m_axis_0_TVALID),
        .val_V_TDATA(MVAU_hls_1_wstrm_val_m_axis_0_TDATA),
        .val_V_TREADY(MVAU_hls_1_wstrm_val_m_axis_0_TREADY),
        .val_V_TVALID(MVAU_hls_1_wstrm_val_m_axis_0_TVALID));
  finn_design_MVAU_hls_1_wstrm_mask_0 MVAU_hls_1_wstrm_mask
       (.ap_clk(ap_clk_1),
        .ap_clk2x(ap_clk_1),
        .ap_rst_n(ap_rst_n_1),
        .m_axis_0_tdata(MVAU_hls_1_wstrm_mask_m_axis_0_TDATA),
        .m_axis_0_tready(MVAU_hls_1_wstrm_mask_m_axis_0_TREADY),
        .m_axis_0_tvalid(MVAU_hls_1_wstrm_mask_m_axis_0_TVALID),
        .s_axilite_ARADDR({s_axilite_mask_1_ARADDR,s_axilite_mask_1_ARADDR,s_axilite_mask_1_ARADDR,s_axilite_mask_1_ARADDR,s_axilite_mask_1_ARADDR,s_axilite_mask_1_ARADDR,s_axilite_mask_1_ARADDR,s_axilite_mask_1_ARADDR}),
        .s_axilite_ARPROT({s_axilite_mask_1_ARPROT,s_axilite_mask_1_ARPROT,s_axilite_mask_1_ARPROT}),
        .s_axilite_ARREADY(s_axilite_mask_1_ARREADY),
        .s_axilite_ARVALID(s_axilite_mask_1_ARVALID),
        .s_axilite_AWADDR({s_axilite_mask_1_AWADDR,s_axilite_mask_1_AWADDR,s_axilite_mask_1_AWADDR,s_axilite_mask_1_AWADDR,s_axilite_mask_1_AWADDR,s_axilite_mask_1_AWADDR,s_axilite_mask_1_AWADDR,s_axilite_mask_1_AWADDR}),
        .s_axilite_AWPROT({s_axilite_mask_1_AWPROT,s_axilite_mask_1_AWPROT,s_axilite_mask_1_AWPROT}),
        .s_axilite_AWREADY(s_axilite_mask_1_AWREADY),
        .s_axilite_AWVALID(s_axilite_mask_1_AWVALID),
        .s_axilite_BREADY(s_axilite_mask_1_BREADY),
        .s_axilite_BRESP(s_axilite_mask_1_BRESP),
        .s_axilite_BVALID(s_axilite_mask_1_BVALID),
        .s_axilite_RDATA(s_axilite_mask_1_RDATA),
        .s_axilite_RREADY(s_axilite_mask_1_RREADY),
        .s_axilite_RRESP(s_axilite_mask_1_RRESP),
        .s_axilite_RVALID(s_axilite_mask_1_RVALID),
        .s_axilite_WDATA({s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA}),
        .s_axilite_WREADY(s_axilite_mask_1_WREADY),
        .s_axilite_WSTRB({s_axilite_mask_1_WSTRB,s_axilite_mask_1_WSTRB,s_axilite_mask_1_WSTRB,s_axilite_mask_1_WSTRB}),
        .s_axilite_WVALID(s_axilite_mask_1_WVALID),
        .s_axis_0_tdata(1'b0),
        .s_axis_0_tvalid(1'b0));
  finn_design_MVAU_hls_1_wstrm_rowlen_0 MVAU_hls_1_wstrm_rowlen
       (.ap_clk(ap_clk_1),
        .ap_clk2x(ap_clk_1),
        .ap_rst_n(ap_rst_n_1),
        .m_axis_0_tdata(MVAU_hls_1_wstrm_rowlen_m_axis_0_TDATA),
        .m_axis_0_tready(MVAU_hls_1_wstrm_rowlen_m_axis_0_TREADY),
        .m_axis_0_tvalid(MVAU_hls_1_wstrm_rowlen_m_axis_0_TVALID),
        .s_axilite_ARADDR({s_axilite_rowlen_1_ARADDR,s_axilite_rowlen_1_ARADDR,s_axilite_rowlen_1_ARADDR,s_axilite_rowlen_1_ARADDR,s_axilite_rowlen_1_ARADDR,s_axilite_rowlen_1_ARADDR,s_axilite_rowlen_1_ARADDR,s_axilite_rowlen_1_ARADDR}),
        .s_axilite_ARPROT({s_axilite_rowlen_1_ARPROT,s_axilite_rowlen_1_ARPROT,s_axilite_rowlen_1_ARPROT}),
        .s_axilite_ARREADY(s_axilite_rowlen_1_ARREADY),
        .s_axilite_ARVALID(s_axilite_rowlen_1_ARVALID),
        .s_axilite_AWADDR({s_axilite_rowlen_1_AWADDR,s_axilite_rowlen_1_AWADDR,s_axilite_rowlen_1_AWADDR,s_axilite_rowlen_1_AWADDR,s_axilite_rowlen_1_AWADDR,s_axilite_rowlen_1_AWADDR,s_axilite_rowlen_1_AWADDR,s_axilite_rowlen_1_AWADDR}),
        .s_axilite_AWPROT({s_axilite_rowlen_1_AWPROT,s_axilite_rowlen_1_AWPROT,s_axilite_rowlen_1_AWPROT}),
        .s_axilite_AWREADY(s_axilite_rowlen_1_AWREADY),
        .s_axilite_AWVALID(s_axilite_rowlen_1_AWVALID),
        .s_axilite_BREADY(s_axilite_rowlen_1_BREADY),
        .s_axilite_BRESP(s_axilite_rowlen_1_BRESP),
        .s_axilite_BVALID(s_axilite_rowlen_1_BVALID),
        .s_axilite_RDATA(s_axilite_rowlen_1_RDATA),
        .s_axilite_RREADY(s_axilite_rowlen_1_RREADY),
        .s_axilite_RRESP(s_axilite_rowlen_1_RRESP),
        .s_axilite_RVALID(s_axilite_rowlen_1_RVALID),
        .s_axilite_WDATA({s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA}),
        .s_axilite_WREADY(s_axilite_rowlen_1_WREADY),
        .s_axilite_WSTRB({s_axilite_rowlen_1_WSTRB,s_axilite_rowlen_1_WSTRB,s_axilite_rowlen_1_WSTRB,s_axilite_rowlen_1_WSTRB}),
        .s_axilite_WVALID(s_axilite_rowlen_1_WVALID),
        .s_axis_0_tdata(1'b0),
        .s_axis_0_tvalid(1'b0));
  finn_design_MVAU_hls_1_wstrm_sfidx_0 MVAU_hls_1_wstrm_sfidx
       (.ap_clk(ap_clk_1),
        .ap_clk2x(ap_clk_1),
        .ap_rst_n(ap_rst_n_1),
        .m_axis_0_tdata(MVAU_hls_1_wstrm_sfidx_m_axis_0_TDATA),
        .m_axis_0_tready(MVAU_hls_1_wstrm_sfidx_m_axis_0_TREADY),
        .m_axis_0_tvalid(MVAU_hls_1_wstrm_sfidx_m_axis_0_TVALID),
        .s_axilite_ARADDR({s_axilite_sfidx_1_ARADDR,s_axilite_sfidx_1_ARADDR,s_axilite_sfidx_1_ARADDR,s_axilite_sfidx_1_ARADDR,s_axilite_sfidx_1_ARADDR,s_axilite_sfidx_1_ARADDR,s_axilite_sfidx_1_ARADDR,s_axilite_sfidx_1_ARADDR}),
        .s_axilite_ARPROT({s_axilite_sfidx_1_ARPROT,s_axilite_sfidx_1_ARPROT,s_axilite_sfidx_1_ARPROT}),
        .s_axilite_ARREADY(s_axilite_sfidx_1_ARREADY),
        .s_axilite_ARVALID(s_axilite_sfidx_1_ARVALID),
        .s_axilite_AWADDR({s_axilite_sfidx_1_AWADDR,s_axilite_sfidx_1_AWADDR,s_axilite_sfidx_1_AWADDR,s_axilite_sfidx_1_AWADDR,s_axilite_sfidx_1_AWADDR,s_axilite_sfidx_1_AWADDR,s_axilite_sfidx_1_AWADDR,s_axilite_sfidx_1_AWADDR}),
        .s_axilite_AWPROT({s_axilite_sfidx_1_AWPROT,s_axilite_sfidx_1_AWPROT,s_axilite_sfidx_1_AWPROT}),
        .s_axilite_AWREADY(s_axilite_sfidx_1_AWREADY),
        .s_axilite_AWVALID(s_axilite_sfidx_1_AWVALID),
        .s_axilite_BREADY(s_axilite_sfidx_1_BREADY),
        .s_axilite_BRESP(s_axilite_sfidx_1_BRESP),
        .s_axilite_BVALID(s_axilite_sfidx_1_BVALID),
        .s_axilite_RDATA(s_axilite_sfidx_1_RDATA),
        .s_axilite_RREADY(s_axilite_sfidx_1_RREADY),
        .s_axilite_RRESP(s_axilite_sfidx_1_RRESP),
        .s_axilite_RVALID(s_axilite_sfidx_1_RVALID),
        .s_axilite_WDATA({s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA}),
        .s_axilite_WREADY(s_axilite_sfidx_1_WREADY),
        .s_axilite_WSTRB({s_axilite_sfidx_1_WSTRB,s_axilite_sfidx_1_WSTRB,s_axilite_sfidx_1_WSTRB,s_axilite_sfidx_1_WSTRB}),
        .s_axilite_WVALID(s_axilite_sfidx_1_WVALID),
        .s_axis_0_tdata(1'b0),
        .s_axis_0_tvalid(1'b0));
  finn_design_MVAU_hls_1_wstrm_val_0 MVAU_hls_1_wstrm_val
       (.ap_clk(ap_clk_1),
        .ap_clk2x(ap_clk_1),
        .ap_rst_n(ap_rst_n_1),
        .m_axis_0_tdata(MVAU_hls_1_wstrm_val_m_axis_0_TDATA),
        .m_axis_0_tready(MVAU_hls_1_wstrm_val_m_axis_0_TREADY),
        .m_axis_0_tvalid(MVAU_hls_1_wstrm_val_m_axis_0_TVALID),
        .s_axilite_ARADDR({s_axilite_val_1_ARADDR,s_axilite_val_1_ARADDR,s_axilite_val_1_ARADDR,s_axilite_val_1_ARADDR,s_axilite_val_1_ARADDR,s_axilite_val_1_ARADDR,s_axilite_val_1_ARADDR,s_axilite_val_1_ARADDR}),
        .s_axilite_ARPROT({s_axilite_val_1_ARPROT,s_axilite_val_1_ARPROT,s_axilite_val_1_ARPROT}),
        .s_axilite_ARREADY(s_axilite_val_1_ARREADY),
        .s_axilite_ARVALID(s_axilite_val_1_ARVALID),
        .s_axilite_AWADDR({s_axilite_val_1_AWADDR,s_axilite_val_1_AWADDR,s_axilite_val_1_AWADDR,s_axilite_val_1_AWADDR,s_axilite_val_1_AWADDR,s_axilite_val_1_AWADDR,s_axilite_val_1_AWADDR,s_axilite_val_1_AWADDR}),
        .s_axilite_AWPROT({s_axilite_val_1_AWPROT,s_axilite_val_1_AWPROT,s_axilite_val_1_AWPROT}),
        .s_axilite_AWREADY(s_axilite_val_1_AWREADY),
        .s_axilite_AWVALID(s_axilite_val_1_AWVALID),
        .s_axilite_BREADY(s_axilite_val_1_BREADY),
        .s_axilite_BRESP(s_axilite_val_1_BRESP),
        .s_axilite_BVALID(s_axilite_val_1_BVALID),
        .s_axilite_RDATA(s_axilite_val_1_RDATA),
        .s_axilite_RREADY(s_axilite_val_1_RREADY),
        .s_axilite_RRESP(s_axilite_val_1_RRESP),
        .s_axilite_RVALID(s_axilite_val_1_RVALID),
        .s_axilite_WDATA({s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA}),
        .s_axilite_WREADY(s_axilite_val_1_WREADY),
        .s_axilite_WSTRB({s_axilite_val_1_WSTRB,s_axilite_val_1_WSTRB,s_axilite_val_1_WSTRB,s_axilite_val_1_WSTRB}),
        .s_axilite_WVALID(s_axilite_val_1_WVALID),
        .s_axis_0_tdata(1'b0),
        .s_axis_0_tvalid(1'b0));
endmodule

module MVAU_hls_2_imp_1WP2WTL
   (ap_clk,
    ap_rst_n,
    in0_V_tdata,
    in0_V_tready,
    in0_V_tvalid,
    out0_V_tdata,
    out0_V_tready,
    out0_V_tvalid,
    s_axilite_mask_araddr,
    s_axilite_mask_arprot,
    s_axilite_mask_arready,
    s_axilite_mask_arvalid,
    s_axilite_mask_awaddr,
    s_axilite_mask_awprot,
    s_axilite_mask_awready,
    s_axilite_mask_awvalid,
    s_axilite_mask_bready,
    s_axilite_mask_bresp,
    s_axilite_mask_bvalid,
    s_axilite_mask_rdata,
    s_axilite_mask_rready,
    s_axilite_mask_rresp,
    s_axilite_mask_rvalid,
    s_axilite_mask_wdata,
    s_axilite_mask_wready,
    s_axilite_mask_wstrb,
    s_axilite_mask_wvalid,
    s_axilite_rowlen_araddr,
    s_axilite_rowlen_arprot,
    s_axilite_rowlen_arready,
    s_axilite_rowlen_arvalid,
    s_axilite_rowlen_awaddr,
    s_axilite_rowlen_awprot,
    s_axilite_rowlen_awready,
    s_axilite_rowlen_awvalid,
    s_axilite_rowlen_bready,
    s_axilite_rowlen_bresp,
    s_axilite_rowlen_bvalid,
    s_axilite_rowlen_rdata,
    s_axilite_rowlen_rready,
    s_axilite_rowlen_rresp,
    s_axilite_rowlen_rvalid,
    s_axilite_rowlen_wdata,
    s_axilite_rowlen_wready,
    s_axilite_rowlen_wstrb,
    s_axilite_rowlen_wvalid,
    s_axilite_sfidx_araddr,
    s_axilite_sfidx_arprot,
    s_axilite_sfidx_arready,
    s_axilite_sfidx_arvalid,
    s_axilite_sfidx_awaddr,
    s_axilite_sfidx_awprot,
    s_axilite_sfidx_awready,
    s_axilite_sfidx_awvalid,
    s_axilite_sfidx_bready,
    s_axilite_sfidx_bresp,
    s_axilite_sfidx_bvalid,
    s_axilite_sfidx_rdata,
    s_axilite_sfidx_rready,
    s_axilite_sfidx_rresp,
    s_axilite_sfidx_rvalid,
    s_axilite_sfidx_wdata,
    s_axilite_sfidx_wready,
    s_axilite_sfidx_wstrb,
    s_axilite_sfidx_wvalid,
    s_axilite_val_araddr,
    s_axilite_val_arprot,
    s_axilite_val_arready,
    s_axilite_val_arvalid,
    s_axilite_val_awaddr,
    s_axilite_val_awprot,
    s_axilite_val_awready,
    s_axilite_val_awvalid,
    s_axilite_val_bready,
    s_axilite_val_bresp,
    s_axilite_val_bvalid,
    s_axilite_val_rdata,
    s_axilite_val_rready,
    s_axilite_val_rresp,
    s_axilite_val_rvalid,
    s_axilite_val_wdata,
    s_axilite_val_wready,
    s_axilite_val_wstrb,
    s_axilite_val_wvalid);
  input ap_clk;
  input ap_rst_n;
  input [7:0]in0_V_tdata;
  output in0_V_tready;
  input in0_V_tvalid;
  output [7:0]out0_V_tdata;
  input out0_V_tready;
  output out0_V_tvalid;
  input s_axilite_mask_araddr;
  input s_axilite_mask_arprot;
  output s_axilite_mask_arready;
  input s_axilite_mask_arvalid;
  input s_axilite_mask_awaddr;
  input s_axilite_mask_awprot;
  output s_axilite_mask_awready;
  input s_axilite_mask_awvalid;
  input s_axilite_mask_bready;
  output s_axilite_mask_bresp;
  output s_axilite_mask_bvalid;
  output s_axilite_mask_rdata;
  input s_axilite_mask_rready;
  output s_axilite_mask_rresp;
  output s_axilite_mask_rvalid;
  input s_axilite_mask_wdata;
  output s_axilite_mask_wready;
  input s_axilite_mask_wstrb;
  input s_axilite_mask_wvalid;
  input s_axilite_rowlen_araddr;
  input s_axilite_rowlen_arprot;
  output s_axilite_rowlen_arready;
  input s_axilite_rowlen_arvalid;
  input s_axilite_rowlen_awaddr;
  input s_axilite_rowlen_awprot;
  output s_axilite_rowlen_awready;
  input s_axilite_rowlen_awvalid;
  input s_axilite_rowlen_bready;
  output s_axilite_rowlen_bresp;
  output s_axilite_rowlen_bvalid;
  output s_axilite_rowlen_rdata;
  input s_axilite_rowlen_rready;
  output s_axilite_rowlen_rresp;
  output s_axilite_rowlen_rvalid;
  input s_axilite_rowlen_wdata;
  output s_axilite_rowlen_wready;
  input s_axilite_rowlen_wstrb;
  input s_axilite_rowlen_wvalid;
  input s_axilite_sfidx_araddr;
  input s_axilite_sfidx_arprot;
  output s_axilite_sfidx_arready;
  input s_axilite_sfidx_arvalid;
  input s_axilite_sfidx_awaddr;
  input s_axilite_sfidx_awprot;
  output s_axilite_sfidx_awready;
  input s_axilite_sfidx_awvalid;
  input s_axilite_sfidx_bready;
  output s_axilite_sfidx_bresp;
  output s_axilite_sfidx_bvalid;
  output s_axilite_sfidx_rdata;
  input s_axilite_sfidx_rready;
  output s_axilite_sfidx_rresp;
  output s_axilite_sfidx_rvalid;
  input s_axilite_sfidx_wdata;
  output s_axilite_sfidx_wready;
  input s_axilite_sfidx_wstrb;
  input s_axilite_sfidx_wvalid;
  input s_axilite_val_araddr;
  input s_axilite_val_arprot;
  output s_axilite_val_arready;
  input s_axilite_val_arvalid;
  input s_axilite_val_awaddr;
  input s_axilite_val_awprot;
  output s_axilite_val_awready;
  input s_axilite_val_awvalid;
  input s_axilite_val_bready;
  output s_axilite_val_bresp;
  output s_axilite_val_bvalid;
  output s_axilite_val_rdata;
  input s_axilite_val_rready;
  output s_axilite_val_rresp;
  output s_axilite_val_rvalid;
  input s_axilite_val_wdata;
  output s_axilite_val_wready;
  input s_axilite_val_wstrb;
  input s_axilite_val_wvalid;

  wire [7:0]MVAU_hls_2_out0_V_TDATA;
  wire MVAU_hls_2_out0_V_TREADY;
  wire MVAU_hls_2_out0_V_TVALID;
  wire [7:0]MVAU_hls_2_wstrm_mask_m_axis_0_TDATA;
  wire MVAU_hls_2_wstrm_mask_m_axis_0_TREADY;
  wire MVAU_hls_2_wstrm_mask_m_axis_0_TVALID;
  wire [15:0]MVAU_hls_2_wstrm_rowlen_m_axis_0_TDATA;
  wire MVAU_hls_2_wstrm_rowlen_m_axis_0_TREADY;
  wire MVAU_hls_2_wstrm_rowlen_m_axis_0_TVALID;
  wire [7:0]MVAU_hls_2_wstrm_sfidx_m_axis_0_TDATA;
  wire MVAU_hls_2_wstrm_sfidx_m_axis_0_TREADY;
  wire MVAU_hls_2_wstrm_sfidx_m_axis_0_TVALID;
  wire [7:0]MVAU_hls_2_wstrm_val_m_axis_0_TDATA;
  wire MVAU_hls_2_wstrm_val_m_axis_0_TREADY;
  wire MVAU_hls_2_wstrm_val_m_axis_0_TVALID;
  wire ap_clk_1;
  wire ap_rst_n_1;
  wire [7:0]in0_V_1_TDATA;
  wire in0_V_1_TREADY;
  wire in0_V_1_TVALID;
  wire s_axilite_mask_1_ARADDR;
  wire s_axilite_mask_1_ARPROT;
  wire s_axilite_mask_1_ARREADY;
  wire s_axilite_mask_1_ARVALID;
  wire s_axilite_mask_1_AWADDR;
  wire s_axilite_mask_1_AWPROT;
  wire s_axilite_mask_1_AWREADY;
  wire s_axilite_mask_1_AWVALID;
  wire s_axilite_mask_1_BREADY;
  wire [1:0]s_axilite_mask_1_BRESP;
  wire s_axilite_mask_1_BVALID;
  wire [31:0]s_axilite_mask_1_RDATA;
  wire s_axilite_mask_1_RREADY;
  wire [1:0]s_axilite_mask_1_RRESP;
  wire s_axilite_mask_1_RVALID;
  wire s_axilite_mask_1_WDATA;
  wire s_axilite_mask_1_WREADY;
  wire s_axilite_mask_1_WSTRB;
  wire s_axilite_mask_1_WVALID;
  wire s_axilite_rowlen_1_ARADDR;
  wire s_axilite_rowlen_1_ARPROT;
  wire s_axilite_rowlen_1_ARREADY;
  wire s_axilite_rowlen_1_ARVALID;
  wire s_axilite_rowlen_1_AWADDR;
  wire s_axilite_rowlen_1_AWPROT;
  wire s_axilite_rowlen_1_AWREADY;
  wire s_axilite_rowlen_1_AWVALID;
  wire s_axilite_rowlen_1_BREADY;
  wire [1:0]s_axilite_rowlen_1_BRESP;
  wire s_axilite_rowlen_1_BVALID;
  wire [31:0]s_axilite_rowlen_1_RDATA;
  wire s_axilite_rowlen_1_RREADY;
  wire [1:0]s_axilite_rowlen_1_RRESP;
  wire s_axilite_rowlen_1_RVALID;
  wire s_axilite_rowlen_1_WDATA;
  wire s_axilite_rowlen_1_WREADY;
  wire s_axilite_rowlen_1_WSTRB;
  wire s_axilite_rowlen_1_WVALID;
  wire s_axilite_sfidx_1_ARADDR;
  wire s_axilite_sfidx_1_ARPROT;
  wire s_axilite_sfidx_1_ARREADY;
  wire s_axilite_sfidx_1_ARVALID;
  wire s_axilite_sfidx_1_AWADDR;
  wire s_axilite_sfidx_1_AWPROT;
  wire s_axilite_sfidx_1_AWREADY;
  wire s_axilite_sfidx_1_AWVALID;
  wire s_axilite_sfidx_1_BREADY;
  wire [1:0]s_axilite_sfidx_1_BRESP;
  wire s_axilite_sfidx_1_BVALID;
  wire [31:0]s_axilite_sfidx_1_RDATA;
  wire s_axilite_sfidx_1_RREADY;
  wire [1:0]s_axilite_sfidx_1_RRESP;
  wire s_axilite_sfidx_1_RVALID;
  wire s_axilite_sfidx_1_WDATA;
  wire s_axilite_sfidx_1_WREADY;
  wire s_axilite_sfidx_1_WSTRB;
  wire s_axilite_sfidx_1_WVALID;
  wire s_axilite_val_1_ARADDR;
  wire s_axilite_val_1_ARPROT;
  wire s_axilite_val_1_ARREADY;
  wire s_axilite_val_1_ARVALID;
  wire s_axilite_val_1_AWADDR;
  wire s_axilite_val_1_AWPROT;
  wire s_axilite_val_1_AWREADY;
  wire s_axilite_val_1_AWVALID;
  wire s_axilite_val_1_BREADY;
  wire [1:0]s_axilite_val_1_BRESP;
  wire s_axilite_val_1_BVALID;
  wire [31:0]s_axilite_val_1_RDATA;
  wire s_axilite_val_1_RREADY;
  wire [1:0]s_axilite_val_1_RRESP;
  wire s_axilite_val_1_RVALID;
  wire s_axilite_val_1_WDATA;
  wire s_axilite_val_1_WREADY;
  wire s_axilite_val_1_WSTRB;
  wire s_axilite_val_1_WVALID;

  assign MVAU_hls_2_out0_V_TREADY = out0_V_tready;
  assign ap_clk_1 = ap_clk;
  assign ap_rst_n_1 = ap_rst_n;
  assign in0_V_1_TDATA = in0_V_tdata[7:0];
  assign in0_V_1_TVALID = in0_V_tvalid;
  assign in0_V_tready = in0_V_1_TREADY;
  assign out0_V_tdata[7:0] = MVAU_hls_2_out0_V_TDATA;
  assign out0_V_tvalid = MVAU_hls_2_out0_V_TVALID;
  assign s_axilite_mask_1_ARADDR = s_axilite_mask_araddr;
  assign s_axilite_mask_1_ARPROT = s_axilite_mask_arprot;
  assign s_axilite_mask_1_ARVALID = s_axilite_mask_arvalid;
  assign s_axilite_mask_1_AWADDR = s_axilite_mask_awaddr;
  assign s_axilite_mask_1_AWPROT = s_axilite_mask_awprot;
  assign s_axilite_mask_1_AWVALID = s_axilite_mask_awvalid;
  assign s_axilite_mask_1_BREADY = s_axilite_mask_bready;
  assign s_axilite_mask_1_RREADY = s_axilite_mask_rready;
  assign s_axilite_mask_1_WDATA = s_axilite_mask_wdata;
  assign s_axilite_mask_1_WSTRB = s_axilite_mask_wstrb;
  assign s_axilite_mask_1_WVALID = s_axilite_mask_wvalid;
  assign s_axilite_mask_arready = s_axilite_mask_1_ARREADY;
  assign s_axilite_mask_awready = s_axilite_mask_1_AWREADY;
  assign s_axilite_mask_bresp = s_axilite_mask_1_BRESP[0];
  assign s_axilite_mask_bvalid = s_axilite_mask_1_BVALID;
  assign s_axilite_mask_rdata = s_axilite_mask_1_RDATA[0];
  assign s_axilite_mask_rresp = s_axilite_mask_1_RRESP[0];
  assign s_axilite_mask_rvalid = s_axilite_mask_1_RVALID;
  assign s_axilite_mask_wready = s_axilite_mask_1_WREADY;
  assign s_axilite_rowlen_1_ARADDR = s_axilite_rowlen_araddr;
  assign s_axilite_rowlen_1_ARPROT = s_axilite_rowlen_arprot;
  assign s_axilite_rowlen_1_ARVALID = s_axilite_rowlen_arvalid;
  assign s_axilite_rowlen_1_AWADDR = s_axilite_rowlen_awaddr;
  assign s_axilite_rowlen_1_AWPROT = s_axilite_rowlen_awprot;
  assign s_axilite_rowlen_1_AWVALID = s_axilite_rowlen_awvalid;
  assign s_axilite_rowlen_1_BREADY = s_axilite_rowlen_bready;
  assign s_axilite_rowlen_1_RREADY = s_axilite_rowlen_rready;
  assign s_axilite_rowlen_1_WDATA = s_axilite_rowlen_wdata;
  assign s_axilite_rowlen_1_WSTRB = s_axilite_rowlen_wstrb;
  assign s_axilite_rowlen_1_WVALID = s_axilite_rowlen_wvalid;
  assign s_axilite_rowlen_arready = s_axilite_rowlen_1_ARREADY;
  assign s_axilite_rowlen_awready = s_axilite_rowlen_1_AWREADY;
  assign s_axilite_rowlen_bresp = s_axilite_rowlen_1_BRESP[0];
  assign s_axilite_rowlen_bvalid = s_axilite_rowlen_1_BVALID;
  assign s_axilite_rowlen_rdata = s_axilite_rowlen_1_RDATA[0];
  assign s_axilite_rowlen_rresp = s_axilite_rowlen_1_RRESP[0];
  assign s_axilite_rowlen_rvalid = s_axilite_rowlen_1_RVALID;
  assign s_axilite_rowlen_wready = s_axilite_rowlen_1_WREADY;
  assign s_axilite_sfidx_1_ARADDR = s_axilite_sfidx_araddr;
  assign s_axilite_sfidx_1_ARPROT = s_axilite_sfidx_arprot;
  assign s_axilite_sfidx_1_ARVALID = s_axilite_sfidx_arvalid;
  assign s_axilite_sfidx_1_AWADDR = s_axilite_sfidx_awaddr;
  assign s_axilite_sfidx_1_AWPROT = s_axilite_sfidx_awprot;
  assign s_axilite_sfidx_1_AWVALID = s_axilite_sfidx_awvalid;
  assign s_axilite_sfidx_1_BREADY = s_axilite_sfidx_bready;
  assign s_axilite_sfidx_1_RREADY = s_axilite_sfidx_rready;
  assign s_axilite_sfidx_1_WDATA = s_axilite_sfidx_wdata;
  assign s_axilite_sfidx_1_WSTRB = s_axilite_sfidx_wstrb;
  assign s_axilite_sfidx_1_WVALID = s_axilite_sfidx_wvalid;
  assign s_axilite_sfidx_arready = s_axilite_sfidx_1_ARREADY;
  assign s_axilite_sfidx_awready = s_axilite_sfidx_1_AWREADY;
  assign s_axilite_sfidx_bresp = s_axilite_sfidx_1_BRESP[0];
  assign s_axilite_sfidx_bvalid = s_axilite_sfidx_1_BVALID;
  assign s_axilite_sfidx_rdata = s_axilite_sfidx_1_RDATA[0];
  assign s_axilite_sfidx_rresp = s_axilite_sfidx_1_RRESP[0];
  assign s_axilite_sfidx_rvalid = s_axilite_sfidx_1_RVALID;
  assign s_axilite_sfidx_wready = s_axilite_sfidx_1_WREADY;
  assign s_axilite_val_1_ARADDR = s_axilite_val_araddr;
  assign s_axilite_val_1_ARPROT = s_axilite_val_arprot;
  assign s_axilite_val_1_ARVALID = s_axilite_val_arvalid;
  assign s_axilite_val_1_AWADDR = s_axilite_val_awaddr;
  assign s_axilite_val_1_AWPROT = s_axilite_val_awprot;
  assign s_axilite_val_1_AWVALID = s_axilite_val_awvalid;
  assign s_axilite_val_1_BREADY = s_axilite_val_bready;
  assign s_axilite_val_1_RREADY = s_axilite_val_rready;
  assign s_axilite_val_1_WDATA = s_axilite_val_wdata;
  assign s_axilite_val_1_WSTRB = s_axilite_val_wstrb;
  assign s_axilite_val_1_WVALID = s_axilite_val_wvalid;
  assign s_axilite_val_arready = s_axilite_val_1_ARREADY;
  assign s_axilite_val_awready = s_axilite_val_1_AWREADY;
  assign s_axilite_val_bresp = s_axilite_val_1_BRESP[0];
  assign s_axilite_val_bvalid = s_axilite_val_1_BVALID;
  assign s_axilite_val_rdata = s_axilite_val_1_RDATA[0];
  assign s_axilite_val_rresp = s_axilite_val_1_RRESP[0];
  assign s_axilite_val_rvalid = s_axilite_val_1_RVALID;
  assign s_axilite_val_wready = s_axilite_val_1_WREADY;
  finn_design_MVAU_hls_2_0 MVAU_hls_2
       (.ap_clk(ap_clk_1),
        .ap_rst_n(ap_rst_n_1),
        .in0_V_TDATA(in0_V_1_TDATA),
        .in0_V_TREADY(in0_V_1_TREADY),
        .in0_V_TVALID(in0_V_1_TVALID),
        .mask_V_TDATA(MVAU_hls_2_wstrm_mask_m_axis_0_TDATA),
        .mask_V_TREADY(MVAU_hls_2_wstrm_mask_m_axis_0_TREADY),
        .mask_V_TVALID(MVAU_hls_2_wstrm_mask_m_axis_0_TVALID),
        .out0_V_TDATA(MVAU_hls_2_out0_V_TDATA),
        .out0_V_TREADY(MVAU_hls_2_out0_V_TREADY),
        .out0_V_TVALID(MVAU_hls_2_out0_V_TVALID),
        .rowlen_V_TDATA(MVAU_hls_2_wstrm_rowlen_m_axis_0_TDATA),
        .rowlen_V_TREADY(MVAU_hls_2_wstrm_rowlen_m_axis_0_TREADY),
        .rowlen_V_TVALID(MVAU_hls_2_wstrm_rowlen_m_axis_0_TVALID),
        .sfidx_V_TDATA(MVAU_hls_2_wstrm_sfidx_m_axis_0_TDATA),
        .sfidx_V_TREADY(MVAU_hls_2_wstrm_sfidx_m_axis_0_TREADY),
        .sfidx_V_TVALID(MVAU_hls_2_wstrm_sfidx_m_axis_0_TVALID),
        .val_V_TDATA(MVAU_hls_2_wstrm_val_m_axis_0_TDATA),
        .val_V_TREADY(MVAU_hls_2_wstrm_val_m_axis_0_TREADY),
        .val_V_TVALID(MVAU_hls_2_wstrm_val_m_axis_0_TVALID));
  finn_design_MVAU_hls_2_wstrm_mask_0 MVAU_hls_2_wstrm_mask
       (.ap_clk(ap_clk_1),
        .ap_clk2x(ap_clk_1),
        .ap_rst_n(ap_rst_n_1),
        .m_axis_0_tdata(MVAU_hls_2_wstrm_mask_m_axis_0_TDATA),
        .m_axis_0_tready(MVAU_hls_2_wstrm_mask_m_axis_0_TREADY),
        .m_axis_0_tvalid(MVAU_hls_2_wstrm_mask_m_axis_0_TVALID),
        .s_axilite_ARADDR({s_axilite_mask_1_ARADDR,s_axilite_mask_1_ARADDR,s_axilite_mask_1_ARADDR,s_axilite_mask_1_ARADDR,s_axilite_mask_1_ARADDR,s_axilite_mask_1_ARADDR,s_axilite_mask_1_ARADDR,s_axilite_mask_1_ARADDR}),
        .s_axilite_ARPROT({s_axilite_mask_1_ARPROT,s_axilite_mask_1_ARPROT,s_axilite_mask_1_ARPROT}),
        .s_axilite_ARREADY(s_axilite_mask_1_ARREADY),
        .s_axilite_ARVALID(s_axilite_mask_1_ARVALID),
        .s_axilite_AWADDR({s_axilite_mask_1_AWADDR,s_axilite_mask_1_AWADDR,s_axilite_mask_1_AWADDR,s_axilite_mask_1_AWADDR,s_axilite_mask_1_AWADDR,s_axilite_mask_1_AWADDR,s_axilite_mask_1_AWADDR,s_axilite_mask_1_AWADDR}),
        .s_axilite_AWPROT({s_axilite_mask_1_AWPROT,s_axilite_mask_1_AWPROT,s_axilite_mask_1_AWPROT}),
        .s_axilite_AWREADY(s_axilite_mask_1_AWREADY),
        .s_axilite_AWVALID(s_axilite_mask_1_AWVALID),
        .s_axilite_BREADY(s_axilite_mask_1_BREADY),
        .s_axilite_BRESP(s_axilite_mask_1_BRESP),
        .s_axilite_BVALID(s_axilite_mask_1_BVALID),
        .s_axilite_RDATA(s_axilite_mask_1_RDATA),
        .s_axilite_RREADY(s_axilite_mask_1_RREADY),
        .s_axilite_RRESP(s_axilite_mask_1_RRESP),
        .s_axilite_RVALID(s_axilite_mask_1_RVALID),
        .s_axilite_WDATA({s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA,s_axilite_mask_1_WDATA}),
        .s_axilite_WREADY(s_axilite_mask_1_WREADY),
        .s_axilite_WSTRB({s_axilite_mask_1_WSTRB,s_axilite_mask_1_WSTRB,s_axilite_mask_1_WSTRB,s_axilite_mask_1_WSTRB}),
        .s_axilite_WVALID(s_axilite_mask_1_WVALID),
        .s_axis_0_tdata(1'b0),
        .s_axis_0_tvalid(1'b0));
  finn_design_MVAU_hls_2_wstrm_rowlen_0 MVAU_hls_2_wstrm_rowlen
       (.ap_clk(ap_clk_1),
        .ap_clk2x(ap_clk_1),
        .ap_rst_n(ap_rst_n_1),
        .m_axis_0_tdata(MVAU_hls_2_wstrm_rowlen_m_axis_0_TDATA),
        .m_axis_0_tready(MVAU_hls_2_wstrm_rowlen_m_axis_0_TREADY),
        .m_axis_0_tvalid(MVAU_hls_2_wstrm_rowlen_m_axis_0_TVALID),
        .s_axilite_ARADDR({s_axilite_rowlen_1_ARADDR,s_axilite_rowlen_1_ARADDR,s_axilite_rowlen_1_ARADDR,s_axilite_rowlen_1_ARADDR,s_axilite_rowlen_1_ARADDR,s_axilite_rowlen_1_ARADDR,s_axilite_rowlen_1_ARADDR,s_axilite_rowlen_1_ARADDR}),
        .s_axilite_ARPROT({s_axilite_rowlen_1_ARPROT,s_axilite_rowlen_1_ARPROT,s_axilite_rowlen_1_ARPROT}),
        .s_axilite_ARREADY(s_axilite_rowlen_1_ARREADY),
        .s_axilite_ARVALID(s_axilite_rowlen_1_ARVALID),
        .s_axilite_AWADDR({s_axilite_rowlen_1_AWADDR,s_axilite_rowlen_1_AWADDR,s_axilite_rowlen_1_AWADDR,s_axilite_rowlen_1_AWADDR,s_axilite_rowlen_1_AWADDR,s_axilite_rowlen_1_AWADDR,s_axilite_rowlen_1_AWADDR,s_axilite_rowlen_1_AWADDR}),
        .s_axilite_AWPROT({s_axilite_rowlen_1_AWPROT,s_axilite_rowlen_1_AWPROT,s_axilite_rowlen_1_AWPROT}),
        .s_axilite_AWREADY(s_axilite_rowlen_1_AWREADY),
        .s_axilite_AWVALID(s_axilite_rowlen_1_AWVALID),
        .s_axilite_BREADY(s_axilite_rowlen_1_BREADY),
        .s_axilite_BRESP(s_axilite_rowlen_1_BRESP),
        .s_axilite_BVALID(s_axilite_rowlen_1_BVALID),
        .s_axilite_RDATA(s_axilite_rowlen_1_RDATA),
        .s_axilite_RREADY(s_axilite_rowlen_1_RREADY),
        .s_axilite_RRESP(s_axilite_rowlen_1_RRESP),
        .s_axilite_RVALID(s_axilite_rowlen_1_RVALID),
        .s_axilite_WDATA({s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA,s_axilite_rowlen_1_WDATA}),
        .s_axilite_WREADY(s_axilite_rowlen_1_WREADY),
        .s_axilite_WSTRB({s_axilite_rowlen_1_WSTRB,s_axilite_rowlen_1_WSTRB,s_axilite_rowlen_1_WSTRB,s_axilite_rowlen_1_WSTRB}),
        .s_axilite_WVALID(s_axilite_rowlen_1_WVALID),
        .s_axis_0_tdata(1'b0),
        .s_axis_0_tvalid(1'b0));
  finn_design_MVAU_hls_2_wstrm_sfidx_0 MVAU_hls_2_wstrm_sfidx
       (.ap_clk(ap_clk_1),
        .ap_clk2x(ap_clk_1),
        .ap_rst_n(ap_rst_n_1),
        .m_axis_0_tdata(MVAU_hls_2_wstrm_sfidx_m_axis_0_TDATA),
        .m_axis_0_tready(MVAU_hls_2_wstrm_sfidx_m_axis_0_TREADY),
        .m_axis_0_tvalid(MVAU_hls_2_wstrm_sfidx_m_axis_0_TVALID),
        .s_axilite_ARADDR({s_axilite_sfidx_1_ARADDR,s_axilite_sfidx_1_ARADDR,s_axilite_sfidx_1_ARADDR,s_axilite_sfidx_1_ARADDR,s_axilite_sfidx_1_ARADDR,s_axilite_sfidx_1_ARADDR,s_axilite_sfidx_1_ARADDR,s_axilite_sfidx_1_ARADDR}),
        .s_axilite_ARPROT({s_axilite_sfidx_1_ARPROT,s_axilite_sfidx_1_ARPROT,s_axilite_sfidx_1_ARPROT}),
        .s_axilite_ARREADY(s_axilite_sfidx_1_ARREADY),
        .s_axilite_ARVALID(s_axilite_sfidx_1_ARVALID),
        .s_axilite_AWADDR({s_axilite_sfidx_1_AWADDR,s_axilite_sfidx_1_AWADDR,s_axilite_sfidx_1_AWADDR,s_axilite_sfidx_1_AWADDR,s_axilite_sfidx_1_AWADDR,s_axilite_sfidx_1_AWADDR,s_axilite_sfidx_1_AWADDR,s_axilite_sfidx_1_AWADDR}),
        .s_axilite_AWPROT({s_axilite_sfidx_1_AWPROT,s_axilite_sfidx_1_AWPROT,s_axilite_sfidx_1_AWPROT}),
        .s_axilite_AWREADY(s_axilite_sfidx_1_AWREADY),
        .s_axilite_AWVALID(s_axilite_sfidx_1_AWVALID),
        .s_axilite_BREADY(s_axilite_sfidx_1_BREADY),
        .s_axilite_BRESP(s_axilite_sfidx_1_BRESP),
        .s_axilite_BVALID(s_axilite_sfidx_1_BVALID),
        .s_axilite_RDATA(s_axilite_sfidx_1_RDATA),
        .s_axilite_RREADY(s_axilite_sfidx_1_RREADY),
        .s_axilite_RRESP(s_axilite_sfidx_1_RRESP),
        .s_axilite_RVALID(s_axilite_sfidx_1_RVALID),
        .s_axilite_WDATA({s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA,s_axilite_sfidx_1_WDATA}),
        .s_axilite_WREADY(s_axilite_sfidx_1_WREADY),
        .s_axilite_WSTRB({s_axilite_sfidx_1_WSTRB,s_axilite_sfidx_1_WSTRB,s_axilite_sfidx_1_WSTRB,s_axilite_sfidx_1_WSTRB}),
        .s_axilite_WVALID(s_axilite_sfidx_1_WVALID),
        .s_axis_0_tdata(1'b0),
        .s_axis_0_tvalid(1'b0));
  finn_design_MVAU_hls_2_wstrm_val_0 MVAU_hls_2_wstrm_val
       (.ap_clk(ap_clk_1),
        .ap_clk2x(ap_clk_1),
        .ap_rst_n(ap_rst_n_1),
        .m_axis_0_tdata(MVAU_hls_2_wstrm_val_m_axis_0_TDATA),
        .m_axis_0_tready(MVAU_hls_2_wstrm_val_m_axis_0_TREADY),
        .m_axis_0_tvalid(MVAU_hls_2_wstrm_val_m_axis_0_TVALID),
        .s_axilite_ARADDR({s_axilite_val_1_ARADDR,s_axilite_val_1_ARADDR,s_axilite_val_1_ARADDR,s_axilite_val_1_ARADDR,s_axilite_val_1_ARADDR,s_axilite_val_1_ARADDR,s_axilite_val_1_ARADDR,s_axilite_val_1_ARADDR}),
        .s_axilite_ARPROT({s_axilite_val_1_ARPROT,s_axilite_val_1_ARPROT,s_axilite_val_1_ARPROT}),
        .s_axilite_ARREADY(s_axilite_val_1_ARREADY),
        .s_axilite_ARVALID(s_axilite_val_1_ARVALID),
        .s_axilite_AWADDR({s_axilite_val_1_AWADDR,s_axilite_val_1_AWADDR,s_axilite_val_1_AWADDR,s_axilite_val_1_AWADDR,s_axilite_val_1_AWADDR,s_axilite_val_1_AWADDR,s_axilite_val_1_AWADDR,s_axilite_val_1_AWADDR}),
        .s_axilite_AWPROT({s_axilite_val_1_AWPROT,s_axilite_val_1_AWPROT,s_axilite_val_1_AWPROT}),
        .s_axilite_AWREADY(s_axilite_val_1_AWREADY),
        .s_axilite_AWVALID(s_axilite_val_1_AWVALID),
        .s_axilite_BREADY(s_axilite_val_1_BREADY),
        .s_axilite_BRESP(s_axilite_val_1_BRESP),
        .s_axilite_BVALID(s_axilite_val_1_BVALID),
        .s_axilite_RDATA(s_axilite_val_1_RDATA),
        .s_axilite_RREADY(s_axilite_val_1_RREADY),
        .s_axilite_RRESP(s_axilite_val_1_RRESP),
        .s_axilite_RVALID(s_axilite_val_1_RVALID),
        .s_axilite_WDATA({s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA,s_axilite_val_1_WDATA}),
        .s_axilite_WREADY(s_axilite_val_1_WREADY),
        .s_axilite_WSTRB({s_axilite_val_1_WSTRB,s_axilite_val_1_WSTRB,s_axilite_val_1_WSTRB,s_axilite_val_1_WSTRB}),
        .s_axilite_WVALID(s_axilite_val_1_WVALID),
        .s_axis_0_tdata(1'b0),
        .s_axis_0_tvalid(1'b0));
endmodule

module MVAU_hls_3_imp_U0RWZQ
   (ap_clk,
    ap_rst_n,
    in0_V_tdata,
    in0_V_tready,
    in0_V_tvalid,
    out0_V_tdata,
    out0_V_tready,
    out0_V_tvalid);
  input ap_clk;
  input ap_rst_n;
  input [7:0]in0_V_tdata;
  output in0_V_tready;
  input in0_V_tvalid;
  output [7:0]out0_V_tdata;
  input out0_V_tready;
  output out0_V_tvalid;

  wire [7:0]MVAU_hls_3_out0_V_TDATA;
  wire MVAU_hls_3_out0_V_TREADY;
  wire MVAU_hls_3_out0_V_TVALID;
  wire [7:0]MVAU_hls_3_wstrm_m_axis_0_TDATA;
  wire MVAU_hls_3_wstrm_m_axis_0_TREADY;
  wire MVAU_hls_3_wstrm_m_axis_0_TVALID;
  wire ap_clk_1;
  wire ap_rst_n_1;
  wire [7:0]in0_V_1_TDATA;
  wire in0_V_1_TREADY;
  wire in0_V_1_TVALID;

  assign MVAU_hls_3_out0_V_TREADY = out0_V_tready;
  assign ap_clk_1 = ap_clk;
  assign ap_rst_n_1 = ap_rst_n;
  assign in0_V_1_TDATA = in0_V_tdata[7:0];
  assign in0_V_1_TVALID = in0_V_tvalid;
  assign in0_V_tready = in0_V_1_TREADY;
  assign out0_V_tdata[7:0] = MVAU_hls_3_out0_V_TDATA;
  assign out0_V_tvalid = MVAU_hls_3_out0_V_TVALID;
  finn_design_MVAU_hls_3_0 MVAU_hls_3
       (.ap_clk(ap_clk_1),
        .ap_rst_n(ap_rst_n_1),
        .in0_V_TDATA(in0_V_1_TDATA),
        .in0_V_TREADY(in0_V_1_TREADY),
        .in0_V_TVALID(in0_V_1_TVALID),
        .in1_V_TDATA(MVAU_hls_3_wstrm_m_axis_0_TDATA),
        .in1_V_TREADY(MVAU_hls_3_wstrm_m_axis_0_TREADY),
        .in1_V_TVALID(MVAU_hls_3_wstrm_m_axis_0_TVALID),
        .out0_V_TDATA(MVAU_hls_3_out0_V_TDATA),
        .out0_V_TREADY(MVAU_hls_3_out0_V_TREADY),
        .out0_V_TVALID(MVAU_hls_3_out0_V_TVALID));
  finn_design_MVAU_hls_3_wstrm_0 MVAU_hls_3_wstrm
       (.ap_clk(ap_clk_1),
        .ap_clk2x(ap_clk_1),
        .ap_rst_n(ap_rst_n_1),
        .m_axis_0_tdata(MVAU_hls_3_wstrm_m_axis_0_TDATA),
        .m_axis_0_tready(MVAU_hls_3_wstrm_m_axis_0_TREADY),
        .m_axis_0_tvalid(MVAU_hls_3_wstrm_m_axis_0_TVALID),
        .s_axilite_ARADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axilite_ARPROT({1'b0,1'b0,1'b0}),
        .s_axilite_ARVALID(1'b0),
        .s_axilite_AWADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axilite_AWPROT({1'b0,1'b0,1'b0}),
        .s_axilite_AWVALID(1'b0),
        .s_axilite_BREADY(1'b0),
        .s_axilite_RREADY(1'b0),
        .s_axilite_WDATA({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axilite_WSTRB({1'b1,1'b1,1'b1,1'b1}),
        .s_axilite_WVALID(1'b0),
        .s_axis_0_tdata(1'b0),
        .s_axis_0_tvalid(1'b0));
endmodule

(* CORE_GENERATION_INFO = "finn_design,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=finn_design,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=26,numReposBlks=22,numNonXlnxBlks=0,numHierBlks=4,maxHierDepth=1,numSysgenBlks=0,numHlsBlks=4,numHdlrefBlks=18,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "finn_design.hwdef" *) 
module finn_design
   (ap_clk,
    ap_rst_n,
    m_axis_0_tdata,
    m_axis_0_tready,
    m_axis_0_tvalid,
    s_axis_0_tdata,
    s_axis_0_tready,
    s_axis_0_tvalid);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.AP_CLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.AP_CLK, ASSOCIATED_BUSIF s_axis_0:m_axis_0, ASSOCIATED_RESET ap_rst_n, CLK_DOMAIN finn_design_ap_clk_0, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) input ap_clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.AP_RST_N RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.AP_RST_N, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input ap_rst_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_0 " *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m_axis_0, CLK_DOMAIN finn_design_ap_clk_0, FREQ_HZ 100000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.0, TDATA_NUM_BYTES 1, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) output [7:0]m_axis_0_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_0 " *) input m_axis_0_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_0 " *) output m_axis_0_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_0 " *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axis_0, CLK_DOMAIN finn_design_ap_clk_0, FREQ_HZ 100000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.0, TDATA_NUM_BYTES 1, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) input [7:0]s_axis_0_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_0 " *) output s_axis_0_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_0 " *) input s_axis_0_tvalid;

  wire [7:0]MVAU_hls_0_out0_V_TDATA;
  wire MVAU_hls_0_out0_V_TREADY;
  wire MVAU_hls_0_out0_V_TVALID;
  wire [7:0]MVAU_hls_1_out0_V_TDATA;
  wire MVAU_hls_1_out0_V_TREADY;
  wire MVAU_hls_1_out0_V_TVALID;
  wire [7:0]MVAU_hls_2_out0_V_TDATA;
  wire MVAU_hls_2_out0_V_TREADY;
  wire MVAU_hls_2_out0_V_TVALID;
  wire [7:0]MVAU_hls_3_out0_V_TDATA;
  wire MVAU_hls_3_out0_V_TREADY;
  wire MVAU_hls_3_out0_V_TVALID;
  wire [7:0]StreamingFIFO_rtl_0_out0_V_TDATA;
  wire StreamingFIFO_rtl_0_out0_V_TREADY;
  wire StreamingFIFO_rtl_0_out0_V_TVALID;
  wire [7:0]StreamingFIFO_rtl_1_out0_V_TDATA;
  wire StreamingFIFO_rtl_1_out0_V_TREADY;
  wire StreamingFIFO_rtl_1_out0_V_TVALID;
  wire [7:0]StreamingFIFO_rtl_2_out0_V_TDATA;
  wire StreamingFIFO_rtl_2_out0_V_TREADY;
  wire StreamingFIFO_rtl_2_out0_V_TVALID;
  wire [7:0]StreamingFIFO_rtl_3_out0_V_TDATA;
  wire StreamingFIFO_rtl_3_out0_V_TREADY;
  wire StreamingFIFO_rtl_3_out0_V_TVALID;
  wire [7:0]StreamingFIFO_rtl_4_out0_V_TDATA;
  wire StreamingFIFO_rtl_4_out0_V_TREADY;
  wire StreamingFIFO_rtl_4_out0_V_TVALID;
  wire ap_clk_0_1;
  wire ap_rst_n_0_1;
  wire [7:0]in0_V_0_1_TDATA;
  wire in0_V_0_1_TREADY;
  wire in0_V_0_1_TVALID;

  assign StreamingFIFO_rtl_4_out0_V_TREADY = m_axis_0_tready;
  assign ap_clk_0_1 = ap_clk;
  assign ap_rst_n_0_1 = ap_rst_n;
  assign in0_V_0_1_TDATA = s_axis_0_tdata[7:0];
  assign in0_V_0_1_TVALID = s_axis_0_tvalid;
  assign m_axis_0_tdata[7:0] = StreamingFIFO_rtl_4_out0_V_TDATA;
  assign m_axis_0_tvalid = StreamingFIFO_rtl_4_out0_V_TVALID;
  assign s_axis_0_tready = in0_V_0_1_TREADY;
  MVAU_hls_0_imp_7OH4JA MVAU_hls_0
       (.ap_clk(ap_clk_0_1),
        .ap_rst_n(ap_rst_n_0_1),
        .in0_V_tdata(StreamingFIFO_rtl_0_out0_V_TDATA),
        .in0_V_tready(StreamingFIFO_rtl_0_out0_V_TREADY),
        .in0_V_tvalid(StreamingFIFO_rtl_0_out0_V_TVALID),
        .out0_V_tdata(MVAU_hls_0_out0_V_TDATA),
        .out0_V_tready(MVAU_hls_0_out0_V_TREADY),
        .out0_V_tvalid(MVAU_hls_0_out0_V_TVALID),
        .s_axilite_mask_araddr(1'b0),
        .s_axilite_mask_arprot(1'b0),
        .s_axilite_mask_arvalid(1'b0),
        .s_axilite_mask_awaddr(1'b0),
        .s_axilite_mask_awprot(1'b0),
        .s_axilite_mask_awvalid(1'b0),
        .s_axilite_mask_bready(1'b0),
        .s_axilite_mask_rready(1'b0),
        .s_axilite_mask_wdata(1'b0),
        .s_axilite_mask_wstrb(1'b1),
        .s_axilite_mask_wvalid(1'b0),
        .s_axilite_rowlen_araddr(1'b0),
        .s_axilite_rowlen_arprot(1'b0),
        .s_axilite_rowlen_arvalid(1'b0),
        .s_axilite_rowlen_awaddr(1'b0),
        .s_axilite_rowlen_awprot(1'b0),
        .s_axilite_rowlen_awvalid(1'b0),
        .s_axilite_rowlen_bready(1'b0),
        .s_axilite_rowlen_rready(1'b0),
        .s_axilite_rowlen_wdata(1'b0),
        .s_axilite_rowlen_wstrb(1'b1),
        .s_axilite_rowlen_wvalid(1'b0),
        .s_axilite_sfidx_araddr(1'b0),
        .s_axilite_sfidx_arprot(1'b0),
        .s_axilite_sfidx_arvalid(1'b0),
        .s_axilite_sfidx_awaddr(1'b0),
        .s_axilite_sfidx_awprot(1'b0),
        .s_axilite_sfidx_awvalid(1'b0),
        .s_axilite_sfidx_bready(1'b0),
        .s_axilite_sfidx_rready(1'b0),
        .s_axilite_sfidx_wdata(1'b0),
        .s_axilite_sfidx_wstrb(1'b1),
        .s_axilite_sfidx_wvalid(1'b0),
        .s_axilite_val_araddr(1'b0),
        .s_axilite_val_arprot(1'b0),
        .s_axilite_val_arvalid(1'b0),
        .s_axilite_val_awaddr(1'b0),
        .s_axilite_val_awprot(1'b0),
        .s_axilite_val_awvalid(1'b0),
        .s_axilite_val_bready(1'b0),
        .s_axilite_val_rready(1'b0),
        .s_axilite_val_wdata(1'b0),
        .s_axilite_val_wstrb(1'b1),
        .s_axilite_val_wvalid(1'b0));
  MVAU_hls_1_imp_ZIW0NT MVAU_hls_1
       (.ap_clk(ap_clk_0_1),
        .ap_rst_n(ap_rst_n_0_1),
        .in0_V_tdata(StreamingFIFO_rtl_1_out0_V_TDATA),
        .in0_V_tready(StreamingFIFO_rtl_1_out0_V_TREADY),
        .in0_V_tvalid(StreamingFIFO_rtl_1_out0_V_TVALID),
        .out0_V_tdata(MVAU_hls_1_out0_V_TDATA),
        .out0_V_tready(MVAU_hls_1_out0_V_TREADY),
        .out0_V_tvalid(MVAU_hls_1_out0_V_TVALID),
        .s_axilite_mask_araddr(1'b0),
        .s_axilite_mask_arprot(1'b0),
        .s_axilite_mask_arvalid(1'b0),
        .s_axilite_mask_awaddr(1'b0),
        .s_axilite_mask_awprot(1'b0),
        .s_axilite_mask_awvalid(1'b0),
        .s_axilite_mask_bready(1'b0),
        .s_axilite_mask_rready(1'b0),
        .s_axilite_mask_wdata(1'b0),
        .s_axilite_mask_wstrb(1'b1),
        .s_axilite_mask_wvalid(1'b0),
        .s_axilite_rowlen_araddr(1'b0),
        .s_axilite_rowlen_arprot(1'b0),
        .s_axilite_rowlen_arvalid(1'b0),
        .s_axilite_rowlen_awaddr(1'b0),
        .s_axilite_rowlen_awprot(1'b0),
        .s_axilite_rowlen_awvalid(1'b0),
        .s_axilite_rowlen_bready(1'b0),
        .s_axilite_rowlen_rready(1'b0),
        .s_axilite_rowlen_wdata(1'b0),
        .s_axilite_rowlen_wstrb(1'b1),
        .s_axilite_rowlen_wvalid(1'b0),
        .s_axilite_sfidx_araddr(1'b0),
        .s_axilite_sfidx_arprot(1'b0),
        .s_axilite_sfidx_arvalid(1'b0),
        .s_axilite_sfidx_awaddr(1'b0),
        .s_axilite_sfidx_awprot(1'b0),
        .s_axilite_sfidx_awvalid(1'b0),
        .s_axilite_sfidx_bready(1'b0),
        .s_axilite_sfidx_rready(1'b0),
        .s_axilite_sfidx_wdata(1'b0),
        .s_axilite_sfidx_wstrb(1'b1),
        .s_axilite_sfidx_wvalid(1'b0),
        .s_axilite_val_araddr(1'b0),
        .s_axilite_val_arprot(1'b0),
        .s_axilite_val_arvalid(1'b0),
        .s_axilite_val_awaddr(1'b0),
        .s_axilite_val_awprot(1'b0),
        .s_axilite_val_awvalid(1'b0),
        .s_axilite_val_bready(1'b0),
        .s_axilite_val_rready(1'b0),
        .s_axilite_val_wdata(1'b0),
        .s_axilite_val_wstrb(1'b1),
        .s_axilite_val_wvalid(1'b0));
  MVAU_hls_2_imp_1WP2WTL MVAU_hls_2
       (.ap_clk(ap_clk_0_1),
        .ap_rst_n(ap_rst_n_0_1),
        .in0_V_tdata(StreamingFIFO_rtl_2_out0_V_TDATA),
        .in0_V_tready(StreamingFIFO_rtl_2_out0_V_TREADY),
        .in0_V_tvalid(StreamingFIFO_rtl_2_out0_V_TVALID),
        .out0_V_tdata(MVAU_hls_2_out0_V_TDATA),
        .out0_V_tready(MVAU_hls_2_out0_V_TREADY),
        .out0_V_tvalid(MVAU_hls_2_out0_V_TVALID),
        .s_axilite_mask_araddr(1'b0),
        .s_axilite_mask_arprot(1'b0),
        .s_axilite_mask_arvalid(1'b0),
        .s_axilite_mask_awaddr(1'b0),
        .s_axilite_mask_awprot(1'b0),
        .s_axilite_mask_awvalid(1'b0),
        .s_axilite_mask_bready(1'b0),
        .s_axilite_mask_rready(1'b0),
        .s_axilite_mask_wdata(1'b0),
        .s_axilite_mask_wstrb(1'b1),
        .s_axilite_mask_wvalid(1'b0),
        .s_axilite_rowlen_araddr(1'b0),
        .s_axilite_rowlen_arprot(1'b0),
        .s_axilite_rowlen_arvalid(1'b0),
        .s_axilite_rowlen_awaddr(1'b0),
        .s_axilite_rowlen_awprot(1'b0),
        .s_axilite_rowlen_awvalid(1'b0),
        .s_axilite_rowlen_bready(1'b0),
        .s_axilite_rowlen_rready(1'b0),
        .s_axilite_rowlen_wdata(1'b0),
        .s_axilite_rowlen_wstrb(1'b1),
        .s_axilite_rowlen_wvalid(1'b0),
        .s_axilite_sfidx_araddr(1'b0),
        .s_axilite_sfidx_arprot(1'b0),
        .s_axilite_sfidx_arvalid(1'b0),
        .s_axilite_sfidx_awaddr(1'b0),
        .s_axilite_sfidx_awprot(1'b0),
        .s_axilite_sfidx_awvalid(1'b0),
        .s_axilite_sfidx_bready(1'b0),
        .s_axilite_sfidx_rready(1'b0),
        .s_axilite_sfidx_wdata(1'b0),
        .s_axilite_sfidx_wstrb(1'b1),
        .s_axilite_sfidx_wvalid(1'b0),
        .s_axilite_val_araddr(1'b0),
        .s_axilite_val_arprot(1'b0),
        .s_axilite_val_arvalid(1'b0),
        .s_axilite_val_awaddr(1'b0),
        .s_axilite_val_awprot(1'b0),
        .s_axilite_val_awvalid(1'b0),
        .s_axilite_val_bready(1'b0),
        .s_axilite_val_rready(1'b0),
        .s_axilite_val_wdata(1'b0),
        .s_axilite_val_wstrb(1'b1),
        .s_axilite_val_wvalid(1'b0));
  MVAU_hls_3_imp_U0RWZQ MVAU_hls_3
       (.ap_clk(ap_clk_0_1),
        .ap_rst_n(ap_rst_n_0_1),
        .in0_V_tdata(StreamingFIFO_rtl_3_out0_V_TDATA),
        .in0_V_tready(StreamingFIFO_rtl_3_out0_V_TREADY),
        .in0_V_tvalid(StreamingFIFO_rtl_3_out0_V_TVALID),
        .out0_V_tdata(MVAU_hls_3_out0_V_TDATA),
        .out0_V_tready(MVAU_hls_3_out0_V_TREADY),
        .out0_V_tvalid(MVAU_hls_3_out0_V_TVALID));
  finn_design_StreamingFIFO_rtl_0_0 StreamingFIFO_rtl_0
       (.ap_clk(ap_clk_0_1),
        .ap_rst_n(ap_rst_n_0_1),
        .in0_V_TDATA(in0_V_0_1_TDATA),
        .in0_V_TREADY(in0_V_0_1_TREADY),
        .in0_V_TVALID(in0_V_0_1_TVALID),
        .out0_V_TDATA(StreamingFIFO_rtl_0_out0_V_TDATA),
        .out0_V_TREADY(StreamingFIFO_rtl_0_out0_V_TREADY),
        .out0_V_TVALID(StreamingFIFO_rtl_0_out0_V_TVALID));
  finn_design_StreamingFIFO_rtl_1_0 StreamingFIFO_rtl_1
       (.ap_clk(ap_clk_0_1),
        .ap_rst_n(ap_rst_n_0_1),
        .in0_V_TDATA(MVAU_hls_0_out0_V_TDATA),
        .in0_V_TREADY(MVAU_hls_0_out0_V_TREADY),
        .in0_V_TVALID(MVAU_hls_0_out0_V_TVALID),
        .out0_V_TDATA(StreamingFIFO_rtl_1_out0_V_TDATA),
        .out0_V_TREADY(StreamingFIFO_rtl_1_out0_V_TREADY),
        .out0_V_TVALID(StreamingFIFO_rtl_1_out0_V_TVALID));
  finn_design_StreamingFIFO_rtl_2_0 StreamingFIFO_rtl_2
       (.ap_clk(ap_clk_0_1),
        .ap_rst_n(ap_rst_n_0_1),
        .in0_V_TDATA(MVAU_hls_1_out0_V_TDATA),
        .in0_V_TREADY(MVAU_hls_1_out0_V_TREADY),
        .in0_V_TVALID(MVAU_hls_1_out0_V_TVALID),
        .out0_V_TDATA(StreamingFIFO_rtl_2_out0_V_TDATA),
        .out0_V_TREADY(StreamingFIFO_rtl_2_out0_V_TREADY),
        .out0_V_TVALID(StreamingFIFO_rtl_2_out0_V_TVALID));
  finn_design_StreamingFIFO_rtl_3_0 StreamingFIFO_rtl_3
       (.ap_clk(ap_clk_0_1),
        .ap_rst_n(ap_rst_n_0_1),
        .in0_V_TDATA(MVAU_hls_2_out0_V_TDATA),
        .in0_V_TREADY(MVAU_hls_2_out0_V_TREADY),
        .in0_V_TVALID(MVAU_hls_2_out0_V_TVALID),
        .out0_V_TDATA(StreamingFIFO_rtl_3_out0_V_TDATA),
        .out0_V_TREADY(StreamingFIFO_rtl_3_out0_V_TREADY),
        .out0_V_TVALID(StreamingFIFO_rtl_3_out0_V_TVALID));
  finn_design_StreamingFIFO_rtl_4_0 StreamingFIFO_rtl_4
       (.ap_clk(ap_clk_0_1),
        .ap_rst_n(ap_rst_n_0_1),
        .in0_V_TDATA(MVAU_hls_3_out0_V_TDATA),
        .in0_V_TREADY(MVAU_hls_3_out0_V_TREADY),
        .in0_V_TVALID(MVAU_hls_3_out0_V_TVALID),
        .out0_V_TDATA(StreamingFIFO_rtl_4_out0_V_TDATA),
        .out0_V_TREADY(StreamingFIFO_rtl_4_out0_V_TREADY),
        .out0_V_TVALID(StreamingFIFO_rtl_4_out0_V_TVALID));
endmodule
