#!/usr/bin/env bash

SCRIPT_PATH=$(dirname "${BASH_SOURCE}")
source $SCRIPT_PATH/utilities.sh

msg "Installing cheat sheet client (cht.sh)"
sudo apt -y install curl rlwrap
curl -s https://cht.sh/:cht.sh | sudo tee /usr/local/bin/cht.sh && sudo chmod +x /usr/local/bin/cht.sh
msg "Cheat sheet client installed."
