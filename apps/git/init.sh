#!/bin/bash
alias push='br=$(git branch | grep \* | cut -d " " -f2); git push origin $br'
alias pull='br=$(git branch | grep \* | cut -d " " -f2); git pull origin $br'

alias unstage='git checkout --'
alias gco='git checkout'
alias gd='git branch -D'
alias gc='git commit -m'
