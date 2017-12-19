#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

#include "harp.h"
#include "smith_waterman.h"

#define CL 64 // cache line - bytes

#define NI 1000000*CL/sizeof(uint8_t) // number of itens
#define NJ 1*CL/sizeof(uint8_t) // number of itens

int main()
{
  uint8_t* data_in;
  uint8_t* data_out;

  data_in  = (uint8_t *) malloc (NI*sizeof(uint8_t));
  data_out = (uint8_t *) malloc (NJ*sizeof(uint8_t));

  for (uint64_t i = 0; i < NI; i++)
  {
    // data_in[i] = rand()%4;
    data_in[i] = i%4;
  }

  #pragma omp target device(HARPSIM) map(to: data_in[:NI]) map(from: data_out[:NJ])
  #pragma omp parallel use(hrw) module(smith_waterman)
  {
    uint8_t* vet_query;

    data_out[0] = data_in[0];

    vet_query = (uint8_t *)malloc(QUERY_LENGTH*sizeof(uint8_t));

    for(int i = 0; i < QUERY_LENGTH; i++){
      vet_query[i] = 0;
    }

    data_out[0] = smith_waterman(data_in, vet_query, NI, QUERY_LENGTH);

    free(vet_query);
  }

  printf("data_out = %d\n", data_out[0]);

  free(data_in);
  free(data_out);

  return 0;
}

