# HardCloud - FPGA as an OpenMP Offloading Device.

<p align="justify">
The computing industry has recently proposed the use of FPGAs as a way
to improve performance and energy efficiency in modern cloud clusters.
Unfortunately, using  such FPGA  clusters is a  very hard  and complex
task.  In  this context,  we  present  HardCloud  a novel  and  simple
mechanism to offload computation to  the FPGAs available in the Xilinx
Alveo U200 platform. HardCloud  extends OpenMP directives in such
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

## 1. Install and Configure

<p align="justify">
The following tutorial considers  that $WORKSPACE environment variable
contains the path to the folder  you want to work in and $INSTALL_PATH
the  installation path.  Also,  the $PROJECT_NAME_PATH  points to  the
project base path.
</p>

### 1.1. Library/Tools Dependency

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
* Xilinx Alveo U200 Deployment Target Platform
* Xilinx Alveo U200 Development Target Platform

### 1.2. Repository

Clone the HardCloud Alveo repository with all dependencies:

```
$ cd ${WORKSPACE}
$ git clone --branch dev-alveo https://github.com/omphardcloud/hardcloud.git --recursive
```

### 1.3. Install LLVM/Clang LSC-OpenMP

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

$ cmake -DOPENMP_ENABLE_LIBOMPTARGET=ON       \
  -DCMAKE_BUILD_TYPE="release"                \
  -DXILINX_VIVADO=/tools/Xilinx/Vivado/2018.3 \
  -DXILINX_SDX=/tools/Xilinx/SDx/2018.3       \
  -DXILINX_XRT=/opt/xilinx/xrt                \
  -DCMAKE_INSTALL_PREFIX=${INSTALL_PATH} ..

$ make -j8
$ make install
```

<p align="justify">
For           more           information,          access           <a
href="https://llvm.org/docs/CMake.html">Building  LLVM with  CMake</a>
and <a  href="https://github.com/LSC-OpenMP/">repository to LLVM/CLang
with support to HardCloud</a>.
</p>

### 1.4. Configure

<p align="justify">
Create the following script, ${INSTALL_PATH}/setup.alveo, to configure
the environment:
</p>

```
#!/usr/bin/env bash

# configure license
export LM_LICENSE_FILE=PORT@URL

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

## 2. How to create your hardware

<p align="justify">
First, setup the  environment with the script created  in the previous
section.
</p>

```
$ source $INSTALL_PATH/setup.alveo
```

<p align="justify">
To  create a  new Hardcloud  project  with the  SDAccel and  HardCloud
shell,  just  call  the  encapsulation   script,  it  uses  the  alias
**hardcloud**, with  the argument  new_project and choose  the project
name.
</p>

```
$ hardcloud --new_project PROJECT_NAME
$ cd PROJECT_NAME/
```

<p align="justify">
Now, enter  the path <i>rtl_kernel/src/</i> and  start the development
of  the  Hardcloud   IP  (HIP).  This  directory   contains  a  single
SystemVerilog file, <i>hip.sv</i>, with a loopback example. The module
HIP has  the control  ports -  clk, reset,  start and  done -  and the
buffer  interface -  master  Hardcloud Interface  (HIF). The  hardware
designer could  add more SystemVerilog/Verilog files  for more complex
designs to the path, the  script will arrange new files automatically.
The next code presents a stub for the HIP module.
</p>

```
module HIP
(
  input  logic clk,
  input  logic reset,
  input  logic start,
  output logic done,

  hif.master   buffer
);

/* HIP implementation */

endmodule : HIP
```

<p align="justify">
The **start** port  informs that hardware configuration  has been done
and now the computation could start. The **done** port is used to send
this signal to  the software, setting it to high.  The **buffer** port
is a  SystemVerilog interface  and comprehends several  functions that
enable the user to retrieve or send data, in an effortless way.
</p>

<p align="justify">
After  create the  HIP,  the next  step  is to  create  a binary  that
encapsulates the  whole project. The  binary could be created  for two
targets: hardware emulation and FPGA.  The command line below shows an
example how to build for the hardware emulation:
</p>


```
$ hardcloud --build --target=emulation

$ export XCL_EMULATION_MODE=hw_emu
```

<p align="justify">
This command will create a  new path, called <i>output</i>. Inside the
directory,  the  binary file  will  be  available with  the  filename:
<i>PROJECT_NAME.xclbin</i>
</p>

<p align="justify">
In a  similar way, the following  command will generate the  binary to
the FPGA:
</p>

```
$ hardcloud --build --target=FPGA
```

<p align="justify">
Thus, move  the binary <i>output/PROJECT_NAME.xclbin</i> to  the place
where it will occurs the program execution.
</p>

### 2.1. The HardCloud Interface (HIF)

<p align="justify">
The HIF provides to the user  read or write operations. Each operation
has separated address and data phases.
</p>

The read operation encloses the subsequent functions:

* **bit read_addr(id,  offset, len)** : request a  read operation from
the buffer  _id_ and the base  address plus _offset_. The  _len_ gives
the possibility to  inquiry data request to  successive addresses. The
function returns a pulse when commit the operation.

* **bit read_data(data)** : the return bit gives a pulse when a _data_
is available.

