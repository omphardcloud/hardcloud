#include <iostream>
#include <math.h>
#include "harp.h"
#include "image.h"

void sobel(
  unsigned int* image_in,
  unsigned int* image_out,
  unsigned int width,
  unsigned int height)
{
  int** frame;

  frame = new int*[width];

  for (int i = 0; i < width; i++)
  {
    frame[i] = new int[height];
  }

  unsigned int size = width*height;
  for (int i = 0; i < width; i++)
  {
    for (int j = 0; j < height; j++)
    {
      unsigned int r;
      unsigned int g;
      unsigned int b;
      unsigned int position;

      position = j*width + i;

      r = image_in[position] & 0xff;
      g = (image_in[position] >> 8) & 0xff;
      b = (image_in[position] >> 16) & 0xff;

      frame[i][j] = (((r*66 + g*129 + b*25) + 128) >> 8) + 16;
    }
  }

  // filter coefficients
  int Gx[3][3] = {{-1, -2, -1}, {0, 0, 0}, {1, 2, 1}};
  int Gy[3][3] = {{-1, 0, 1}, {-2, 0, 2}, {-1, 0, 1}};

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

      int x_dir = 0;
      int y_dir = 0;
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {

          if (!is_out_of_bounds) {
            x_dir += Gx[i][j]*(frame[y - 1 + i][x - 1 + j]);
            y_dir += Gy[i][j]*(frame[y - 1 + i][x - 1 + j]);
          }
        }
      }

      unsigned int value;
      value = sqrt(pow(x_dir, 2) + pow(y_dir, 2));

      unsigned int position = x*width + y;
      image_out[position] =
        (value & 0xff) |
        (value & 0xff) << 8 |
        (value & 0xff) << 16;
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
  #pragma omp parallel use(hrw) module(sobel)
  {
    image_out[0] = image_in[0];

    sobel(image_in, image_out, height, width);
  }

  image.map_back();

  image.write_png_file(file_output);

  return 0;
}

