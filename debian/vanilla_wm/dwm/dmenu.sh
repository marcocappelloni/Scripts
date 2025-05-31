#!/bin/bash

DEST_FOLDER="~/packages/suckless"

mkdir -p $DEST_FOLDER
git clone https://git.suckless.org/dmenu $DEST_FOLDER
cd $DEST_FOLDER/dmenu
make
sudo make install
cd -
