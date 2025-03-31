#!/bin/bash
#curl -s "https://get.sdkman.io" | bash

# sdk install java 11.0.16-amzn
# sdk install java 8.0.342-amzn
# sdk install scala 3.2.0
# sdk install scala 2.12.17
sdk install spark 2.4.7
sdk install spark 3.2.1

sdk default java 17.0.10-amzn
#sdk use scala 3.2.0
#sdk default scala 2.12.17
#sdk default spark 3.2.1
sdk default scala 2.13.15
# Install manually and have sdkman point to it with 
# `sdk install spark 3.5.4-scala2.13 ~/Downloads/spark-3.5.4-scala2.13`
sdk default spark 3.5.4-scala2.13
