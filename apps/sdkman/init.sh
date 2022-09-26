#!/bin/bash
alias java8="sdk use java 8.0.342-amzn"
alias java11="sdk use java 11.0.16-amzn"
alias scala2="sdk use java 8.0.342-amzn && sdk use scala 2.13.9"
alias scala3="sdk use java 11.0.16-amzn && sdk use scala 3.2.0"

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
