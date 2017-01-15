#!/bin/bash
# cmakeify installs and runs CMake with different configurations

#if [[ "$(uname -s)" == 'Darwin' ]]; then

CMAKEIFY_CMAKE_VERSION=cmake-3.7.20161217-g65aad-Linux-x86_64

# install a CMake 
mkdir prebuilts/
wget --no-check-certificate https://cmake.org/files/dev/${CMAKEIFY_CMAKE_VERSION}.tar.gz
tar xvfz ${CMAKEIFY_CMAKE_VERSION}.tar.gz -C prebuilts/


# build
mkdir build/
cd build
../prebuilts/${CMAKEIFY_CMAKE_VERSION}/bin/cmake ..
make