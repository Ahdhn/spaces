# Spaces [![Windows](https://github.com/Ahdhn/spaces/actions/workflows/Windows.yml/badge.svg)](https://github.com/Ahdhn/spaces/actions/workflows/Windows.yml) [![Ubuntu](https://github.com/Ahdhn/spaces/actions/workflows/Ubuntu.yml/badge.svg?branch=master)](https://github.com/Ahdhn/spaces/actions/workflows/Ubuntu.yml)

The goal of this repo is to report a bug observed when there are spaces in the path of the source files of a CUDA library built/configured by CMake (using `add_library()`) on Windows. The code tries four different scenarios  

1. CUDA library _without_ spaces in the path (under `/no_space_cuda_lib`)
2. CUDA executable _with_ spaces in the path  (under `/s p a c e cuda exe`)
3. CPP library _with_ spaces in the path (under `/s p a c e s cpp lib`)
4. CUDA library _with_ spaces in the path (under `/s p a c e s cuda lib`)

All of these scenarios compile fine on GCC 9.4.0, CUDA 11.7 on Ubuntu (check out [Github Actions](https://github.com/Ahdhn/spaces/actions/workflows/Ubuntu.yml)) and Visual Studio 2019, CUDA 11.7 on Windows (check out [Github Actions](https://github.com/Ahdhn/spaces/actions/workflows/Windows.yml)) except for 4. where there are spaces in the path while the code is identical to 1.

The error message from Visual Studio is 

```
The command ""C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.7\bin\nvcc.exe" -gencode=arch=compute_86,code=\"compute_86,compute_86\" -gencode=arch=compute_86,code=\"sm_86,compute_86\" --use-local-env -ccbin "C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\VC\Tools\MSVC\14.28.29910\bin\HostX64\x64" -x cu   -I"E:\Github\spaces\s p a c e s cuda lib\include" -I"C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.7\include" -I"C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.3\include"     --keep-dir x64\Debug -use_fast_math -maxrregcount=0  --machine 64 --compile -cudart static -Xcudafe=--display_error_number -lineinfo --expt-extended-lambda --expt-relaxed-constexpr -Xptxas -warn-spills -res-usage --ptxas-options=-v -std=c++17 -Xcompiler="/EHsc -Zi -Ob0 /std:c++17" -g  -D_WINDOWS -D"CMAKE_INTDIR=\"Debug\"" -D"CMAKE_INTDIR=\"Debug\"" -D_MBCS -Xcompiler "/EHsc /W1 /nologo /Od /Fd"E:\Github\spaces\build\s p a c e s cuda lib\Debug\WithSpaceCUDALib.pdb" /FS /Zi /RTC1 /MDd /GR" -o WithSpaceCUDALib.dir\Debug\lib.obj "E:\Github\spaces\s p a c e s cuda lib\include\lib.cu""
```


Running the `nvcc` command from the command line, the error message is 
```
nvcc fatal   : A single input file is required for a non-link phase when an outputfile is specified
```

## Build 

```
mkdir build
cd build 
cmake ..
```

Depending on the system, this will generate either a `.sln` project on Windows or a `make` file for a Linux system. 
