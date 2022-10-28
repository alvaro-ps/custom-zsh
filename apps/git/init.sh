#!/bin/bash
alias push='br=$(git branch | grep \* | cut -d " " -f2); git push origin $br'
alias pull='br=$(git branch | grep \* | cut -d " " -f2); git pull origin $br'

alias commit='git commit -m'
alias unstage='git checkout --'
alias checkout='git checkout'
alias branch_del='git branch -D'
