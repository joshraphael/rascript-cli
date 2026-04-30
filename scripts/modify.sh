#!/bin/bash

if [[ $1 != @(net6.0|net8.0|net10.0) ]]; then # Source dotnet Version
    echo "Invalid Source dotnet Version: $1"
    exit 1
fi

if [[ $2 != @(net8.0|net10.0) ]]; then # Target dotnet Version
    echo "Invalid Target dotnet Version: $2"
    exit 1
fi

sed -i -E "s|<TargetFramework>.*</TargetFramework>|<TargetFramework>${2}</TargetFramework>|" RATools/Source/rascript-cli/rascript-cli.csproj
sed -i -E "s|<TargetFramework>${1}</TargetFramework>|<TargetFramework>${2}</TargetFramework>|" RATools/Core/Core/Source/Jamiras.Core.csproj
sed -i -E "s|<TargetFramework>${1}</TargetFramework>|<TargetFramework>${2}</TargetFramework>|" RATools/Source/Data/RATools.Data.csproj
sed -i -E "s|<TargetFramework>${1}</TargetFramework>|<TargetFramework>${2}</TargetFramework>|" RATools/Source/Parser/RATools.Parser.csproj
dotnet restore RATools/Source/rascript-cli/rascript-cli.csproj