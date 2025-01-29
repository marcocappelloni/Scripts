#!/bin/bash

# Arco post installation part 1.

sw_list_base="./softwares_lists/base"
install="sudo pacman -S --noconfirm --needed"
declare -a sw_to_install

##### FUNCTIONS #####

create_softwares_to_install_array () {
	sw_to_install=()
	while read -r software
	do
		pacman -Q "$software"
		if [ $? -ne 0 ]
		then
			sw_to_install+=($software)
		else
			echo "$software - already installed"
		fi
	done < "$1"
}

##### INSTALLATION BASE #####
echo "----- Update the System -----"
sudo pacman -Syu

echo "----- Install the base packages -----"
create_softwares_to_install_array $sw_list_base
echo "Software to install list: ${sw_to_install[@]}"
echo "Procede with the installation?(Y/N)"
read answer
if [[ ($answer = "Y") || ($answer = "y") ]]
then
	$install ${sw_to_install[@]}
fi

##### CREATE USER DIRECTORY FOLDERS #####
mkdir -p $HOME/Programs
mkdir -p $HOME/PersonalHome

##### ACTIVATE CLEANING THE PACKAGE CACHE #####
# paccache (part of pacman-contrib) will check the package cache directory and clean it
# if necessary every week.
sudo systemctl enable paccache.timer

##### SNAP #####
yay -S snapd
sudo systemctl enable --now snapd.socket
sudo systemctl start snapd.socket
sudo ln -s /var/lib/snapd/snap /snap
sudo systemctl enable --now snapd.apparmor
sleep 2

##### NEOVIM KICKSTART #####
echo "----- Installing neovim kickstart -----"
if [ ! -d $HOME/.config/nvim ]
then
	git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
fi

##### REBOOT #####
echo "----- Reboot the system before using SNAP and after start the part 3 -----"
echo "----- Reboot? (Y/N) -----"
read answer
if [[ ($answer = "Y") || ($answer = "y") ]]
then
	reboot
fi