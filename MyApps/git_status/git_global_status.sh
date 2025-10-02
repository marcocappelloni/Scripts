#!/bin/bash

source "/home/maky/PersonalHome/Scripts/MyApps/git_status/check_git_status.sh"
source "/home/maky/PersonalHome/Scripts/MyApps/git_status/git_directories.sh"
source "/home/maky/PersonalHome/Scripts/MyApps/git_status/bash_colors.sh"

for directory in "${directories[@]}"; do
  echo "-------------------"
  if $(check_status "$directory"); then
    printf "The %s%s%s git directory %scontains changes%s\n" "$cyan" "$directory" "$reset" "$red" "$reset"
  else
    printf "The %s%s%s git directory %sis up to date%s\n" "$cyan" "$directory" "$reset" "$green" "$reset"
  fi
done

echo "-------------------"
