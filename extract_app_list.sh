#!/bin/bash

sw_to_install=""

while read -r software
do
	sw_to_install+=" $software"
done < $1

echo $sw_to_install
