#!/bin/bash

if [[ $1 != @(linux-x64|win-x86|win-x64|win-arm64|osx-x64|osx-arm64) ]]; then # Architecture
    echo "Invalid architecture: $1"
    exit 1
fi

if [[ $2 != @(net6.0|net10.0) ]]; then # dotnet Version
    echo "Invalid dotnet Version: $2"
    exit 1
fi

BUILD_TAG=$(basename ${3})

export EXTENSION=""

if [[ $1 == "win-x86" || $1 == "win-x64" || $1 == "win-arm64" ]]; then
    EXTENSION=".exe"
fi

bash ./scripts/reset.sh $3
dotnet publish RATools/Source/rascript-cli/rascript-cli.csproj -r $1 -c Release -p:PublishSingleFile=true --self-contained true
mkdir -p builds/$BUILD_TAG
mv RATools/bin/Release/$2/$1/publish/rascript-cli${EXTENSION} builds/$BUILD_TAG/rascript-cli_${BUILD_TAG}_$1${EXTENSION}