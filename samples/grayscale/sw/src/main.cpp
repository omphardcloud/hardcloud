#include <iostream>
#include "harp.h"
#include "image.h"

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

  Image image(file_input);

  unsigned int size = image.height*image.width;

  unsigned int* image_in  = image.array_in;
  unsigned int* image_out = image.array_out;

  #pragma omp target device(HARPSIM) map(to: image_in[:size]) map(from: image_out[:size])
  #pragma omp parallel use(hrw) module(grayscale)
  {
    image_out[0] = image_in[0];

    grayscale(image_in, image_out, size);
  }

  image.map_back();

  image.write_png_file(file_output);

  return 0;
}

