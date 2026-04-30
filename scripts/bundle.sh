#!/bin/bash

builds=(linux-x64 win-x86 win-x64 win-arm64 osx-x64 osx-arm64)
export SOURCE_DOTNET_VERSION=$1
export TARGET_DOTNET_VERSION=$2
export RATOOLS_VERSION=$3
rm -rf builds/$RATOOLS_VERSION
mkdir -p builds/$RATOOLS_VERSION

for build in "${builds[@]}"; do
    bash ./scripts/build.sh $build $SOURCE_DOTNET_VERSION $TARGET_DOTNET_VERSION $RATOOLS_VERSION
done