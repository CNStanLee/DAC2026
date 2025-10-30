# ==============================================================
# Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
# Tool Version Limit: 2019.12
# Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
# ==============================================================
CSIM_DESIGN = 1

__SIM_FPO__ = 1

__SIM_MATHHLS__ = 1

__SIM_FFT__ = 1

__SIM_FIR__ = 1

__SIM_DDS__ = 1

ObjDir = obj

HLS_SOURCES = ../../../../csr_mvau_stream_tb.cpp ../../../../mvau_stream_top_masked.cpp ../../../../mvau_stream_top.cpp ../../../../csr_mvau_stream_top.cpp

override TARGET := csim.exe

AUTOPILOT_ROOT := /tools/Xilinx/Vitis_HLS/2022.2
AUTOPILOT_MACH := lnx64
ifdef AP_GCC_M32
  AUTOPILOT_MACH := Linux_x86
  IFLAG += -m32
endif
IFLAG += -fPIC
ifndef AP_GCC_PATH
  AP_GCC_PATH := /tools/Xilinx/Vitis_HLS/2022.2/tps/lnx64/gcc-8.3.0/bin
endif
AUTOPILOT_TOOL := ${AUTOPILOT_ROOT}/${AUTOPILOT_MACH}/tools
AP_CLANG_PATH := ${AUTOPILOT_TOOL}/clang-3.9/bin
AUTOPILOT_TECH := ${AUTOPILOT_ROOT}/common/technology


IFLAG += -I "${AUTOPILOT_ROOT}/include"
IFLAG += -I "${AUTOPILOT_ROOT}/include/ap_sysc"
IFLAG += -I "${AUTOPILOT_TECH}/generic/SystemC"
IFLAG += -I "${AUTOPILOT_TECH}/generic/SystemC/AESL_FP_comp"
IFLAG += -I "${AUTOPILOT_TECH}/generic/SystemC/AESL_comp"
IFLAG += -I "${AUTOPILOT_TOOL}/auto_cc/include"
IFLAG += -I "/usr/include/x86_64-linux-gnu"
IFLAG += -D__HLS_COSIM__

IFLAG += -D__HLS_CSIM__

IFLAG += -D__VITIS_HLS__

IFLAG += -D__SIM_FPO__

IFLAG += -D__SIM_FFT__

IFLAG += -D__SIM_FIR__

IFLAG += -D__SIM_DDS__

IFLAG += -I/home/changhong/prj/finn_dev_branch/finn/script/DAC2026/spmm/finn_hlslib -I/home/changhong/prj/finn_dev_branch/finn/script/DAC2026/spmm/finn_hlslib/tb -std=c++14 -Wno-unknown-pragmas 
AP_ENABLE_OPTIMIZED := 1
DFLAG += -D__xilinx_ip_top= -DAESL_TB
CCFLAG += -Werror=return-type
CCFLAG += -Wno-abi
TOOLCHAIN += 



include ./Makefile.rules

all: $(TARGET)



$(ObjDir)/csr_mvau_stream_tb.o: ../../../../csr_mvau_stream_tb.cpp $(ObjDir)/.dir
	$(Echo) "   Compiling ../../../../csr_mvau_stream_tb.cpp in $(BuildMode) mode" $(AVE_DIR_DLOG)
	$(Verb)  $(CC) ${CCFLAG} -c -MMD -I/home/changhong/prj/finn_dev_branch/finn/script/DAC2026/spmm/finn_hlslib -I/home/changhong/prj/finn_dev_branch/finn/script/DAC2026/spmm/finn_hlslib/tb -std=c++14 -Wno-unknown-pragmas -Wno-unknown-pragmas  $(IFLAG) $(DFLAG) -DNDEBUG $< -o $@ ; \

-include $(ObjDir)/csr_mvau_stream_tb.d

$(ObjDir)/mvau_stream_top_masked.o: ../../../../mvau_stream_top_masked.cpp $(ObjDir)/.dir
	$(Echo) "   Compiling ../../../../mvau_stream_top_masked.cpp in $(BuildMode) mode" $(AVE_DIR_DLOG)
	$(Verb)  $(CC) ${CCFLAG} -c -MMD -I/home/changhong/prj/finn_dev_branch/finn/script/DAC2026/spmm/finn_hlslib -I/home/changhong/prj/finn_dev_branch/finn/script/DAC2026/spmm/finn_hlslib/tb -std=c++14  $(IFLAG) $(DFLAG) -DNDEBUG $< -o $@ ; \

-include $(ObjDir)/mvau_stream_top_masked.d

$(ObjDir)/mvau_stream_top.o: ../../../../mvau_stream_top.cpp $(ObjDir)/.dir
	$(Echo) "   Compiling ../../../../mvau_stream_top.cpp in $(BuildMode) mode" $(AVE_DIR_DLOG)
	$(Verb)  $(CC) ${CCFLAG} -c -MMD -I/home/changhong/prj/finn_dev_branch/finn/script/DAC2026/spmm/finn_hlslib -I/home/changhong/prj/finn_dev_branch/finn/script/DAC2026/spmm/finn_hlslib/tb -std=c++14  $(IFLAG) $(DFLAG) -DNDEBUG $< -o $@ ; \

-include $(ObjDir)/mvau_stream_top.d

$(ObjDir)/csr_mvau_stream_top.o: ../../../../csr_mvau_stream_top.cpp $(ObjDir)/.dir
	$(Echo) "   Compiling ../../../../csr_mvau_stream_top.cpp in $(BuildMode) mode" $(AVE_DIR_DLOG)
	$(Verb)  $(CC) ${CCFLAG} -c -MMD -I/home/changhong/prj/finn_dev_branch/finn/script/DAC2026/spmm/finn_hlslib -I/home/changhong/prj/finn_dev_branch/finn/script/DAC2026/spmm/finn_hlslib/tb -std=c++14  $(IFLAG) $(DFLAG) -DNDEBUG $< -o $@ ; \

-include $(ObjDir)/csr_mvau_stream_top.d
