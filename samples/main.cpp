#include <iostream>
#include "awsf1.h"
#include "image.h"
#define CUDA 0

void grayscale(
  unsigned int* image_in,
  unsigned int* image_out,
  unsigned int size)
{
  for (int i = 0; i < size; i++)
  {
    unsigned int r, g, b, gray;

    r = image_in[i] & 0xff;
    g = (image_in[i] >> 8) & 0xff;
    b = (image_in[i] >> 16) & 0xff;

    gray = (((r*66 + g*129 + b*25) + 128) >> 8) + 16;

    image_out[i]  = (gray & 0xff) | (gray & 0xff) << 8 | (gray & 0xff) << 16;
  }
}

int main()
{
  std::string file_input("input.png");
  std::string file_output("output.png");
  std::string file_gaussian("gaussian.png");
  

  Image image(file_input);

  unsigned int size = image.height*image.width;

  unsigned int* image_in  = image.array_in;
  unsigned int* image_out = image.array_out;
  int height = image.height;
  int width = image.width;
  float G[3][3] =
  {{1.0/16, 1.0/8, 1.0/16},
  {1.0/8, 1.0/4, 1.0/8},
  {1.0/16, 1.0/8, 1.0/16}};


  #pragma omp target device(CUDA) map(to:image_in[:size]) map(from: image_out[:size])
  #pragma omp parallel for
   for (int x = 0; x < height; x++)
  {
    for (int y = 0; y < width; y++)
    {
      bool is_out_of_bounds = false;
      if ((x == 0) |
          (y == 0) |
          (x == width - 1) |
          (y == height - 1)) {
        is_out_of_bounds = true;
      }

      int r = 0;
      int g = 0;
      int b = 0;
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {

          if (!is_out_of_bounds) {
            unsigned int position = (x - 1 + j)*width + (y - 1 + i);

            r += G[i][j]*(image_in[position] & 0xff);
            g += G[i][j]*((image_in[position] >>  8) & 0xff);
            b += G[i][j]*((image_in[position] >> 16) & 0xff);
          }
        }
      }

      image_out[x*width + y] =
        (r & 0xff) |
        (g & 0xff) << 8 |
        (b & 0xff) << 16;
    }
  }


  image.map_back();
  image.write_png_file(file_gaussian); 
  
  Image image2(file_gaussian);

  size = image2.height*image2.width;

  image_in  = image2.array_in;
  image_out = image2.array_out;


  #pragma omp target device(AWSF1) map(to: image_in[:size]) map(from: image_out[:size])
  #pragma omp parallel for use(hrw) module(image_1) 
    for (int i = 0; i < size; i++)
  {
    image_out[0] = image_in[0];
    unsigned int r, g, b, gray;

    r = image_in[i] & 0xff;
    g = (image_in[i] >> 8) & 0xff;
    b = (image_in[i] >> 16) & 0xff;

    gray = (((r*66 + g*129 + b*25) + 128) >> 8) + 16;

    image_out[i]  = (gray & 0xff) | (gray & 0xff) << 8 | (gray & 0xff) << 16;
  }


  image2.map_back();

  image2.write_png_file(file_output);

  return 0;
}

