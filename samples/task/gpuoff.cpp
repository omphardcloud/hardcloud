#include<stdio.h>
#include<stdlib.h>
#define HEIGHT 100
#define WIDTH 100


int main(){
	int num_blocks = 1000;
	int block_size = 10;
	int *image;
	image = (int*)malloc(sizeof(int)*HEIGHT*WIDTH);

	#pragma omp target data map(alloc:image[0:WIDTH*HEIGHT])
	for(int block = 0; block < num_blocks; block++){
		int start = block *(HEIGHT/num_blocks), end = start + (HEIGHT/num_blocks);
		#pragma omp target teams distribute parallel for simd collapse(2)\
	       	depend(inout:image[block*block_size]) nowait
		for(int y=start;y<end;y++){
			for(int x=0;x<WIDTH;x++){
				image[y*WIDTH+x]=x+y;
			}
		}

		#pragma omp target update from(image[block*block_size:block_size]) \
		depend(inout:image[block*block_size]) nowait
	
	
	}

	#pragma omp taskwait
/*
	for(int j = 1; j < n-1; j++){
		for(int i = 1; i < m-1; i+++){
			Anew[j][i] = 0.25 * (A[j][i+1] + A[j][i-1] + A[j-1][i] + A[j+1][i]);
			error = fmax(error, fbas(Anew[j][i] - A[j][i]));
		}
	}
	*/
}
