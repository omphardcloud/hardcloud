# Makefile -- Sobel Makefile

# creating an application
TARGET = sobel_aws

TARGET_HOST = host_$(TARGET)
TARGET_HARPSIM = awsf1_$(TARGET)

# where is the Clang/LLVM with support to Intel HARP offloading?
ifeq ($(wildcard $(LLVM)),)
$(error Set LLVM to the root directory of the Clang/LLVM with support to Intel AWSF offloading)
endif
ifeq ($(wildcard $(LLVM)/lib/libomptarget.rtl.awsf1.so),)
$(error Set LLVM to the root directory of the Clang/LLVM with support to Intel AWSF1 offloading)
endif

# libraries to use, objects to compile
SRCS = main.cpp image.cpp
SRCS_FILES = $(foreach F, $(SRCS), src/$(F))
COMMON_FILES =

INCLUDES = -Iinclude -L$(LLVM)/lib

LIBS = -lomptarget -lpng

COMPILE = $(LLVM)/bin/clang++

ARGS_HOST = -O3
ARGS_HARPSIM = -fopenmp -fopenmp-targets=awsf1

# Make it all!



all: folder host awsf1 emu


host:
	$(COMPILE) $(ARGS_HOST) $(INCLUDES) $(LIBS) $(SRCS_FILES) -o build/$(TARGET_HOST)

awsf1:

	$(COMPILE) $(ARGS_HARPSIM) $(INCLUDES) $(LIBS) $(SRCS_FILES) -o build/$(TARGET_HARPSIM)

ir:
	$(COMPILE) $(ARGS_HOST) $(INCLUDES) src/main.cpp -S -mllvm --x86-asm-syntax=intel -o build/$(TARGET).asm


emu:
	/opt/Xilinx/SDx/2017.1.op/bin/emconfigutil --od ./build/ --platform /home/ramon/aws-fpga/SDAccel/aws_platform/xilinx_aws-vu9p-f1_4ddr-xpr-2pr_4_0/xilinx_aws-vu9p-f1_4ddr-xpr-2pr_4_0.xpfm --nd 1.


folder:
	mkdir -p build/

clean:
	rm -rf build/

# taf!
