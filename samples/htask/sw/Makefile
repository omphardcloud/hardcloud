# Makefile -- grayscale Makefile

# creating an application
TARGET = htask

# where is the Clang/LLVM with support to Intel HARP offloading?
ifeq ($(wildcard $(LLVM)),)
$(error Set LLVM to the root directory of the Clang/LLVM with support to offloading)
endif
ifeq ($(wildcard $(LLVM)/lib/libomptarget.rtl.awsf1.so),)
$(error Set LLVM to the root directory of the Clang/LLVM with support to AWSF1 offloading)
endif

ifeq ($(wildcard $(LLVM)/lib/libomptarget.rtl.cuda.so),)
$(error Set LLVM to the root directory of the Clang/LLVM with support to CUDA offloading)
endif

# libraries to use, objects to compile

SRCS = htask.cpp image.cpp
SRCS_FILES = $(foreach F, $(SRCS), src/$(F))
COMMON_FILES =

INCLUDES = -Iinclude -L$(LLVM)/lib

LIBS = -lomptarget -lpng

COMPILE = $(LLVM)/bin/clang++

ARGS_HOST = -O3
ARGS_AWSF1SIM = -fopenmp -fopenmp-targets=nvptx64-nvidia-cuda,awsf1

# Make it all!
all: folder htask

htask:
	$(COMPILE) $(ARGS_AWSF1SIM) $(INCLUDES) $(LIBS) $(SRCS_FILES) -o build/$(TARGET) -v
	cp /home/ramon/hardcloud/base/hw/awsf1/emconfig.json build/

folder:
	mkdir -p build/

clean:
	rm -rf build/

# taf!
