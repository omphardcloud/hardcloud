# Makefile -- Sobel Makefile

# creating an application
TARGET = sobel

TARGET_HOST = host_$(TARGET)
TARGET_HARPSIM = harpsim_$(TARGET)

# where is the Clang/LLVM with support to Intel HARP offloading?
ifeq ($(wildcard $(LLVM)),)
$(error Set LLVM to the root directory of the Clang/LLVM with support to Intel HARP offloading)
endif
ifeq ($(wildcard $(LLVM)/lib/libomptarget.rtl.harpsim.so),)
$(error Set LLVM to the root directory of the Clang/LLVM with support to Intel HARP offloading)
endif

# libraries to use, objects to compile
SRCS = main.cpp image.cpp
SRCS_FILES = $(foreach F, $(SRCS), src/$(F))
COMMON_FILES =

INCLUDES = -Iinclude -L$(LLVM)/lib

LIBS = -lomptarget -lpng

COMPILE = $(LLVM)/bin/clang++

ARGS_HOST = -O3
ARGS_HARPSIM = -fopenmp -fopenmp-targets=harpsim

# Make it all!
all: folder host harpsim

host:
	$(COMPILE) $(ARGS_HOST) $(INCLUDES) $(LIBS) $(SRCS_FILES) -o build/$(TARGET_HOST)

harpsim:
	$(COMPILE) $(ARGS_HARPSIM) $(INCLUDES) $(LIBS) $(SRCS_FILES) -o build/$(TARGET_HARPSIM)

ir:
	$(COMPILE) $(ARGS_HOST) $(INCLUDES) src/main.cpp -S -mllvm --x86-asm-syntax=intel -o build/$(TARGET).asm

folder:
	mkdir -p build/

clean:
	rm -rf build/

# taf!
