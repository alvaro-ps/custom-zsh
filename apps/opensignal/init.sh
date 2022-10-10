#!/bin/bash
alias opensignal="cd ~/opensignal/"
alias dap="cd ~/opensignal/data-aggregation-pipeline/"

## BLAS/Lapack libraries for numpy

# FLAGS
OPENBLAS="$(brew --prefix openblas)"
export OPENBLAS
#export LDFLAGS="-L/opt/homebrew/opt/lapack/lib"
#export CPPFLAGS="-I/opt/homebrew/opt/lapack/include"
#export PKG_CONFIG_PATH="/opt/homebrew/opt/lapack/lib/pkgconfig"
#export NPY_DISTUTILS_APPEND_FLAGS=1
#export SYSTEM_VERSION_COMPAT=1
#export CFLAGS="-falign-functions=8"
#
## Libraries
#export LAPACK=/opt/homebrew/opt/lapack/lib/liblapack.dylib
#export BLAS=/opt/homebrew/opt/openblas/lib/libopenblas.dylib

function setup_repo() {
  # Ensure running in virtualenv
  git submodule update --init --remote
  pip install virtualenv
  virtualenv venv
  ln -fs $(which pip) venv/bin/pip3
  pip3 install -U --extra-index-url https://repo.opnsgnl.net/repository/pypi/simple  devops-ci-tools --upgrade
}
