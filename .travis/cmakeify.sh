#!/bin/bash
# cmakeify installs and runs CMake with different configurations

#if [[ "$(uname -s)" == 'Darwin' ]]; then


# install a CMake 
wget --no-check-certificate https://cmake.org/files/dev/cmake-3.7.20161217-g65aad-Linux-x86_64.tar.gz
tar xvfz cmake-3.7.20161217-g65aad-Linux-x86_64.tar.gz -C prebuilts/

