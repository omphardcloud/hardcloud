#include <stdio.h>
#include "harp.h"

#define CL 64               // cache line bytes
#define NI 12*CL/sizeof(int) // number of elements

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
    printf("%d ", results[i]);
  }
  printf("\n");

  return 0;
}

