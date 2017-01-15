#!/bin/bash
# cmakeify installs and runs CMake with different configurations


CMAKEIFY_CMAKE_VERSION=cmake-3.7.20161217-g65aad




# install a CMake 
mkdir prebuilts/
if [[ "$(uname -s)" == 'Darwin' ]]; then
wget --no-check-certificate https://cmake.org/files/dev/${CMAKEIFY_CMAKE_VERSION}-Darwin-x86_64.tar.gz -O cmake.tar.gz
tar xvfz cmake.tar.gz -C prebuilts/ 
mv ${CMAKEIFY_CMAKE_VERSION}-Darwin-x86_64 cmake
else
wget --no-check-certificate https://cmake.org/files/dev/${CMAKEIFY_CMAKE_VERSION}-Linux-x86_64.tar.gz -O cmake.tar.gz
tar xvfz cmake.tar.gz -C prebuilts/ > untar.cmake.txt
mv prebuilts/${CMAKEIFY_CMAKE_VERSION}-Linux-x86_64 prebuilts/cmake
fi

prebuilts/cmake/bin/cmake --version



# build
mkdir build/
cd build
../prebuilts/cmake/bin/cmake ..
make
ll