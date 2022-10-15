#!/bin/bash
#curl -s "https://get.sdkman.io" | bash

# sdk install java 11.0.16-amzn
# sdk install java 8.0.342-amzn
# sdk install scala 3.2.0
# sdk install scala 2.12.17
sdk install spark 2.4.7
sdk install spark 3.2.1

sdk default java 11.0.16-amzn
#sdk use scala 3.2.0
sdk default scala 2.12.17
sdk default spark 3.2.1