* **void read_reset()**  : this functions deassert all  read valid and
ready signals.

The code demonstrates how to use the read functions:

```systemverilog
always_ff@(posedge clk) begin
  logic accept;

  logic [  7:0] len;
  logic [ 31:0] id;
  logic [ 31:0] offset;
  logic [511:0] data_out;

  /* others signals */

  // a simple finite state machine with only two states:
  // READ_ADDR and READ_DATA

  case (state)
    READ_ADDR: begin
      // try to request a read operation, address phase
      accept = buffer.read_addr(id, offset, len);

      // if the request was accepted, move to the next state
      if (accept)
        state <= READ_DATA;
      end

    READ_DATA: begin
      // try to read a data, data phase
      accept = buffer.read_data(data_out);

      // if accepted, decrement the lenght register
      if (accept) begin
        // TODO: use data_out

        len <= len - 1;
      end

      // move to the address phase if the condition is met
      if (accept && len == 1)
        state <= READ_ADDR;
    end
  endcase
end
```

The  write  operations  are  analogous  to  the  read,  the  functions
available are described hereafter:

* **bit write_addr(id, offset, len)**  : initiate a write operation to
the buffer  _id_ and the base  address plus _offset_. The  _len_ gives
the possibility to  inquiry data request to  successive addresses. The
function returns a pulse when commit the operation.

*  **bit write_data(data)**  : the  return bit  gives a  pulse when  a
_data_ is available.

* **void write_reset()** : this functions deassert all write valid and
ready signals.

An example below is provide to understand how a write operation works.

```systemverilog
always_ff@(posedge clk) begin
  logic accept;

  logic [  7:0] len;
  logic [ 31:0] id;
  logic [ 31:0] offset;
  logic [511:0] data;
  logic [511:0] next_data;

  /* others signals */

  // a simple finite state machine with only two states:
  // WRITE_ADDR and WRITE_DATA

  case (state)
    WRITE_ADDR: begin
      // try to initiate a write operation, address phase
      accept = buffer.write_addr(id, offset, len);

      if (accept)
        state <= WRITE_DATA;
    end

    WRITE_DATA: begin
      // try to read a data, data phase
      accept = buffer.write_data(data);

      // if accepted, decrement the lenght register
      if (accept) begin
        // TODO: update next_data

        data <= next_data;
        len  <= len - 1;
      end

      // move to the address phase if the condition is met
      if (accept && len == 1)
        state <= WRITE_ADDR;
    end
  endcase
end
```

## 3. How to create your software

<p align="justify">
The  project  path  provides  a software  template  in  the  directory
<i>sw</i>.  There  are two  files  inside  this  folder. The  first  -
<i>emconfig.json</i> -  contains the  emulation configuration  for the
platform that the project  uses. The second file, <i>src/main.cpp</i>,
is a loopback software example.
</p>

To  compile   this  code  inside   the  <i>sw</i>  path,   follow  the
instructions hereafter:

```
$ clang++ -std=c++11 -fopenmp -fopenmp-targets=alveo src/main.cpp -o main
```

### 3.1. Using OpenMP <i>parallel for</i> directive

```c
#pragma omp target device(ALVEO) implements(loopback) map(to: A) map(from: B)
#pragma omp parallel for
// Software version of the loopback hardware module.
for (int i = 0; i < NI; i++) {
    B[i] = A[i];
}
```

<p align="justify">
The   example  above   shows  the   syntax  that   was  adopted.   The
<b>map(:to)</b>  clause  indicates  the  data that  will  be  sent  to
the  accelerator,  while  the  <b>map(:from)</b>  indicates  the  data
that  will  be  received  from   the  accelerator  as  a  result.  The
clause <b>implements(loopback)</b>  specifies that the  annotated code
block  will  use  the  loopback   pre-designed  hardware,  to  do  the
computation  instead  of the  C  code  following the  annotation.  The
<b>device(ALVEO)</b>  clause  indicates  that the  execution  will  be
performed by the Xilinx Alveo U200 hardware emulator or the FPGA.
</p>

### 3.2. Using Multiple Variables

```c
#pragma omp target device(ALVEO) implements(kernel) map(to: A, B, C) map(from: D, E, F, G, H)
#pragma omp parallel for
for (int i = 0; i < NI; i++) {
    D[i] = A[i];
    E[i] = B[i];
    F[i] = C[i];
    G[i] = A[i] + B[i] + C[i];
    H[i] = A[i] * B[i] * C[i];
}
```

<p align="justify">
This example  shows the possibility  to work with  multiple variables.
The <b>map(:to)</b>, in this case, has three variables to be offloaded
to the  FPGA. Next,  the result  will be mapped  to five  variables as
specified in the <b>map(:from)</b>.
</p>

### 3.3. Using OpenMP <i>parallel</i> directive

```c
#pragma omp target device(ALVEO) implements(loopback) map(to: A) map(from: B)
#pragma omp parallel
{
    loopback(A, &B);
}
```
<p align="justify">
Another  feature of  HardCloud is  the use  of OpenMP  <i>parallel</i>
directive.  Instead of  a <i>for</i>  loop,  the block  of code  above
contains a call to a C  function that executes the loopback operation,
writing the values from variable A to B.
</p>

