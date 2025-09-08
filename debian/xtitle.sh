#!/bin/bash

cd /home/maky/packages
git clone https://github.com/baskerville/xtitle.git
cd xtitle
make
sudo make install
sudo cp xtitle /usr/local/bin
