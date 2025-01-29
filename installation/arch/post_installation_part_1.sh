#!/bin/bash

# Arch post installation part 1.
# Installing the base packages and configuring bluetooth, pacman, firewall, snap....

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
xdg-user-dirs-update
mkdir -p ~/Programs
mkdir -p ~/PersonalHome

##### PACMAN CONFIGURATION #####
echo "----- configure PacMan and mirrors -----"
echo "UNCOMMENT the line with 'Color' and 'ParallelDownloads' inside the section 'Misc options' "
echo "PRESS ENTER TO CONTINUE"
read answer
sudo nano /etc/pacman.conf

##### MIRROR LIST #####
sudo pacman -Sy
sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
sudo reflector --verbose --latest 10 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Sy

##### BLUETOOTH #####
echo "----- Adding module btusb -----"
sudo modprobe btusb
echo "----- Enabling and starting bluetooth -----"
sudo systemctl enable bluetooth
sudo systemctl start bluetooth
echo "----- Create config file for grub -----"
sudo grub-mkconfig -o /boot/grub/grub.cfg

##### YAY #####
echo "----- Install Aur Helper -----"
cd ~/Programs
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

##### FIREWALL #####
echo "----- Setup firewall -----"
sudo ufw enable
sudo systemctl enable ufw.service
sudo systemctl start ufw

##### ACTIVATE CLEANING THE PACKAGE CACHE #####
# paccache (part of pacman-contrib) will check the package cache directory and clean it
# if necessary every week.
sudo systemctl enable paccache.timer

##### CONFIGURATION XRESOURCES #####
echo " "
echo " ******************* "
echo "Copy the .Xresources file from the backup together with the .Xresources.d directory 
containing the themes and the .xinitrc containing the line to merge Xresources with xrdb.
Once you finished you can start the part 2 script. Press enter to finish this part"
echo " ******************* "
read answer

