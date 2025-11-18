#!/bin/bash

source ./utilities.sh

msg "Installing cheat sheet client (cht.sh)"
sudo apt install curl rlwrap
curl -s https://cht.sh/:cht.sh | sudo tee /usr/local/bin/cht.sh && sudo chmod +x /usr/local/bin/cht.sh
msg "Cheat sheet client installed."
