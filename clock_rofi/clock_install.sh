#!/bin/bash

ln -s ./clock.sh $HOME/.local/bin/clock

# Install the Iosevka font used for the clock
echo "Do you want to install the Iosevka Nerd Font? (y/n)"
read response
if [[ "$response" =~ ^[Yy]$ ]]; then
  mkdir Iosevka
  unzip Iosevka.zip -d Iosevka/
  sudo mv Iosevka/ /usr/share/fonts/truetype/
  sudo fc-cache -f -v # update the font cache
fi
