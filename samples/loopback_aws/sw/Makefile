# Makefile -- Loopback Makefile

# creating an application
TARGET = loopback

TARGET_HOST = host_$(TARGET)
TARGET_HARPSIM = harpsim_$(TARGET)
TARGET_VERIF_LIB = libomptarget.rtl.verification.so

# where is the Clang/LLVM with support to Intel HARP offloading?
ifeq ($(wildcard $(LLVM)),)
$(error Set LLVM to the root directory of the Clang/LLVM with support to Intel HARP offloading)
endif
ifeq ($(wildcard $(LLVM)/lib/libomptarget.so),)
$(error Set LLVM to the root directory of the Clang/LLVM with support to Intel HARP offloading)
endif
ifeq ($(wildcard $(LLVM)/lib/libomptarget.rtl.harpsim.so),)
$(error Set LLVM to the root directory of the Clang/LLVM with support to Intel HARP offloading)
endif

# libraries to use, objects to compile
SRCS = main.cpp
SRCS_FILES = $(foreach F, $(SRCS), src/$(F))
VERIF_FILES = test/check.cpp
COMMON_FILES =

INCLUDES = -Iinclude -L$(LLVM)/lib

LIBS = -lomptarget

COMPILE = $(LLVM)/bin/clang++

ARGS_HOST =
ARGS_HARPSIM = -fopenmp -fopenmp-targets=harpsim
ARGS_VERIF = -shared -fPIC

# Make it all!
all: folder host harpsim

host:
	$(COMPILE) $(ARGS_HOST) $(INCLUDES) $(LIBS) $(SRCS_FILES) -o build/$(TARGET_HOST)

harpsim:
	$(COMPILE) $(ARGS_HARPSIM) $(INCLUDES) $(LIBS) $(SRCS_FILES) -o build/$(TARGET_HARPSIM)

verification:
	$(COMPILE) $(ARGS_VERIF) $(VERIF_FILES) -o build/$(TARGET_VERIF_LIB)

folder:
	mkdir -p build/

clean:
	rm -rf build/

# taf!
