#!/bin/bash

if [[ $1 != @(v1.13.0|v1.14.0|v1.14.1|v1.15.0|v1.15.1|v1.15.2|v1.16.0|v1.16.1|v1.16.2|v1.17.0) ]]; then # RATools Version
    echo "Invalid RATools Version: $1"
    exit 1
fi
rm -rf RATools/
git clone https://github.com/Jamiras/RATools.git
cd RATools/
git fetch
git checkout tags/${1}
git submodule update --init --recursive