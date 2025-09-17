#!/bin/bash

if [[ $1 != @(linux-x64|win-x86|win-x64|win-arm64|osx-x64|osx-arm64) ]]; then
    echo "Invalid architecture: $1"
    exit 1
fi

if [[ $2 != @(net8.0) ]]; then
    echo "Invalid framework: $2"
    exit 1
fi

export PREFIX=""

if [[ ${GITHUB_REF_NAME} != "" ]]; then
    PREFIX="_$GITHUB_REF_NAME"
fi

export EXTENSION=""

if [[ $1 == "win-x86" || $1 == "win-x64" || $1 == "win-arm64" ]]; then
    EXTENSION=".exe"
fi

dotnet publish RATools/Source/rascript-cli/rascript-cli.csproj -r $1 -p:PublishSingleFile=true --self-contained true
mv RATools/bin/Release/$2/$1/publish/rascript-cli${EXTENSION} RATools/bin/Release/$2/$1/publish/rascript-cli${PREFIX}_$1${EXTENSION}