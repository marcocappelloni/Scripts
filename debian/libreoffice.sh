#!/bin/bash

BASE_ADDRESS="https://download.documentfoundation.org/libreoffice/stable"
# Extract the last stable version number
version=$(curl -L $BASE_ADDRESS 2>/dev/null |
  grep -Po '[0-9]+\.[0-9]+\.[0-9]+/' |
  sed 's/\///' |
  sort -uV |
  tail -n 1)

echo "$version"

# Script to install Libreoffice taken from "https://download.documentfoundation.org/libreoffice/stable/"
wget "${BASE_ADDRESS}/${version}/deb/x86_64/LibreOffice_${version}_Linux_x86-64_deb.tar.gz"
tar -xvf "LibreOffice_${version}_Linux_x86-64_deb.tar.gz"
apt install "./LibreOffice_${version}_Linux_x86-64_deb/DEBS/*.deb"
