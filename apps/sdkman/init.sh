#!/bin/bash

function scala2 () {
  sdk use java 8.0.342-amzn
  sdk use scala 2.12.17
  sdk use spark 2.4.7
  export DATA_SCALA_UTILS_VERSION=2.1.3
  export SCALA_VERSION=2.12
  export SPARK_VERSION=2
}

function scala3 () {
  sdk use java 11.0.16-amzn
  #sdk use scala 3.2.0
  sdk use scala 2.12.17
  sdk use spark 3.2.1
  export DATA_SCALA_UTILS_VERSION=2.1.9
  export SCALA_VERSION=2.12
  export SPARK_VERSION=3
  export PYSPARK_PYTHON=$(which python)
}

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
