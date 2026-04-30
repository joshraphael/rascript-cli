#!/bin/bash

if [ ! -d "RATools/" ]; then
    git clone https://github.com/Jamiras/RATools.git
fi
cd RATools/
git fetch
git checkout ${1}
git submodule update --init --recursive