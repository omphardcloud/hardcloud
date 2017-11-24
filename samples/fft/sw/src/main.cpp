#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <math.h>

#include "harp.h"

#define CL 64 // cache line - bytes

#define NUM_WORDS 20*CL/sizeof(float) // number of itens

#define q 4         // for 2^q points
#define N (1<<q)    // N-point FFT, iFFT

#ifndef PI
# define PI 3.14159265358979323846264338327950288
#endif

typedef float real;

typedef struct
{
  real Re;
  real Im;
} complex;

void fft(complex *v, int n, complex *tmp)
{
  if (n > 1)
  {
    int k;
    int m;

    complex z;
    complex w;
    complex *vo;
    complex *ve;

    ve = tmp;
    vo = tmp+n/2;

    for (k = 0; k < n/2; k++)
    {
      ve[k] = v[2*k];
      vo[k] = v[2*k+1];
    }

    fft(ve, n/2, v); // FFT on even-indexed elements of v[]
    fft(vo, n/2, v); // FFT on  odd-indexed elements of v[]

    for(m=0; m<n/2; m++)
    {
      w.Re =  cos(2*PI*m/(double)n);
      w.Im = -sin(2*PI*m/(double)n);

      z.Re = w.Re*vo[m].Re - w.Im*vo[m].Im;
      z.Im = w.Re*vo[m].Im + w.Im*vo[m].Re;

      v[m].Re = ve[m].Re + z.Re;
      v[m].Im = ve[m].Im + z.Im;

      v[m+n/2].Re = ve[m].Re - z.Re;
      v[m+n/2].Im = ve[m].Im - z.Im;
    }
  }

  return;
}

int main()
{
  float input[NUM_WORDS];
  float output[NUM_WORDS];

  printf("N = %d\n", N);

  for (int k=0; k < NUM_WORDS/2; k++)
  {
    input[2*k    ] = k;     // 0.125*cos(2*PI*k/(double)N);
    input[2*k + 1] = k + 1; // 0.125*sin(2*PI*k/(double)N);
  }

  for (int i = 0; i < NUM_WORDS/2; i++)
  {
    printf("input [%02d] = %5.2f | %5.2f\n", i, input[2*i], input[2*i + 1]);
  }

  printf("\n");

  #pragma omp target device(HARPSIM) map(to: input) map(from: output)
  #pragma omp parallel for use(hrw) module(fft)
  for (int i = 0; i < NUM_WORDS/(2*N); i++)
  {
    output[0] = input[0];

    fft(
      (complex*) input + 2*sizeof(float)*i,
      N,
      (complex*) output + 2*sizeof(float)*i);
  }

  for (int i = 0; i < NUM_WORDS/2; i++)
  {
    printf("output[%02d] = %5.2f | %5.2f\n", i, output[2*i], output[2*i + 1]);
  }

  return 0;
}

