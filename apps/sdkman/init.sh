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


export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

export DATA_SCALA_UTILS_VERSION=$(head ~/opensignal/data-aggregation-pipeline/DATA_SCALA_UTILS_VERSION)
export SCALA_VERSION=2.13
export SPARK_VERSION=3
SPARK_DETAILED_VERSION=3.5.4
export SPARK_HOME="$(sdk home spark 3.5.4-scala2.13)"
export PYSPARK_PYTHON=python
export SPARK_PACKAGES="org.apache.spark:spark-hadoop-cloud_${SCALA_VERSION}:${SPARK_DETAILED_VERSION}"
SPARK_GCS_IMPL="spark.hadoop.fs.gs.impl=com.google.cloud.hadoop.fs.gcs.GoogleHadoopFileSystem"
export SPARK_PREAMBLE="--packages ${SPARK_PACKAGES} --conf ${SPARK_GCS_IMPL}"
alias spark="spark-shell ${SPARK_PREAMBLE}"
alias pyspark="PYSPARK_DRIVER_PYTHON=ipython pyspark ${SPARK_PREAMBLE}"
alias scala-tree="tree -I target -I project"
