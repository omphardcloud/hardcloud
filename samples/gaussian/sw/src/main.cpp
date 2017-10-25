#include <iostream>
#include <math.h>
#include "harp.h"
#include "image.h"

void gaussian(
  unsigned int* image_in,
  unsigned int* image_out,
  unsigned int width,
  unsigned int height)
{
  // filter coefficients
  float G[3][3] =
    {{1.0/16, 1.0/8, 1.0/16},
    {1.0/8, 1.0/4, 1.0/8},
    {1.0/16, 1.0/8, 1.0/16}};

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
}

int main()
{
  std::string file_input("input.png");
  std::string file_output("output.png");

  Image image(file_input);

  unsigned int size   = image.height*image.width;
  unsigned int height = image.height;
  unsigned int width  = image.width;

  unsigned int* image_in  = image.array_in;
  unsigned int* image_out = image.array_out;

  #pragma omp target device(HARPSIM) map(to: image_in[:size]) map(from: image_out[:size])
  #pragma omp parallel use(hrw) module(gaussian)
  {
    image_out[0] = image_in[0];

    gaussian(image_in, image_out, height, width);
  }

  image.map_back();

  image.write_png_file(file_output);

  return 0;
}

