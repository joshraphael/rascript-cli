#!/bin/bash

if [[ $3 != @(v1.13.0|v1.14.0|v1.14.1|v1.15.0|v1.15.1|v1.15.2|v1.16.0|v1.16.1|v1.16.2|v1.17.0) ]]; then # RATools Version
    echo "Invalid RATools Version: $3"
    exit 1
fi

builds=(linux-x64 win-x86 win-x64 win-arm64 osx-x64 osx-arm64)
export SOURCE_DOTNET_VERSION=$1
export TARGET_DOTNET_VERSION=$2
export RATOOLS_VERSION=tags/$3

export RELEASE_VERSION="dev"
if [[ ${GITHUB_REF_NAME} != "" ]]; then
    RELEASE_VERSION="$GITHUB_REF_NAME"
fi

rm -rf builds/$3
mkdir -p builds/$3

export FILES=""
for build in "${builds[@]}"; do
    bash ./scripts/build.sh $build $SOURCE_DOTNET_VERSION $TARGET_DOTNET_VERSION $RATOOLS_VERSION
    export EXTENSION=""
    if [[ $build == "win-x86" || $build == "win-x64" || $build == "win-arm64" ]]; then
        EXTENSION=".exe"
    fi
    FILES+="rascript-cli_${3}_${build}${EXTENSION} "
done

cd builds/${3}
zip ${RELEASE_VERSION}_rascript-cli_${3}.zip ${FILES}
mv ${RELEASE_VERSION}_rascript-cli_${3}.zip ../archives