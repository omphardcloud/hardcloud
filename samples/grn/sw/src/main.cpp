#include <stdlib.h>
#include <stdio.h>
#include <cmath>

#include "harp.h"

#define SIZE 69
#define STATES 10000000
#define OUT_SIZE 2*STATES

void int_to_bin(unsigned int in, int count, int* out)
{
  for (int i = 0; i < 32; ++i)
  {
      out[i] = (in >> i) & 1;
  }

  for (int i = 32; i < count; ++i)
  {
    out[i] = 0;
  }
}

int bin_to_int(int* in, int count)
{
  int acc = 0;

  for (int i = 0; i < count; i++)
  {
    acc = acc + pow(2, i)*in[i];
  }

  return acc;
}

void transition(int* V)
{
  int Vtemp[SIZE];

  Vtemp[0] = V[40];
  Vtemp[1] = V[40] && ! V[32];
  Vtemp[2] = V[35] && ! (V[36] || V[6]);
  Vtemp[3] = ((V[50] || V[33]) && V[36]) && ! V[2];
  Vtemp[4] = ! (V[20] && 0);
  Vtemp[5] = (V[48] || V[31]) && ! (V[33] || V[36]);
  Vtemp[6] = (V[7] || V[8]) && ! V[21];
  Vtemp[7] = V[17] && ! (V[10] || V[32]);
  Vtemp[8] = V[13] && ! (V[21] || V[32]);
  Vtemp[9] = V[46] && ! V[47];
  Vtemp[10] = V[31];
  Vtemp[11] = V[42] && V[52];
  Vtemp[12] = (V[4] || V[48] || V[26]) && ! V[20];
  Vtemp[13] = V[30];
  Vtemp[14] = V[34];
  Vtemp[15] = V[28];
  Vtemp[16] = V[64];
  Vtemp[17] = V[52] || V[16];
  Vtemp[18] = V[15];
  Vtemp[19] = V[59];
  Vtemp[20] = ! (V[14] || V[2]);
  Vtemp[21] = (V[31] || V[48]) && ! V[43];
  Vtemp[22] = ! V[23];
  Vtemp[23] = (V[2] || (V[42] && V[52]));
  Vtemp[24] = V[19] && ! V[49];
  Vtemp[25] = V[1] || V[29];
  Vtemp[26] = ((V[4] || V[15]) && V[25]) && ! V[20];
  Vtemp[27] = (V[33] && V[2]) && ! (V[20] || V[0]);
  Vtemp[28] = V[38] || V[40];
  Vtemp[29] = V[9] || V[51] || V[52];
  Vtemp[30] = (V[3] || V[50] || V[9]) && ! V[5];
  Vtemp[31] = ! V[22];
  Vtemp[32] = (V[33] || V[44]) && ! (V[20] || V[6]);
  Vtemp[33] = (V[37] || V[25] || V[0]) && ! V[27];
  Vtemp[34] = V[11];
  Vtemp[35] = (V[14] || V[39]) && ! V[37];
  Vtemp[36] = V[9] && ! V[2];
  Vtemp[37] = V[33] && ! (V[31] || V[26]);
  Vtemp[38] = V[9] || V[39];
  Vtemp[39] = V[14] || V[19];
  Vtemp[40] = V[52] && ! V[41];
  Vtemp[41] = V[31] || V[48];
  Vtemp[42] = V[47];
  Vtemp[43] = V[30];
  Vtemp[44] = V[51] && ! V[26];
  Vtemp[45] = V[44] || V[31];
  Vtemp[46] = V[33] || V[17];
  Vtemp[47] = V[15] || V[52];
  Vtemp[48] = V[24];
  Vtemp[49] = V[48];
  Vtemp[50] = V[7] && ! V[5];
  Vtemp[51] = V[57] && ! V[45];
  Vtemp[52] = V[54];
  Vtemp[53] = (V[62] || V[65]) && ! V[59];
  Vtemp[54] = V[58];
  Vtemp[55] = V[60] && ! (V[63] || V[57]);
  Vtemp[56] = (V[61] || V[63]) && ! (V[62] || V[57] || V[60]);
  Vtemp[57] = V[53];
  Vtemp[58] = (V[63] || V[66]) && ! V[62];
  Vtemp[59] = V[58] || V[65] || V[31];
  Vtemp[60] = V[65] || V[55];
  Vtemp[61] = V[65] || V[58];
  Vtemp[62] = V[53] || V[55];
  Vtemp[63] = V[56] || V[64];
  Vtemp[64] = V[63] && ! V[57];
  Vtemp[65] = (V[66] || V[54]) && ! V[62];
  Vtemp[66] = V[31];
  Vtemp[67] = (V[18] && V[12]) && ! (V[32] || V[6]);
  Vtemp[68] = V[6];

  for (int i = 0; i < SIZE; i++)
  {
    V[i] = Vtemp[i];
  }
}

int compare(int* v1, int* v2)
{
  for (int i = 0; i<SIZE; i++)
  {
    if (v1[i] != v2[i])
      return 0;
  }

  return 1;
}

int main()
{
  int *results;

  results = (int *) malloc (sizeof(int)*OUT_SIZE);

  #pragma omp target device(HARPSIM) map(from: results[:OUT_SIZE])
  #pragma omp parallel for use(hrw) module(grn)
  for (int i = 0; i < STATES; i++)
  {
    int V1[SIZE];
    int V2[SIZE];
    int transition_count;
    int temp;

    int_to_bin(i, SIZE, V1);
    int_to_bin(i, SIZE, V2);

    transition_count = 0;

    while (1)
    {
      transition(V2);
      transition(V2);
      transition(V1);

      transition_count++;

      if (compare(V1,V2))
        break;
    }

    results[2*i] = transition_count;
    temp = 0;

    do
    {
      transition(V1);
      temp++;
    } while (!compare(V1, V2));

    results[2*i + 1] = temp;
  }

#ifdef DEBUG
  for (int i = 0; i < STATES; i++)
  {
    std::cout << results[2*i] << "\n";
  }
#endif // DEBUG

  return 0;
}
