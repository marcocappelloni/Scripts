#!/bin/bash

##### Script to install and configure tuned, an app to setup 
##### a profile of the power usage of the computer
##### After installing it you can also use the tuned-gui graphical app
##### to manage the same settings


echo "Installing tuned..."
sudo pacman -S tuned

echo "If tuned was already installed check the actual status of it. Check the status?(Y/N):"
read answer

if [[ ($answer = "Y") || ($answer = "y") ]]
then
    systemctl status tuned
fi

echo "Start and enable the tuned service?(Y/N):"
read answer

if [[ ($answer = "Y") || ($answer = "y") ]]
then
    echo "Starting and enabling the service..."
    systemctl start tuned
    systemctl enable tuned

    echo "Check the status:"
    systemctl status tuned
fi

echo "Check and set a new profile?(Y/N):"
read answer

if [[ ($answer = "N") || ($answer = "n") ]]
then
    exit 1
fi

echo "Available profiles:"
tuned-adm list
echo "Choose a profile to activate it or write quit to exit:"
read answer

if [[ ($answer = "quit") ]]
then
    exit 1
fi

tuned-adm profile $answer
