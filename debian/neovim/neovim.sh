#!/bin/bash

# Bash script to install the latest version of neovim using the app image from github
bash $HOME/PersonalHome/Scripts/debian/install_appimage.sh https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
#PACKAGES_DIR=$HOME/packages
#EXEC_DIR=$HOME/.local/bin

#mkdir -p $PACKAGES_DIR
#mkdir -p $EXEC_DIR

#curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
#chmod u+x nvim-linux-x86_64.appimage

#mv nvim-linux-x86_64.appimage $PACKAGES_DIR

#ln -s $HOME/packages/nvim-linux-x86_64.appimage $EXEC_DIR/nvim

#echo "Reboot to enable the changes"

#https://github.com/texstudio-org/texstudio/releases/download/4.8.7/texstudio-4.8.7-x86_64.AppImage
#https://github.com/texstudio-org/texstudio/releases/download/4.8.5/texstudio-4.8.5-x86_64.AppImage
#https://github.com/texstudio-org/texstudio/releases/download/4.8.4/texstudio-4.8.4-x86_64.AppImage
