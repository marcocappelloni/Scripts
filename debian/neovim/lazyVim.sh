#!/bin/bash

# install the last neovim (appimage)
bash ./neovim.sh

# required
echo "Moving the actual version of neovim in .config/neovim.bak..."
mv ~/.config/nvim{,.bak}

# optional but recommended
echo "Backing up .local/share/nvim..."
mv ~/.local/share/nvim{,.bak}
echo "Backing up .local/state/nvim..."
mv ~/.local/state/nvim{,.bak}
echo "Backing up .cache/nvim..."
mv ~/.cache/nvim{,.bak}

echo "Cloning the starter of lazyVim..."
git clone https://github.com/LazyVim/starter ~/.config/nvim

echo "Removing the .git folder to add it to my own repo..."
rm -rf ~/.config/nvim/.git

echo "DONE!"
