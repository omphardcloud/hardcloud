#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

#include "harp.h"

#define CL 64 // cache line - bytes

#define NI 52*CL/sizeof(uint32_t) // number of itens
#define NJ 47*CL/sizeof(uint32_t) // number of itens

int main()
{
  uint32_t* data_in;
  uint32_t* data_out;

  data_in  = (uint32_t *) malloc (NI*sizeof(uint32_t));
  data_out = (uint32_t *) malloc (NJ*sizeof(uint32_t));

  for (uint32_t i = 0; i < NI; i++)
  {
    data_in[i] = rand();
  }

  #pragma omp target device(HARPSIM) map(to: data_in[:NI]) map(from: data_out[:NJ])
  #pragma omp parallel use(hrw) module(reed_solomon_decoder)
  {
    data_out[0] = data_in[0];
  }

  for (uint32_t i = 0; i < NJ; i ++)
  {
    printf("data_out[%u] = %08x\n", i, data_out[i]);
  }

  printf("\n");

  free(data_in);
  free(data_out);

  return 0;
}

