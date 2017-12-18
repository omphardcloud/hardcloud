#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

#include "harp.h"

#define CL 64 // cache line - bytes

#define SIZE 20000000*CL/sizeof(uint8_t) // number of itens

#define FIR_TAPS 40

void fir_filter(uint8_t *data_in, uint8_t *data_out, uint64_t size)
{
  float coeff[FIR_TAPS];
  uint8_t data[FIR_TAPS];

  coeff[ 0] =  0.023;
  coeff[ 1] =  0.003;
  coeff[ 2] = -0.023;
  coeff[ 3] = -0.007;
  coeff[ 4] =  0.023;
  coeff[ 5] =  0.011;
  coeff[ 6] = -0.023;
  coeff[ 7] = -0.016;
  coeff[ 8] =  0.023;
  coeff[ 9] =  0.022;
  coeff[10] = -0.023;
  coeff[11] = -0.029;
  coeff[12] =  0.023;
  coeff[13] =  0.041;
  coeff[14] = -0.023;
  coeff[15] = -0.060;
  coeff[16] =  0.023;
  coeff[17] =  0.104;
  coeff[18] = -0.023;
  coeff[19] = -0.317;
  coeff[20] =  0.523;
  coeff[21] = -0.317;
  coeff[22] = -0.023;
  coeff[23] =  0.104;
  coeff[24] =  0.023;
  coeff[25] = -0.060;
  coeff[26] = -0.023;
  coeff[27] =  0.041;
  coeff[28] =  0.023;
  coeff[29] = -0.029;
  coeff[30] = -0.023;
  coeff[31] =  0.022;
  coeff[32] =  0.023;
  coeff[33] = -0.016;
  coeff[34] = -0.023;
  coeff[35] =  0.011;
  coeff[36] =  0.023;
  coeff[37] = -0.007;
  coeff[38] = -0.023;
  coeff[39] =  0.003;

  for (uint64_t i = 0; i < FIR_TAPS; i++)
  {
    data[i] = 0;
  }

  for (uint64_t i = 0; i < size; i++)
  {
    for (uint64_t j = FIR_TAPS; j != 1; j--)
    {
      data[j - 1] = data[j - 2];
    }

    data[0] = data_in[i];

    data_out[i] = 0;

    for (uint64_t j = 0; j < FIR_TAPS; j++)
    {
      data_out[i] += data[j]*coeff[j];
    }
  }
}

int main()
{
  uint8_t* data_in;
  uint8_t* data_out;

  data_in  = (uint8_t *) malloc (SIZE*sizeof(uint8_t));
  data_out = (uint8_t *) malloc (SIZE*sizeof(uint8_t));

  for (uint64_t i = 0; i < SIZE; i++)
  {
    data_in[i] = rand();
  }

  #pragma omp target device(HARPSIM) map(to: data_in[:SIZE]) map(from: data_out[:SIZE])
  #pragma omp parallel use(hrw) module(fir)
  {
    data_out[0] = data_in[0];

    fir_filter(data_in, data_out, SIZE);
  }

#ifdef DEBUG
  for (uint64_t i = 0; i < SIZE; i ++)
  {
    printf("data_out[%lu] = %02x\n", i, data_out[i]);
  }

  printf("\n");
#endif // DEBUG

  free(data_in);
  free(data_out);

  return 0;
}

