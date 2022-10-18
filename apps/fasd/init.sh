#!/bin/bash

# initialize fasd
eval "$(fasd --init auto posix-alias zsh-ccomp zsh-ccomp-install)"
alias v="f -ie nvim"
alias z="fasd_cd -id"
