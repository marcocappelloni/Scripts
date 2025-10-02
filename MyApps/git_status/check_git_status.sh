#!/bin/bash

strings_to_search=(
  "Changes not staged for commit"
  "Changes to be committed"
  "Untracked files"
)

check_status() {
  actual_dir="$1"
  cd $HOME/$actual_dir

  for string in "${strings_to_search[@]}"; do
    git status | grep "$string" >/dev/null
    if [[ $? == 0 ]]; then
      return 0
    fi
  done

  cd - >/dev/null

  return 1
}
