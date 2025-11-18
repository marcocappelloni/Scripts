#!/bin/bash

mkdir -p $HOME/PersonalHome
echo "Cloning Scripts folder from github"
git clone https://github.com/marcocappelloni/Scripts.git $HOME/PersonalHome

# Add execute permissions to all the scripts
find $HOME/PersonalHome/Scripts/ -type f -name "*.sh" -exec chmod u+x {} \;

mkdir -p $HOME/packages/
echo "Cloning suckless folder from github"
git clone https://github.com/marcocappelloni/suckless.git $HOME/packages

echo "Cloning dotfiles folder from github"
git clone https://github.com/marcocappelloni/dotfiles.git $HOME
