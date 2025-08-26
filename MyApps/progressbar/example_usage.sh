#!/bin/bash

source progressbar.sh

process-file() {
  local file=$1

  sleep .01
}

shopt -s globstar nullglob

echo "finding files"
# find . -name "*cache"

files=(./**/*cache)
len=${#files[@]}

echo "found $len files"

i=0
for file in "${files[@]}"; do
  progress-bar "$((i + 1))" "$len"
  process-file "$file"
  ((i++))
done

echo
