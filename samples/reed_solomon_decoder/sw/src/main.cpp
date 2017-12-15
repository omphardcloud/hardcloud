#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

#include "harp.h"
#include "rs.h"

#define CL 64 // cache line - bytes

#ifdef DEBUG
  #define NI 52*CL/sizeof(uint8_t) // number of itens
  #define NJ 47*CL/sizeof(uint8_t) // number of itens
#else
  #define NI 20400000*CL/sizeof(uint8_t) // number of itens
  #define NJ 18800000*CL/sizeof(uint8_t) // number of itens
#endif // DEBUG

int main()
{
  uint8_t* data_in;
  uint8_t* data_out;

  data_in  = (uint8_t *) malloc (NI*sizeof(uint8_t));
  data_out = (uint8_t *) malloc (NJ*sizeof(uint8_t));

  for (uint64_t i = 0; i < NI; i++)
  {
    data_in[i] = rand();
  }

  #pragma omp target device(HARPSIM) map(to: data_in[:NI]) map(from: data_out[:NJ])
  #pragma omp parallel for use(hrw) module(reed_solomon_decoder)
  for (uint64_t i = 0; i < NI/204; i++)
  {
    data_out[i*188] = data_in[i*204];

    rsdec_204((unsigned char*) data_out + i*188, (unsigned char*) data_in + i*204);
  }

#ifdef DEBUG
  for (uint64_t i = 0; i < NJ; i ++)
  {
    printf("data_out[%u] = %02x\n", i, data_out[i]);
  }

  printf("\n");
#endif // DEBUG

  free(data_in);
  free(data_out);

  return 0;
}

