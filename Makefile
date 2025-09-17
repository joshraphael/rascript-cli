SHELL := /bin/bash
RATOOLS_VERSION := tags/v1.16.0
TARGET_FRAMEWORK := net8.0

reset:
	rm -rf RATools/ && git submodule update --init --recursive && cd RATools/ && git fetch && git checkout ${RATOOLS_VERSION} && git submodule update --init --recursive

modify:
	sed -i -E 's|<TargetFramework>.*</TargetFramework>|<TargetFramework>${TARGET_FRAMEWORK}</TargetFramework>|' RATools/Source/rascript-cli/rascript-cli.csproj
	sed -i -E 's|<TargetFramework>net6.0</TargetFramework>|<TargetFramework>${TARGET_FRAMEWORK}</TargetFramework>|' RATools/Core/Core/Source/Jamiras.Core.csproj
	sed -i -E 's|<TargetFramework>net6.0</TargetFramework>|<TargetFramework>${TARGET_FRAMEWORK}</TargetFramework>|' RATools/Source/Data/RATools.Data.csproj
	sed -i -E 's|<TargetFramework>net6.0</TargetFramework>|<TargetFramework>${TARGET_FRAMEWORK}</TargetFramework>|' RATools/Source/Parser/RATools.Parser.csproj
	dotnet restore RATools/Source/rascript-cli/rascript-cli.csproj

run: reset modify
	dotnet run --project RATools/Source/rascript-cli/rascript-cli.csproj

build: reset modify build-linux-x64 build-win-x86 build-win-x64 build-win-arm64 build-osx-x64 build-osx-arm64

build-linux-x64:
	./scripts/build.sh linux-x64 ${TARGET_FRAMEWORK}

build-win-x86:
	./scripts/build.sh win-x86 ${TARGET_FRAMEWORK}

build-win-x64:
	./scripts/build.sh win-x64 ${TARGET_FRAMEWORK}

build-win-arm64:
	./scripts/build.sh win-arm64 ${TARGET_FRAMEWORK}

build-osx-x64:
	./scripts/build.sh osx-x64 ${TARGET_FRAMEWORK}

build-osx-arm64:
	./scripts/build.sh osx-arm64 ${TARGET_FRAMEWORK}