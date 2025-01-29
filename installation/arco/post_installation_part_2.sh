#!/bin/bash

# Arco post installation part 2.

sw_list_snap="./softwares_lists/snap"
snap_install="sudo snap install"
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

