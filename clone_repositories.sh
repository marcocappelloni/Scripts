#!/bin/bash

# Add execute permissions to all the scripts
#find $HOME/PersonalHome/Scripts/ -type f -name "*.sh" -exec chmod u+x {} \;

mkdir -p $HOME/packages/suckless
cd $HOME/packages/suckless
echo "Cloning suckless folder from github"
git clone https://github.com/marcocappelloni/suckless.git

mkdir -p $HOME/dotfiles
cd $HOME/dotfiles
echo "Cloning dotfiles folder from github"
git clone https://github.com/marcocappelloni/dotfiles.git
