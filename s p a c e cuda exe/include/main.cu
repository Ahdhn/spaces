#include <assert.h>
#include <cuda_runtime.h>
#include <stdio.h>

__global__ void exec_kernel()
{
    printf("\n I am thread %d from exec_kernel\n", threadIdx.x);
}

int main(int argc, char** argv)
{
    exec_kernel<<<1, 1>>>();
    cudaDeviceSynchronize();
}