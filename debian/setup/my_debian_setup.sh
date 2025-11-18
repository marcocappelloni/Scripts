#!/bin/bash

SETUP_SCRIPTS="$HOME/PersonalHome/Scripts/debian/setup/setup_scripts"
SOFTWARE_LISTS_FILES="$HOME/PersonalHome/Scripts/debian/setup/software_lists/"
DEBIAN_BASE="$HOME/PersonalHome/Scripts/debian"
MY_APPS="$HOME/PersonalHome/Scripts/MyApps"
TEMP_DIR="/tmp/setup_$$"
LOG_FILE="$HOME/setup.log"

source $SETUP_SCRIPTS/utilities.sh

question "Did you clone the git repositories? (Y/N)"
read answer
if [[ ! "$answer" =~ ^[Yy]$ ]]; then
  warning "Clone the git repositories using the script clone_repositories.sh before executing this script."
  exit 0
fi

# LOGGING AND CLEANUP

# Every subsequent echo or command output or error is sent to the log file
# while also displaying it on the terminal.
exec > >(tee -a "$LOG_FILE") 2>&1
# The trap command tells the shell to execute a specific command when a signal is received.
# By using EXIT, it sets up a cleanup routine that runs no matter how the script ends
# whether it finishes successfully, encounters an error, or is interrupted (e.g., by pressing Ctrl+C)
trap "rm -rf $TEMP_DIR" EXIT

install_my_suckless() {
  local package=$1
  cd $HOME/packages/suckless/$1
  rm ./config.h
  sudo make install
  cd -
}

#----------------------------------------------------------------------------------------------------------------------------------
#msg "Downloading display manager installer..."
#wget -O "$TEMP_DIR/install_lightdm.sh" "https://codeberg.org/justaguylinux/butterscripts/raw/branch/main/system/install_lightdm.sh"
#chmod +x "$TEMP_DIR/install_lightdm.sh"
#msg "Running display manager installer..."
## Run in current terminal session to preserve interactivity
#bash "$TEMP_DIR/install_lightdm.sh"
#----------------------------------------------------------------------------------------------------------------------------------

# Create the default user directories
xdg-user-dirs-update

# Install first group of packages, the essential one
msg "Installing base packages..."
bash $SETUP_SCRIPTS/install_apps.sh "$SOFTWARE_LISTS_FILES/1_base_packages.txt"

# Install the packages needed for the windows managers that are inside the debian repository
msg "Installing packages used by the window managers..."
bash $SETUP_SCRIPTS/install_apps.sh "$SOFTWARE_LISTS_FILES/2_wm_packages.txt"

# Install common packages
msg "Installing common packages..."
bash $SETUP_SCRIPTS/install_apps.sh "$SOFTWARE_LISTS_FILES/3_common_packages.txt"

# Install common packages
msg "Installing last set of packages..."
bash $SETUP_SCRIPTS/install_apps.sh "$SOFTWARE_LISTS_FILES/4_apps_list.txt"

# Symlink the dotfiles using stow
bash $SETUP_SCRIPTS/dotfiles.sh

msg "Installing my version of dmenu"
install_my_suckless "dmenu"

question "Do you want to install dwm? (Y/N)"
read answer
if [[ "$answer" =~ ^[Yy]$ ]]; then
  msg "Installing my version of dwm"
  install_my_suckless "dwm"
  msg "Installing my version of slstatus"
  install_my_suckless "slstatus"
  msg "Installing my version of dwmblocks-async"
  install_my_suckless "dwmblocks-async"
fi

question "Do you want to install st? (Y/N)"
read answer
if [[ "$answer" =~ ^[Yy]$ ]]; then
  msg "Installing my version of st"
  install_my_suckless "st"
fi

# installing brave software
msg "Installing brave browser"
curl -fsS https://dl.brave.com/install.sh | sh

# simlink myapps
msg "Creating symlinks for My Apps"
bash $MY_APPS/install_my_scripts.sh

# install geany
bash $SETUP_SCRIPTS/geany_install.sh

# install libreoffice
bash $SETUP_SCRIPTS/libreoffice.sh

# Enable services
msg "Enabling services"
sudo systemctl enable avahi-daemon
sudo systemctl enable acpid

#Fixing bat
question "Is bat in any of the bin directories? (Y/N):"
question "$(whereis bat)"
read answer
if [[ ! "$answer" =~ ^[Y/y]$ ]]; then
  ln -s /usr/bin/batcat $HOME/.local/bin/bat
fi

# Install additional scripts
bash $SETUP_SCRIPTS/audio.sh
bash $SETUP_SCRIPTS/bluetooth.sh
bash $SETUP_SCRIPTS/flatpak.sh
bash $SETUP_SCRIPTS/lightdm.sh
bash $SETUP_SCRIPTS/nerdfonts.sh
bash $SETUP_SCRIPTS/picom.sh
bash $SETUP_SCRIPTS/printers.sh
bash $SETUP_SCRIPTS/snap.sh
bash $SETUP_SCRIPTS/wifi_applet_systray.sh
bash $DEBIAN_BASE/bash/bash_options.sh
bash $SETUP_SCRIPTS/cheat_sheet_client.sh
bash $SETUP_SCRIPTS/install_appimage.sh
bash $SETUP_SCRIPTS/snap_packages.sh

bash $SETUP_SCRIPTS/yazi.sh
