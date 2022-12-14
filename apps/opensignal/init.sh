#!/bin/bash
alias opensignal="cd ~/opensignal/"
alias dap="cd ~/opensignal/data-aggregation-pipeline/"

## BLAS/Lapack libraries for numpy

# FLAGS
OPENBLAS="$(brew --prefix openblas)"
export OPENBLAS
export GRPC_PYTHON_BUILD_SYSTEM_OPENSSL=1
export GRPC_PYTHON_BUILD_SYSTEM_ZLIB=1
export LDFLAGS="-L/opt/homebrew/opt/lapack/lib -L/opt/homebrew/opt/openssl/lib"
export CPPFLAGS="-I/opt/homebrew/opt/lapack/include"
export CFLAGS="-I/opt/homebrew/opt/lapack/include -falign-functions=8"
export PKG_CONFIG_PATH="/opt/homebrew/opt/lapack/lib/pkgconfig"
export NPY_DISTUTILS_APPEND_FLAGS=1
export SYSTEM_VERSION_COMPAT=1
# export CFLAGS="-falign-functions=8"
#
## Libraries
export LAPACK=/opt/homebrew/opt/lapack/lib/liblapack.dylib
export BLAS=/opt/homebrew/opt/openblas/lib/libopenblas.dylib

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
