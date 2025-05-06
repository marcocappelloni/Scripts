#!/bin/bash
# Bash script to install the latest version of neovim using the app image from github


PACKAGES_DIR=$HOME/packages
EXEC_DIR=$HOME/.local/bin

mkdir -p $PACKAGES_DIR
mkdir -p $EXEC_DIR

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
chmod u+x nvim-linux-x86_64.appimage

mv nvim-linux-x86_64.appimage $PACKAGES_DIR

ln -s $HOME/packages/nvim-linux-x86_64.appimage $EXEC_DIR/nvim

echo "Reboot to enable the changes"
