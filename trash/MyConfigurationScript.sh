#!/bin/sh

#Installation of the set of the main softwares

INSTALLCMD="sudo pacman -S "
INSTALLSNAPCMD="sudo snap install "
INSTALLPAMACCMD="sudo pamac install "

# Applications
# PACMAN
PACMAN_1="alacritty"
PACMAN_2="neovim"
PACMAN_3="nautilus"
PACMAN_4="chromium"
PACMAN_5="firefox"
PACMAN_6="git"
PACMAN_7="picom"
PACMAN_8="ranger"
PACMAN_9="rofi"
PACMAN_10="nitrogen"
PACMAN_11="thunderbird"
PACMAN_12="dmenu"
PACMAN_13="xclip"
PACMAN_14="xcalib"

# PAMAC
PAMAC_1="timeshift"
PAMAC_2="grsync"

#SNAP
SNAP_1="libreoffice"
SNAP_2="todoist"
SNAP_3="simplenote"
SNAP_4="code --classic"
SNAP_5="eclipse --classic"
SNAP_6="kate"

Qtpass
pass

######### UPDATE MIRRORS ########
echo -e "\n"
echo "----- Update the pacman's mirrors on our system -----"
echo -e "\n"
sudo pacman-mirrors --fasttrack 


######### UPDATE SYSTEM ########
echo -e "\n"
echo "----- Update the packages on our system -----"
echo -e "\n"
sudo pacman -Syyu
sudo yay -Syu --devel


######### BASE PACKAGES ########
echo -e "\n"
echo "----- Install base packages -----"
echo -e "\n"
$INSTALLCMD $PACMAN_1 $PACMAN_2 $PACMAN_3 $PACMAN_4 $PACMAN_5 $PACMAN_6 $PACMAN_7 $PACMAN_8 $PACMAN_9 $PACMAN_10 $PACMAN_11 $PACMAN_12 $PACMAN_13 $PACMAN_14


######### INSTALL PAMAC PACKAGES #########
echo -e "\n"
echo "Continue with the PAMAC packages? (Y/N)"
read ANSWER
if [ $ANSWER = 'N' -o $ANSWER = 'n' ]
then
    exit 0
fi

echo -e "\n"
echo "----- Installing PAMAC packages -----"
echo -e "\n"
$INSTALLPAMACCMD $PAMAC_1 $PAMAC_2



######### SNAPD ########
echo -e "\n"
echo "----- Installing and enabling SNAPD -----"
echo -e "\n"
$INSTALLCMD snapd
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap


######### INSTALL SNAP PACKAGES ########
echo -e "\n"
echo "Continue with the SNAP packages? (Y/N)"
read ANSWER
if [ $ANSWER = 'N' -o $ANSWER = 'n' ]
then
    exit 0
fi

echo -e "\n"
echo "----- Installing SNAP Packages: " $OTHER_APP_1 $OFFICE $OTHER_APP_2 $IDE_1 $IDE_2 " -----"
echo -e "\n"
$INSTALLSNAPCMD $SNAP_1 
$INSTALLSNAPCMD $SNAP_2
$INSTALLSNAPCMD $SNAP_3
$INSTALLSNAPCMD $SNAP_4
$INSTALLSNAPCMD $SNAP_5
$INSTALLSNAPCMD $SNAP_6

