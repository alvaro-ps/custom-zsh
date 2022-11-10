#!/bin/bash

function get_branch () {
  branch=$(git branch | grep "\*" | cut -d " " -f2)
}

function push () {
  get_branch
  git push origin "${branch}"
}

function pull (){
  get_branch
  git pull origin "${branch}"
}

alias gc='git commit -m'
alias gunstage='git checkout --'
alias gco='git checkout'
alias gbd='git branch -D'
