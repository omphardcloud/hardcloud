#include <iostream>
#include "harp.h"

#define CL 64             // cache line bytes
#define NI 1*CL/sizeof(int) // number of elements

int main()
{
  int results[NI];

  #pragma omp target device(HARPSIM) map(from: results)
  #pragma omp parallel for use(hrw) module(grn)
  for (int i = 0; i < NI; i++)
  {
    results[i] = i;
  }

  for (int i = 0; i < NI; i++)
  {
    std::cout << results[i] << "\n";
  }

  return 0;
}

