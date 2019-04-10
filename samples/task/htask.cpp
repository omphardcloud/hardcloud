#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include "image.h"
#define TRLOW 0
#define TGLOW 0
#define TBLOW 150
#define TRHIGH 100
#define TGHIGH 100
#define TBHIGH 254


int main()
{
  std::string file_input("land.png");
  std::string file_output("output.png");

  Image image(file_input);

  unsigned int size = image.height*image.width;
  unsigned int x = image.width;
  unsigned int y = image.height;
  unsigned int* image_in  = image.array_in;
  unsigned int* image_out = image.array_out;
  unsigned int* band_to_cent = (unsigned int*)malloc(sizeof(unsigned int)*size);
  printf("Execute Bandpass SIZE = %d\n", size);

  // Bandpass Threshold
  {
//          #pragma omp target  map(to:image_in[:size]) map(from:band_to_cent[:size]) teams distribute
	#pragma omp target teams distribute parallel for map(to:image_in[:size]) map(from:band_to_cent[:size])
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

  int scan;

  printf("Execute centroid x=%d, y=%d\n", x, y);
  // centroid
  unsigned int acx = 1, acy = 1, tx=1, ty=1;
#pragma omp target teams distribute parallel for collapse(2) map(tofrom:band_to_cent[:size]) map(from:acx,acy,tx,ty)
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
  int avgx  = acx/tx;
  int avgy  = acy/ty;

  //crosshair

  printf("crosshair\n");
 #pragma omp target teams distribute parallel for collapse(2) map(to:image_in[:size]) map(from:image_out[:size])
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

