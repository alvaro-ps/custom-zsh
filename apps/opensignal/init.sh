#!/bin/bash
OPENSIGNAL="${HOME}/opensignal"
DAP="${OPENSIGNAL}/data-aggregation-pipeline"
SCALA_UTILS="${OPENSIGNAL}/data-scala-utils"
alias opensignal='cd "$OPENSIGNAL"'
alias utils='cd "$SCALA_UTILS"'
alias dap='cd "$DAP"'

## BLAS/Lapack libraries for numpy
#openblas is keg-only, which means it was not symlinked into /opt/homebrew,
#because macOS provides BLAS in Accelerate.framework.

#For compilers to find openblas you may need to set:
#  export LDFLAGS="-L/opt/homebrew/opt/openblas/lib"
#  export CPPFLAGS="-I/opt/homebrew/opt/openblas/include"

# FLAGS
OPENBLAS="$(brew --prefix openblas)"
export OPENBLAS
#export GRPC_PYTHON_BUILD_SYSTEM_OPENSSL=1
export GRPC_PYTHON_BUILD_SYSTEM_ZLIB=1
export PATH="/opt/homebrew/opt/openssl@3/bin/:$PATH"  # Give priority to openssl over libressl (default in mac)
export LDFLAGS="-L/opt/homebrew/opt/lapack/lib -L/opt/homebrew/opt/openssl@3/lib -L$(brew --prefix)/lib"
export CMAKE_PREFIX_PATH="/opt/homebrew/opt/lapack/lib;${OPENBLAS}"
export CFLAGS="-I/opt/homebrew/opt/lapack/include -I/opt/homebrew/opt/openssl@3/include -I$(brew --prefix)/include  -falign-functions=8" # only for c
export CPPFLAGS="-I/opt/homebrew/opt/lapack/include" # for c and cpp 
export CXXFLAGS="-std=c++17"  # only for cpp
export PKG_CONFIG_PATH="/opt/homebrew/opt/lapack/lib/pkgconfig"
export NPY_DISTUTILS_APPEND_FLAGS=1
export SYSTEM_VERSION_COMPAT=1

## Libraries
export LAPACK=/opt/homebrew/opt/lapack/lib/liblapack.dylib
export BLAS=/opt/homebrew/opt/openblas/lib/libopenblas.dylib
export LIBRARY_PATH="$LIBRARY_PATH:/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib" # gfortran

function setup_repo() {
  git submodule update --recursive
  # Ensure running in virtualenv
  if [ -z "$VIRTUAL_ENV" ]; then
    echo "No virtual env! Create one with 'pyenv virtualenv <python-version> <virtualenv-name>' and activate it"
    return 1
  fi
  rm -rf venv && mkdir venv
  ln -fs "$VIRTUAL_ENV"/* venv   # link venv with whatever in the pyenv virtualenv, careful when touching this!
  pyenv pyright  # For nvim to use the virtual env
  pip3 install -U --extra-index-url https://repo.opnsgnl.net/repository/pypi/simple  devops-ci-tools --upgrade
  make setup || true
}

function dap_scala_local_deploy() {
  SCALA_UTILS_JAR=$(find "${SCALA_UTILS}" -name "data-scala-utils-assembly*-dev0.jar")
  DAP_SCALA_JAR="${DAP}/venv/lib/data-scala-utils-assembly.jar"

  cp -v "${SCALA_UTILS_JAR}" "${DAP_SCALA_JAR}"
}

function local_geo_json_tools() {
  GEOJSON_TOOLS_JAR=$(find "${SCALA_UTILS}" -name "geo-json-tools-assembly*-dev0.jar")

  java -Xmx12g -XX:+AggressiveOpts -jar "$GEOJSON_TOOLS_JAR" "$@" \
    && echo "All ok!" \
    || echo "try 'make build' to get the latest version"
}

alias local_airflow="SQLALCHEMY_SILENCE_UBER_WARNING=1 airflow variables import dev/variables.json && airflow standalone"
