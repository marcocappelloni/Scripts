#!/bin/bash

# install first block of softwares


sw_list_base="./softwares_lists/base"
install="sudo apt install"
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
sudo apt update && sudo apt upgrade

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
xdg-user-dirs-update
mkdir -p ~/Programs
mkdir -p ~/PersonalHome

