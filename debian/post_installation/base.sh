#!/bin/bash

DEBIAN_SCRIPTS="$HOME/PersonalHome/Scripts/debian"
MY_APPS="$HOME/PersonalHome/Scripts/MyApps"

install_my_suckless() {
  local package=$1
  cd $HOME/packages/$1
  rm ./config.h
  sudo make install
  cd -
}

# Download the suckless and the dotfiles repository from github
mkdir p $HOME/packages/
echo "Cloning suckless folder from github"
git clone https://github.com/marcocappelloni/suckless.git $HOME/packages

echo "Cloning dotfiles folder from github"
git clone https://github.com/marcocappelloni/dotfiles.git $HOME

# Install first group of packages, the essential one
echo "Installing base packages..."
bash ./install_apps.sh "./base_packages.txt"

# Create the remaining directories structure inside HOME
echo "Creating the default user home directories"
bash ./create_usr_directories.sh

#install the packages needed for DWM that are inside the debian repository
echo "Installing dwm packages..."
bash ./install_apps.sh "./dwm_packages.txt"

echo "Installing my version of dwm"
install_my_suckless "dwm"
echo "Installing my version of dmenu"
install_my_suckless "dmenu"
echo "Installing my version of slstatus"
install_my_suckless "slstatus"
echo "Installing my version of st"
install_my_suckless "st"

# installing brave software
echo "Installing brave browser"
curl -fsS https://dl.brave.com/install.sh | sh

# simlink myapps
echo "Creating symlinks for My Apps"
bash $MY_APPS/install_my_scripts.sh

# install geany
echo "Installing Geany"
bash $DEBIAN_SCRIPTS/geany_install.sh

# install libreoffice
echo "Installing Libre Office"
bash $DEBIAN_SCRIPTS/libreoffice.sh

# install the common packages
echo "Installing common packages..."
bash ./install_apps.sh "./common_packages.txt"

#install the app list packages
echo "Installing app_list packages..."
bash ./install_apps.sh "./apps_list.txt"

# Enable services
echo "Enabling services"
sudo systemctl enable avahi-daemon
sudo systemctl enable acpid

#Fixing bat
echo "Is bat in any of the bin directories? (Y/N):"
echo "$(whereis bat)"
read answer
if [[ ! "$answer" =~ ^[Y/y]$ ]]; then
  ln -s /usr/bin/batcat $HOME/.local/bin/bat
fi

# Install additional scripts
echo "Installing audio"
bash $DEBIAN_SCRIPTS/audio.sh
echo "Installing bluetooth"
bash $DEBIAN_SCRIPTS/bluetooth.sh
echo "Installing flatpak"
bash $DEBIAN_SCRIPTS/flatpak.sh
echo "Installing lightdm"
bash $DEBIAN_SCRIPTS/lightdm.sh
echo "Installing nerdfonts"
bash $DEBIAN_SCRIPTS/nerdfonts.sh
echo "Installing picom"
bash $DEBIAN_SCRIPTS/picom.sh
echo "Installing printers"
bash $DEBIAN_SCRIPTS/printers.sh
echo "Installing snap"
bash $DEBIAN_SCRIPTS/snap.sh
echo "Installing wifi applet"
bash $DEBIAN_SCRIPTS/wifi_applet_systray.sh
echo "Adding bash options and aliases"
bash $DEBIAN_SCRIPTS/bash/bash_options.sh

#installing yazi
echo "Installing yazi"
bash $DEBIAN_SCRIPTS/yazi.sh
