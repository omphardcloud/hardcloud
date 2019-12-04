#include <iostream>

#include "hardcloud.h"

#define CL 64                 // cache line - bytes
#define NI 512*CL/sizeof(int) // number of itens

int main()
{
  int A[NI];
  int B[NI];

  std::cout << "[HardCloud] running : stub application\n\n";

  // initialize
  for (int i = 0; i < NI; i++)
  {
    A[i] = i;
  }

  std::cout << "[HardCloud] offload : stub HIP simulation\n\n";

  #pragma omp target device(ALVEO) implements(loopback) map(to: A) map(from: B)
  #pragma omp parallel for
  for (int i = 0; i < NI; i++)
  {
    B[i] = A[i];
  }

  std::cout << "[HardCloud] finish : stub application\n";

  return 0;
}

