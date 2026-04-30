#!/bin/bash

if [[ $2 != @(v1.13.0|v1.14.0|v1.14.1|v1.15.0|v1.15.1|v1.15.2|v1.16.0|v1.16.1|v1.16.2|v1.17.0) ]]; then # RATools Version
    echo "Invalid RATools Version: $2"
    exit 1
fi

builds=(linux-x64 win-x86 win-x64 win-arm64 osx-x64 osx-arm64)
export DOTNET_VERSION=$1
export RATOOLS_VERSION=tags/$2

export RELEASE_VERSION="dev"
if [[ ${GITHUB_REF_NAME} != "" ]]; then
    RELEASE_VERSION="$GITHUB_REF_NAME"
fi

rm -rf builds/$2
mkdir -p builds/$2

export FILES=""
for build in "${builds[@]}"; do
    bash ./scripts/build.sh $build $DOTNET_VERSION $RATOOLS_VERSION
    export EXTENSION=""
    if [[ $build == "win-x86" || $build == "win-x64" || $build == "win-arm64" ]]; then
        EXTENSION=".exe"
    fi
    FILES+="rascript-cli_${2}_${build}${EXTENSION} "
done

cd builds/${2}
zip rascript-cli_${2}-${RELEASE_VERSION}.zip ${FILES}
mv rascript-cli_${2}-${RELEASE_VERSION}.zip ../archives