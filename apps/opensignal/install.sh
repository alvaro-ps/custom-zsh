#!/bin/bash
brew tap opensignal/developer-toolbox git@github.com:opensignal/developer-toolbox.git
brew install opensignal/developer-toolbox/tools openssl

brew install postgresql  # For DAP
brew install openblas
brew install gdal
brew install vault

OPENBLAS=$(/opt/homebrew/bin/brew --prefix openblas)
export OPENBLAS=$OPENBLAS
export CFLAGS="-falign-functions=8 ${CFLAGS}"
export GRPC_PYTHON_BUILD_SYSTEM_OPENSSL=1
export GRPC_PYTHON_BUILD_SYSTEM_ZLIB=1


# Docker
brew install --cask docker
docker-compose \
docker-credential-helper-ecr
