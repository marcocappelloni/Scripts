#!/bin/bash

string_to_search="Untracked files:"
red=$(tput setaf 1)
reset=$(tput sgr0)

check_status() {
  actual_dir="$1"
  cd $HOME/$actual_dir
  git status | grep "$string_to_search"
  if [[ $? == 1 ]]; then
    echo "The $actual_dir git directory is up to date."
  else
    printf "%sThe %s git directory contains changes%s\n" "$red" "$actual_dir" "$reset"
    #echo "The $actual_dir git directory contains changes"
  fi
  cd -
}

check_status "dotfiles"
check_status "PersonalHome/Scripts"
check_status "packages/suckless"
