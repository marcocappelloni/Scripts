#!/usr/bin/env bash

BASE_ADDRESS="https://www.xm1math.net/texmaker/assets/files"

# Extract the last stable version number
version=$(curl -L $BASE_ADDRESS 2>/dev/null |
  grep -Po '[0-9]+\.[0-9]+\.[0-9]' |
  sed 's/\///' |
  sort -uV |
  tail -n 1)

echo "$version"
