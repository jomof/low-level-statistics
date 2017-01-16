#!/bin/bash
# cmakeify installs and runs CMake with different configurations

CMAKEIFY_CMAKE_VERSION=cmake-3.7.20161217-g65aad

CMAKE_C_COMPILER=/usr/bin/cc
CMAKE_CXX_COMPILER=/usr/bin/c++

# install a CMake 
mkdir prebuilts/
if [[ "$(uname -s)" == 'Darwin' ]]; then
  wget --no-check-certificate https://cmake.org/files/dev/${CMAKEIFY_CMAKE_VERSION}-Darwin-x86_64.tar.gz -O cmake.tar.gz
  tar xvfz cmake.tar.gz -C prebuilts/ > untar.cmake.txt
  mv prebuilts/${CMAKEIFY_CMAKE_VERSION}-Darwin-x86_64/CMake.app prebuilts/cmake
else
  wget --no-check-certificate https://cmake.org/files/dev/${CMAKEIFY_CMAKE_VERSION}-Linux-x86_64.tar.gz -O cmake.tar.gz
  tar xvfz cmake.tar.gz -C prebuilts/ > untar.cmake.txt
  mv prebuilts/${CMAKEIFY_CMAKE_VERSION}-Linux-x86_64 prebuilts/cmake
fi
prebuilts/cmake/bin/cmake --version

# install compiler prereqs
case "$CMAKE_SYSTEM_NAME" in
Windows)
  case "$CMAKEIFY_GCC" in
  4.9.0)
    mkdir prebuilts/mingw-w64
    wget https://github.com/jomof/cmakeify/releases/download/mingw-w64/mingw-w64-bin_x86_64-linux_20131228.tar.bz2 -O mingw-w64.tar.bz2
    tar xvfj mingw-w64.tar.bz2 -C prebuilts/mingw-w64 > untar.mingw-w64.txt
    CMAKE_CXX_COMPILER=$PWD/prebuilts/mingw-w64/bin/x86_64-w64-mingw32-g++
    CMAKE_C_COMPILER=$PWD/prebuilts/mingw-w64/bin/x86_64-w64-mingw32-gcc
    ;;
  *)
    echo $"GCC version CMAKEIFY_GCC=$CMAKEIFY_GCC is not supported. Use 4.9.0"
    exit 1
  esac
  ;;
Linux)
  wget http://mirrors-usa.go-parts.com/gcc/releases/gcc-${CMAKEIFY_GCC}/gcc-${CMAKEIFY_GCC}.tar.bz2 -O gcc.tar.bz2
  tar xvfj gcc.tar.bz2 -C prebuilts/ > untar.gcc.txt
  CMAKE_CXX_COMPILER=$PWD/prebuilts/gcc-${CMAKEIFY_GCC}/bin/g++
  CMAKE_C_COMPILER=$PWD/prebuilts/gcc-${CMAKEIFY_GCC}/bin/gcc
  ;;
esac

echo Prebuilts
ls prebuilts/
$CMAKE_CXX_COMPILER --version


# build
mkdir build/
cd build
../prebuilts/cmake/bin/cmake .. \
 -DCMAKE_ARCHIVE_OUTPUT_DIRECTORY=bin \
 -DCMAKE_LIBRARY_OUTPUT_DIRECTORY=bin \
 -DCMAKE_RUNTIME_OUTPUT_DIRECTORY=bin \
 -DCMAKE_SYSTEM_NAME=${CMAKE_SYSTEM_NAME} \
 -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER} \
 -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
make
ls bin/