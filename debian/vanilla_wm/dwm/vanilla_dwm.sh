#!/bin/bash

DEST_FOLDER="$HOME/packages/suckless"

# Install dependencies
sudo apt install libx11-dev
sudo apt install libxft-dev
sudo apt install libfreetype6-dev
sudo apt install libxinerama-dev
sudo apt install libxinerama1

# Download and compile dwm
mkdir -p $DEST_FOLDER
git clone https://git.suckless.org/dwm $DEST_FOLDER
cd $DEST_FOLDER/dwm
make
sudo make install
cd -
sudo chown -R maky:maky $DEST_FOLDER/dwm

# Add dwm.desktop entry for the display managers
sudo mkdir -p /usr/share/xsessions/
echo "[Desktop Entry]
Encoding=UTF-8
Name=dwm
Comment=Dynamic Window Manager
Exec=dwm
Type=XSession
Icon=dwm" | sudo tee /usr/share/xsessions/dwm.desktop
