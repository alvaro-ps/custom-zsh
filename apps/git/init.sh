#!/bin/bash
alias push='br=$(git branch | grep \* | cut -d " " -f2); git push origin $br'
alias pull='br=$(git branch | grep \* | cut -d " " -f2); git pull origin $br'

alias unstage='git checkout --'
