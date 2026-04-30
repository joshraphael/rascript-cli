SHELL := /bin/bash

## Manual build vars
MANUAL_BUILD_RATOOLS_VERSION := tags/v1.17.0
MANUAL_BUILD_DOTNET_VERSION := net10.0

reset:
	./scripts/reset.sh ${MANUAL_BUILD_RATOOLS_VERSION}

run: reset
	dotnet run --project RATools/Source/rascript-cli/rascript-cli.csproj

build: build-linux-x64 build-win-x86 build-win-x64 build-win-arm64 build-osx-x64 build-osx-arm64

bundle:
	rm -rf builds/
	mkdir -p builds/archives
	./scripts/bundle.sh net6.0 v1.13.0
	./scripts/bundle.sh net6.0 v1.14.0
	./scripts/bundle.sh net6.0 v1.14.1
	./scripts/bundle.sh net6.0 v1.15.0
	./scripts/bundle.sh net6.0 v1.15.1
	./scripts/bundle.sh net6.0 v1.15.2
	./scripts/bundle.sh net6.0 v1.16.0
	./scripts/bundle.sh net6.0 v1.16.1
	./scripts/bundle.sh net6.0 v1.16.2
	./scripts/bundle.sh net10.0 v1.17.0

build-linux-x64:
	./scripts/build.sh linux-x64 ${MANUAL_BUILD_DOTNET_VERSION} ${MANUAL_BUILD_RATOOLS_VERSION}

build-win-x86:
	./scripts/build.sh win-x86 ${MANUAL_BUILD_DOTNET_VERSION} ${MANUAL_BUILD_RATOOLS_VERSION}

build-win-x64:
	./scripts/build.sh win-x64 ${MANUAL_BUILD_DOTNET_VERSION} ${MANUAL_BUILD_RATOOLS_VERSION}

build-win-arm64:
	./scripts/build.sh win-arm64 ${MANUAL_BUILD_DOTNET_VERSION} ${MANUAL_BUILD_RATOOLS_VERSION}

build-osx-x64:
	./scripts/build.sh osx-x64 ${MANUAL_BUILD_DOTNET_VERSION} ${MANUAL_BUILD_RATOOLS_VERSION}

build-osx-arm64:
	./scripts/build.sh osx-arm64 ${MANUAL_BUILD_DOTNET_VERSION} ${MANUAL_BUILD_RATOOLS_VERSION}