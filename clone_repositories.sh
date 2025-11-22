#!/bin/bash

# Add execute permissions to all the scripts
#find $HOME/PersonalHome/Scripts/ -type f -name "*.sh" -exec chmod u+x {} \;

mkdir -p $HOME/packages
cd $HOME/packages
echo "Cloning suckless folder from github"
git clone https://github.com/marcocappelloni/suckless.git

cd $HOME
echo "Cloning dotfiles folder from github"
git clone https://github.com/marcocappelloni/dotfiles.git
