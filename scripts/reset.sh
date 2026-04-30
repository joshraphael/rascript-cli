#!/bin/bash

rm -rf RATools/
git clone https://github.com/Jamiras/RATools.git
cd RATools/
git fetch
git checkout ${1}
git submodule update --init --recursive