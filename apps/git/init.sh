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

function get_jira_ticket () {
  get_branch
  ticket=$(echo "${branch}" | grep -oE "^([a-zA-Z]+-[0-9]+)" | head -n1)
}

function gc() {
  message="$1"
  get_jira_ticket

  if [ -n "$ticket" ]; then
    prefix="[${ticket}] "
  else
    prefix=""
  fi
  git commit -m "${prefix}${message}"
}

#alias gc='git commit -m'
alias gs='git status'
alias gunstage='git checkout --'
alias gco='git checkout'
alias gbd='git branch -D'
alias master='git checkout master'
