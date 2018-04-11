# HardCloud - Intel HARP2 as an OpenMP Offloading Device.

<p align="justify">
The computing industry has recently proposed the use of FPGAs as a way to improve performance and energy efficiency in modern cloud clusters. Unfortunately, using such FPGA clusters is a very hard and complex task. In this context, we present HardCloud a novel and simple mechanism to offload computation to the FPGAs available in the Intel HARP2 platform. HardCloud extends OpenMP directives in such a way that the FPGA becomes just another OpenMP acceleration device that can be used directly from any user program. The example below shows a simple use of the syntax that was adopted.
</p>

```c
#pragma omp target device(HARPSIM) map(to: A) map(from: B)
#pragma omp parallel for use(hrw) module(loopback)
// Code that represents the loopback bitstream
for (int i = 0; i < NI; i++) {
    B[i] = A[i];
}
```

## Documentation, Installation, and Configuration

All the information is provided in the [Wiki](https://github.com/ciroceissler/hardcloud/wiki).
