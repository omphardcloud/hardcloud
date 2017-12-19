// smith_waterman.cpp

/*
 *  Created on: 6 de dez de 2017
 *  Author: ramon
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

#include "smith_waterman.h"

#define A 0
#define G 1
#define C 3
#define T 2
#define GEXT 4
#define GOPEN 12

int max (int a, int b, int c, int d)
{
  int bigger;

  if (a > b)
    bigger = a;
  else
    bigger = b;

  if (bigger < c) bigger = c;

  if (bigger < d) bigger = d;

  if (bigger > 0) return bigger;

  return 0;
}

int s (int a, int b)
{
  if (a == b) return 5;

  return -4;
}

uint32_t smith_waterman(uint8_t *a, uint8_t *b, int m, int n)
{
  int **M;
  int **I;

  M = (int**)malloc((m + 1)*sizeof(int*));

  if (M == 0)
  {
    printf("ERROR: memory allocation\n");
    return 1;
  }

  for (int i = 0; i < m + 1; i++)
  {
    M[i] = (int*)malloc((QUERY_LENGTH+1)*sizeof(int));

    if (M[i] == 0)
    {
      printf("ERROR: memory allocation\n");
      return 1;
    }
  }


  I = (int**)malloc((m + 1)*sizeof(int*));
  if (I == 0)
  {
    printf("ERROR: memory allocation\n");
    return 1;
  }

  for (int i = 0; i < m + 1; i++)
  {
    I[i] = (int*)malloc((QUERY_LENGTH+1)*sizeof(int));
    if (I[i] == 0)
    {
      printf("ERROR: memory allocation\n");
      return 1;
    }
  }

  uint32_t biggest = 0;

  for (int i = 0; i < n+1; ++i)
  {
    M[0][i] = -0;
    I[0][i] = -0;
  }

  for (int i = 0; i < m+1; ++i)
  {
    M[i][0] = -0;
    I[i][0] = -0;
  }

  for (int i = 1; i < m+1; ++i)
  {
    for (int j = 1; j < n+1; ++j)
    {
      M[i][j] = max((M[i-1][j-1]+s(a[i-1],b[j-1])), (I[i-1][j-1]+s(a[i-1],b[j-1])), 0, 0);
      I[i][j] = max((M[i][j-1]-GOPEN), (I[i][j-1]-GEXT), (M[i-1][j]-GOPEN), (I[i-1][j]-GEXT));

      if (biggest < M[i][j]) biggest = M[i][j];
    }
  }

  return biggest;
}

