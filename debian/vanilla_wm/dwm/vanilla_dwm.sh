#!/bin/bash

DEST_FOLDER="~/packages/suckless"

# Install dependencies
sudo apt install libx11-dev
sudo apt install libxft-dev
sudo apt install libfreetype6-dev
sudo apt-get install libxinerama-dev
sudo apt-get install libxinerama1

# Download and compile dwm
mkdir -p $DEST_FOLDER
git clone https://git.suckless.org/dwm $DEST_FOLDER
cd $DEST_FOLDER/dwm
make
sudo make install
cd -
sudo chown -R maky:maky $DEST_FOLDER/dwm
