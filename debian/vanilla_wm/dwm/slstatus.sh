#!/bin/bash

DEST_FOLDER="~/packages/suckless"

mkdir -p $DEST_FOLDER
git clone https://git.suckless.org/slstatus $DEST_FOLDER
cd $DEST_FOLDER/slstatus
make
sudo make install
cd -
