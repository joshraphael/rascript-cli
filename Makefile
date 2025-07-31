SHELL := /bin/bash
RATOOLS_VERSION := v1.15.2

reset:
	rm -rf RATools/ && git submodule update --init --recursive && cd RATools/ && git checkout tags/${RATOOLS_VERSION}

modify:
	sed -i -E 's|<TargetFramework>.*</TargetFramework>|<TargetFramework>net8.0</TargetFramework>|' RATools/Source/rascript-cli/rascript-cli.csproj
	dotnet restore RATools/Source/rascript-cli/rascript-cli.csproj

run: reset modify
	dotnet run --project RATools/Source/rascript-cli/rascript-cli.csproj