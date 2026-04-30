#!/bin/bash

if [[ $1 != @(linux-x64|win-x86|win-x64|win-arm64|osx-x64|osx-arm64) ]]; then # Architecture
    echo "Invalid architecture: $1"
    exit 1
fi

if [[ $2 != @(net6.0|net8.0|net10.0) ]]; then # Source dotnet Version
    echo "Invalid Source dotnet Version: $2"
    exit 1
fi

if [[ $3 != @(net8.0|net10.0) ]]; then # Target dotnet Version
    echo "Invalid Target dotnet Version: $3"
    exit 1
fi

if [[ $4 != @(v1.13.0|v1.14.0|v1.14.1|v1.15.0|v1.15.1|v1.15.2|v1.16.0|v1.16.1|v1.16.2|v1.17.0) ]]; then # RATools Version
    echo "Invalid RATools Version: $4"
    exit 1
fi

export EXTENSION=""

if [[ $1 == "win-x86" || $1 == "win-x64" || $1 == "win-arm64" ]]; then
    EXTENSION=".exe"
fi

bash ./scripts/reset.sh $4
bash ./scripts/modify.sh $2 $3
dotnet publish RATools/Source/rascript-cli/rascript-cli.csproj -r $1 -p:PublishSingleFile=true --self-contained true
mkdir -p builds/$4
mv RATools/bin/Release/$3/$1/publish/rascript-cli${EXTENSION} builds/$4/rascript-cli_${4}_$1${EXTENSION}