#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include "image.h"
#include <omp.h>
#define TRLOW 0
#define TGLOW 0
#define TBLOW 150
#define TRHIGH 100
#define TGHIGH 100
#define TBHIGH 254
#define N  10

int main()
{
  std::string file_input("land.png");
  std::string file_output("output.png");

  Image image(file_input);

  unsigned int size = image.height*image.width;
  unsigned int x = image.width;
  unsigned int y = image.height;
  unsigned int acx=1, acy=1, tx=1, ty=1, avgx, avgy;
  unsigned int* image_in  = image.array_in;
  unsigned int* image_out = image.array_out;
  unsigned int* band_to_cent = (unsigned int*)malloc(sizeof(unsigned int)*size);
  printf("Execute Bandpass SIZE = %d\n", size);
    #pragma omp parallel 
  {
  {
	#pragma omp target teams distribute parallel for map(to:image_in[:size]) map(from:band_to_cent[:size]) depend(out: band_to_cent[:size])
	  for(int i = 0; i < size; i++){
	  	unsigned r, g, b, gray, tr, tg, tb;
	
		r = image_in[i] & 0xff;
		g = (image_in[i] >> 8) & 0xff;
		b = (image_in[i] >> 16) & 0xff;

		tr = (r > TRLOW) && (r < TRHIGH);
		tg = (g > TGLOW) && (g < TGHIGH);
		tb = (b > TBLOW) && (b < TBHIGH);

		if(tr && tg && tb){
			band_to_cent[i] = 0xffffff;
		}
		else{
			band_to_cent[i] = 0;
		}
	  }
  }
  }
  int scan;

  printf("Execute centroid x=%d, y=%d\n", x, y);
#pragma omp target teams distribute parallel for collapse(2) map(tofrom:band_to_cent[:size], acx, acy, tx, ty)
  for(int i = 0; i < y; i++){
	  for(int j = 0; j < x; j++){	
		  if(band_to_cent[i*x+j] == 0xffffff){
		  	acx+=j;
			acy+=i;
			tx++;
			ty++;
		  }
	   
	  }
  }
  printf("acx=%u, acy=%u, tx=%u, ty=%u", acx, acy, tx, ty);
  avgx  = acx/tx;
  avgy  = acy/ty;

  //crosshair

  printf("crosshair\n");
 #pragma omp target teams distribute parallel for collapse(2) map(to:image_in[:size], avgx, avgy) map(from:image_out[:size])
  for(int i = 0; i < y; i++){
	  for(int j = 0; j < x; j++){
		  if(((i <= avgy + 10) && (i > avgy - 10)) || ((j <= avgx + 10) && (j > avgx - 10) )){
			  image_out[i*x+j] = 0xffffff;
		  }else{
			  image_out[i*x+j] = image_in[i*x+j];
		  }
	  
	  }
  
  }

  
  image.map_back();

  image.write_png_file(file_output);
  std::cout << "Done" << "\n";
  return 0;
}

