#!/bin/bash

if [[ $3 != @(v1.13.0|v1.14.0|v1.14.1|v1.15.0|v1.15.1|v1.15.2|v1.16.0|v1.16.1|v1.16.2|v1.17.0) ]]; then # RATools Version
    echo "Invalid RATools Version: $3"
    exit 1
fi

builds=(linux-x64 win-x86 win-x64 win-arm64 osx-x64 osx-arm64)
export SOURCE_DOTNET_VERSION=$1
export TARGET_DOTNET_VERSION=$2
export RATOOLS_VERSION=tags/$3
rm -rf builds/$RATOOLS_VERSION
mkdir -p builds/$RATOOLS_VERSION

for build in "${builds[@]}"; do
    bash ./scripts/build.sh $build $SOURCE_DOTNET_VERSION $TARGET_DOTNET_VERSION $RATOOLS_VERSION
done