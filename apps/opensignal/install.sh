#!/bin/bash
brew tap opensignal/developer-toolbox git@github.com:opensignal/developer-toolbox.git
brew install opensignal/developer-toolbox/tools openssl

# Docker
brew install --cask docker
docker-compose \
docker-credential-helper-ecr
