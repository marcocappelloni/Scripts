#!/bin/sh

#Installation and configuration of "pass" the standard unix password manager

echo -e "\n"
echo "----- Installing PASS -----"
echo -e "\n"
sudo pacman -S pass

echo -e "\n"
echo "Do you want install dmenu and xclip? (Y/N)"
read ANSWER
if [ $ANSWER = 'Y' -o $ANSWER = 'y' ]
then
    echo -e "\n"
    echo "----- Installing dmenu and xclip -----"
    echo -e "\n"
    sudo pacman -S dmenu xclip
fi

echo -e "\n"
echo "Do you want generate the key? (Y/N)"
read ANSWER
if [ $ANSWER = 'Y' -o $ANSWER = 'y' ]
then
    echo -e "\n"
    echo "----- Generating the gpg key -----"
    echo -e "\n"
    gpg --full-generate-key
fi

echo -e "\n"
echo "Insert the gpg key generated: "
read GPGKEY
pass init \"$GPGKEY\"