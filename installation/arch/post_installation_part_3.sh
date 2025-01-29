#!/bin/bash


sw_list_snap="./softwares_lists/snap"
snap_install="sudo snap install"
xinitrc="$HOME/.xinitrc"
bashrc="$HOME/.bashrc"
declare -a sw_to_install

sw_to_install=()
while read -r software
do
	sw_to_install+=($software)
done < "$sw_list_snap"


##### INSTALL SNAP PACKAGES #####
echo "----- Install the snap packages -----"
echo "Software to install list: ${sw_to_install[@]}"
echo "Procede with the installation?(Y/N)"
read answer
if [[ ($answer = "Y") || ($answer = "y") ]]
then
	# with snap is better to install the packages one by one in case they have
	# some option like for example --classic
	for package in ${sw_to_install[@]}
	do
		$snap_install $package
	done
fi

##### NEOVIM KICKSTART #####
echo "----- Installing neovim kickstart -----"
if [ ! -d $HOME/.config/nvim ]
then
	git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
fi

##### .xinitrc #####
echo "----- Modify .xinitrc for Xresources -----"
if [ -f $HOME/.xinitrc ]
then
	echo "----- Check without writing if the line "
	echo "[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources"
	echo "is present inside the .xinitrc file and close the file ----"
	echo "Press enter to continue"
	read answer

	nano $xinitrc

	echo "----- Insert the missing line? (Y/N) -----"
	read answer
	if [[ ($answer = "Y") || ($answer = "y") ]]
	then
		echo "[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources" >> $xinitrc
	fi
else
	echo "[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources" >> $xinitrc
fi

##### ALIASES #####
echo "----- Aliases -----"
echo "----- Do you want to insert the aliases for bash? (Y/N) -----"
read answer
if [[ ($answer = "Y") || ($answer = "y") ]]
then
	echo "# MY ALIAS" >> $bashrc
	echo "alias dir='ls -al'" >> $bashrc
fi

