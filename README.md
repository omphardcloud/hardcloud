# HardCloud - FPGA as an OpenMP Offloading Device.

<p align="justify">

The computing industry has recently proposed the use of FPGAs as a way
to improve performance and energy efficiency in modern cloud clusters.
Unfortunately, using  such FPGA  clusters is a  very hard  and complex
task.  In  this context,  we  present  HardCloud  a novel  and  simple
mechanism to offload computation to  the FPGAs available in the Xilinx
Alveo U200/U250 platform. HardCloud  extends OpenMP directives in such
a way  that the FPGA  becomes just another OpenMP  acceleration device
that can  be used directly  from any  user program. The  example below
shows a simple use of the syntax that was adopted.

</p>

```c
#pragma omp target device(ALVEO) implements(loopback) map(to: A) map(from: B)
#pragma omp parallel for
// Code that represents the loopback bitstream
for (int i = 0; i < NI; i++) {
    B[i] = A[i];
}
```

## Install and Configure

The following tutorial considers  that $WORKSPACE environment variable
contains the path to the folder  you want to work in and $INSTALL_PATH
the installation path.

### Library/Tools Dependency

Install the following libraries dependencies:

* uuid
* json-c
* boost_program_options
* libelf
* libffi
* Python 3.6.8
* Xilinx SDx 2018.3
* Xilinx Vivado 2018.3
* Xilinx runtime (XRT)
* Xilinx Alveo U200/U250 Deployment Target Platform
* Xilinx Alveo U200/U250 Development Target Platform

### Repository

Clone the HardCloud Alveo repository with all dependencies:

```
$ cd ${WORKSPACE}
$ git clone git@github.com:omphardcloud/hardcloud.git --recursive
```

### Install LLVM/Clang LSC-OpenMP

<p align="justify">

The  LLVM/Clang  LSC-OpenMP is  a  version  of the  original  compiler
that works  with OpenMP  offloading library, called  libomptarget. The
libomptarget  handles the  OpenMP  4.x <i>target</i>  directive in  an
agnostic manner. Moreover, the Xilinx  FPGA selection is identified by
the <i>device</i> directive  that will execute a  specific plugin that
manages the communication via the SDAccel.

</p>

```
$ ln -s $WORKSPACE/hardcloud/clang  $WORKSPACE/hardcloud/llvm/tools/
$ ln -s $WORKSPACE/hardcloud/openmp $WORKSPACE/hardcloud/llvm/projects/

$ mkdir -p $WORKSPACE/hardcloud/llvm/build

$ cd $WORKSPACE/hardcloud/llvm/build

$ cmake -DOPENMP_ENABLE_LIBOMPTARGET=ON      \
  -DCMAKE_BUILD_TYPE="release"               \
  -DXILINX_VIVADO=/tools/Xilinx/Vivado/2018.3  \
  -DXILINX_SDX=/tools/Xilinx/SDx/2018.3        \
  -DXILINX_XRT=/opt/xilinx/xrt               \
  -DCMAKE_INSTALL_PREFIX=${INSTALL_PATH} ..

$ make -j8
$ make install
```

For more information, access <a
href="https://llvm.org/docs/CMake.html">Building  LLVM with  CMake</a>
and <a href="https://github.com/LSC-OpenMP/">repository to LLVM/CLang
with support to HardCloud</a>.

### Configure

Create the following script,  ${INSTALL_PATH}/setup.alveo, to configure the
environment:

```
#!/usr/bin/env bash

# configure xilinx tools and runtime
source /tools/Xilinx/Vivado/2018.3/settings64.sh
source /tools/Xilinx/SDx/2018.3/settings64.sh
source /opt/xilinx/xrt/setup.sh

# configure llvm
export LLVM=${INSTALL_PATH}

# set library path
export LD_LIBRARY_PATH=${LLVM}/lib:$LD_LIBRARY_PATH

# set path
export PATH="${LLVM}/bin:${PATH}"

# create HardCloud alias
alias hardcloud='/usr/bin/python3 $WORKSPACE/hardcloud/scripts/sdx/hardcloud.py'
```

## How to create your hardware

```
$ source $INSTALL_PATH/setup.alveo
$ hardcloud --new_project PROJECT_NAME
$ cd PROJECT_NAME/
```

### Emulation

```
$ hardcloud --build --target=emulation
```

### Generate the binary to the FPGA

```
$ hardcloud --build --target=FPGA
```

The output binary ...

## How to create your software

