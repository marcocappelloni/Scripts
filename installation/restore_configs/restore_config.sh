#!/bin/bash


##### Variables #####
clonedirectory="https://github.com/marcocappelloni/dotfiles.git"
#git clone https://github.com/username/repository.git -C /path/to/directory

##### .dotfile directory #####
echo "Create the .dotfile directory?"
read -rp "Y/n : " answer

if [[ "$answer" =~ ^[Yy]$ ]]; then
    mkdir ~/.dotfiles
    git clone $clonedirectory $HOME
    echo "The directory .dotfiles has been created"
fi


##### Bashrc with aliases #####
echo "Write .bashrc file with aliases?"
read -rp "Y/n : " answer

if [[ "$answer" =~ ^[Yy]$ ]]; then
    if [[ -f ~/.bashrc ]]; then
        mv ~/.bashrc ~/.bashrc.bak
        echo "Your current .bashrc has been moved to .bashrc.bak"
    fi

    cp dotfiles/.bashrc $HOME
    cp dotfiles/.aliasrc $HOME
elif [[ "$answer" =~ ^[Nn]$ ]]; then
    echo "No changes have been made to ~/.bashrc"
else
    echo "Invalid input. Please enter 'y' or 'n'."
fi

##### Copy .Xresouces and .Xresources.d #####
echo "Write the .Xresources file and the .Xresources.d directory?"
read -rp "Y/n : " answer

if [[ "$answer" =~ ^[Yy]$ ]]; then
    cp dotfiles/.Xresources $HOME
    cp -r dotfiles/.Xresources.d $HOME
elif [[ "$answer" =~ ^[Nn]$ ]]; then
    echo "No changes have been made to ~/.Xresources"
else
    echo "Invalid input. Please enter 'y' or 'n'."
fi


echo "Configuration complete."
echo "Reboot the system"
