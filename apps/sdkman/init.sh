#!/bin/bash

function scala2 () {
  # Deprecated
  sdk use java 8.0.342-amzn
  sdk use scala 2.12.17
  sdk use spark 2.4.7
  export DATA_SCALA_UTILS_VERSION=2.1.3
  export SCALA_VERSION=2.12
  export SPARK_VERSION=2
}

export DATA_SCALA_UTILS_VERSION=2.1.35
export SCALA_VERSION=2.12
export SPARK_VERSION=2
SPARK_DETAILED_VERSION=3.2.1
export SPARK_HOME="$(sdk home spark $SPARK_DETAILED_VERSION)"
export PYSPARK_PYTHON=$(which python)
alias spark="spark-shell --packages org.apache.spark:spark-hadoop-cloud_${SCALA_VERSION}:${SPARK_DETAILED_VERSION}"

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
