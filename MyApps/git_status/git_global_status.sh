#!/bin/bash

source "/home/maky/PersonalHome/Scripts/MyApps/git_status/git_directories.sh"
source "/home/maky/PersonalHome/Scripts/MyApps/git_status/bash_colors.sh"

strings_to_search=(
  "Changes not staged for commit"
  "Changes to be committed"
  "Untracked files"
)

check_status() {
  actual_dir="$1"
  cd $HOME/$actual_dir
  modified=false

  for string in "${strings_to_search[@]}"; do
    git status | grep "$string" >/dev/null
    if [[ $? == 0 ]]; then
      modified=true
    fi
  done

  echo "-------------------"

  if $modified; then
    printf "The %s%s%s git directory %scontains changes%s\n" "$cyan" "$actual_dir" "$reset" "$red" "$reset"
  else
    printf "The %s%s%s git directory %sis up to date%s\n" "$cyan" "$actual_dir" "$reset" "$green" "$reset"
  fi

  cd - >/dev/null
}

for directory in "${directories[@]}"; do
  check_status "$directory"
done

echo "-------------------"
