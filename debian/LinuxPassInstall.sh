#!/bin/sh

#Installation and configuration of "pass" the standard unix password manager

echo -e "\n"
echo "Do you want to install the packages needed? (Y/N)"
read ANSWER
if [ $ANSWER = 'Y' -o $ANSWER = 'y' ]
then
    sudo apt-get install pass dmenu xclip qtpass
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

    echo -e "\n"
    echo "Do you want to insert the gpg key? (Y/N)"
    read ANSWER
    if [ $ANSWER = 'Y' -o $ANSWER = 'y' ]
    then
        echo -e "\n"
        echo "Insert the gpg key: "
        read GPGKEY
        pass init \"$GPGKEY\"
    fi
fi

echo "Copy the \".gnupg\" and the \".password-store\" directories from the usb key to the home directory"

echo "End of the script" 
