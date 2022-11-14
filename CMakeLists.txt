#CMake minimum requirement 
cmake_minimum_required(VERSION 3.19 FATAL_ERROR)

#Project name 
set(project_name "Spaces")
project(${project_name} LANGUAGES CXX C CUDA)  

#toggle between building a shared or static library
option(MY_BUILD_SHARED_LIBS "Build as shared library" OFF)

#default build type is Release
if (CMAKE_BUILD_TYPE STREQUAL "")
    set(CMAKE_BUILD_TYPE Release)
endif ()

# Direct all output to /bin directory
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/bin)


# Auto-detect GPU architecture
include("cmake/AutoDetectCudaArch.cmake")

# CUDA and C++ compiler flags
set(cxx_flags 
	$<$<CXX_COMPILER_ID:MSVC>:-D_SCL_SECURE_NO_WARNINGS /openmp /std:c++17> #<TODO> Add MSVC-specific compiler flags here
	$<$<CXX_COMPILER_ID:GNU>:-Wall -m64 -fopenmp -O3 -std=c++17>            #<TODO> Add GCC compiler flags here
	$<$<CXX_COMPILER_ID:Clang>:-Wall -m64 -fopenmp -O3 -std=c++17>          #<TODO> Add Clang compiler flags here
	)

set(cuda_flags
    $<$<CXX_COMPILER_ID:GNU>:-Xcompiler -Wall -fopenmp -O3>
	$<$<CXX_COMPILER_ID:Clang>:-Xcompiler -Wall -fopenmp -O3>
	$<$<CXX_COMPILER_ID:MSVC>:-Xcompiler /std:c++17>
    -Xcudafe=--display_error_number    
	-lineinfo	
	--expt-extended-lambda	
	-use_fast_math		
    $<$<CXX_COMPILER_ID:GNU>:-O3>	
	--expt-relaxed-constexpr	
    -Xptxas -warn-spills -res-usage   
	--ptxas-options=-v	
    #-G	
)
add_library(developer_flags INTERFACE)
target_compile_options(developer_flags INTERFACE
    $<$<COMPILE_LANGUAGE:CXX>:${cxx_flags}>
    $<$<COMPILE_LANGUAGE:CUDA>:${cuda_flags}>
)
target_include_directories(developer_flags INTERFACE ${CMAKE_CUDA_TOOLKIT_INCLUDE_DIRECTORIES})

target_compile_features(developer_flags INTERFACE cxx_std_17)


add_subdirectory("s p a c e cuda exe")
add_subdirectory("s p a c e s cpp lib")
add_subdirectory("s p a c e s cuda lib")
add_subdirectory("no_space_cuda_lib")