#!/bin/bash

strings_to_search=(
  "Changes not staged for commit"
  "Changes to be committed"
  "Untracked files"
)

red=$(tput setaf 1)
reset=$(tput sgr0)

check_status() {
  actual_dir="$1"
  cd $HOME/$actual_dir
  modified=false

  for string in "${strings_to_search[@]}"; do
    git status | grep "$string"
    if [[ $? == 0 ]]; then
      modified=true
    fi
  done

  if $modified; then
    printf "%sThe %s git directory contains changes%s\n" "$red" "$actual_dir" "$reset"
  else
    echo "The $actual_dir git directory is up to date."
  fi

  cd -
}

check_status "dotfiles"
check_status "PersonalHome/Scripts"
check_status "packages/suckless"
