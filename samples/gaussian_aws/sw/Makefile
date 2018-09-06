# Makefile -- Gaussian Makefile

# creating an application
TARGET = gaussian

TARGET_HOST = host_$(TARGET)
TARGET_AWSF1SIM = awsf1_sim_$(TARGET)

# where is the Clang/LLVM with support to Intel HARP offloading?
ifeq ($(wildcard $(LLVM)),)
$(error Set LLVM to the root directory of the Clang/LLVM with support to Intel HARP offloading)
endif
ifeq ($(wildcard $(LLVM)/lib/libomptarget.rtl.awsf1.so),)
$(error Set LLVM to the root directory of the Clang/LLVM with support to Intel HARP offloading)
endif

# libraries to use, objects to compile
SRCS = main.cpp image.cpp
SRCS_FILES = $(foreach F, $(SRCS), src/$(F))
COMMON_FILES =

INCLUDES = -Iinclude -L$(LLVM)/lib

LIBS = -lomptarget -lpng

COMPILE = $(LLVM)/bin/clang++

ARGS_HOST =
ARGS_AWSF1SIM = -fopenmp -fopenmp-targets=awsf1

# Make it all!
all: folder host awsf1

host:
	$(COMPILE) $(ARGS_HOST) $(INCLUDES) $(LIBS) $(SRCS_FILES) -o build/$(TARGET_HOST)

awsf1:
	$(COMPILE) $(ARGS_AWSF1SIM) $(INCLUDES) $(LIBS) $(SRCS_FILES) -o build/$(TARGET_AWSF1SIM)
	cp /home/ramon/hardcloud/base/hw/awsf1/emconfig.json build/

folder:
	mkdir -p build/

clean:
	rm -rf build/

# taf!
