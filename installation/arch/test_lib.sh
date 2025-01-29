#!/bin/bash

sw_to_install=()
while read -r software
do
	pacman -Q "$software"
	status=$?
#	echo $status
	if [ $status -gt 0 ]
	then
		echo "$software - NOT installed"
		sw_to_install+=($software)
	#else
	#	echo "$software - already installed"
	fi
done < "$1"
