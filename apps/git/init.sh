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

alias commit='git commit -m'
alias unstage='git checkout --'
alias checkout='git checkout'
alias branch_del='git branch -D'
