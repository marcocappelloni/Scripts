#!/bin/bash

sw_list_common="./softwares_lists/common"
sw_list_aur="./softwares_lists/aur"
sw_list_snap="./softwares_lists/snap"
install="sudo pacman -S --noconfirm --needed"
snap_install="sudo snap install"
aur_install="yay -S --noconfirm --needed"
declare -a sw_to_install

##### FUNCTIONS #####

create_softwares_to_install_array () {
	sw_to_install=()
	while read -r software
	do
		sw_to_install+=($software)
	done < "$1"
}

##### INSTALL COMMON PACKAGES #####
echo "----- Install the common packages -----"
create_softwares_to_install_array $sw_list_common
echo "Software to install list: ${sw_to_install[@]}"
echo "Procede with the installation?(Y/N)"
read answer
if [[ ($answer = "Y") || ($answer = "y") ]]
then
	$install ${sw_to_install[@]}
fi

##### INSTALL AUR PACKAGES #####
echo "----- Install the aur packages -----"
create_softwares_to_install_array $sw_list_aur
echo "Software to install list: ${sw_to_install[@]}"
echo "Procede with the installation?(Y/N)"
read answer
if [[ ($answer = "Y") || ($answer = "y") ]]
then
	$aur_install ${sw_to_install[@]}
fi

##### SNAP #####
sudo systemctl enable --now snapd.socket
sudo systemctl start snapd.socket
sudo ln -s /var/lib/snapd/snap /snap
sleep 2

##### REBOOT #####
echo "----- Reboot the system before using SNAP and after start the part 3 -----"
echo "----- Reboot? (Y/N) -----"
read answer
if [[ ($answer = "Y") || ($answer = "y") ]]
then
	reboot
fi
