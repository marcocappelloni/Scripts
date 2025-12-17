#!/bin/bash

SCRIPT_PATH=$(dirname "${BASH_SOURCE}")
source $SCRIPT_PATH/setup_scripts/variables.sh
source $SCRIPT_PATH/setup_scripts/utilities.sh

# Comment the lines that you don't want to install
OPTIONS_LIST=(
  APPIMAGE
  AUDIO
  BASH_OPTION
  BLUETOOTH
  BRAVE
  CHEAT_SHEET
  DMENU
  DOTFILES
  FLATPAK
  GEANY
  LIBREOFFICE
  LIGHTDM
  MY_APPS
  NERD_FONTS
  PICOM
  PRINTERS
  SNAP
  #"ST"
  VIRTUAL_MACHINES
  WIFI_APPLET_SYSTRAY
  WINDOW_MANAGERS
  YAZI
)

option_found() {
  for OPT in ${OPTIONS_LIST[*]}; do
    if [[ "$OPT" == "$1" ]]; then
      return 0
    fi
  done

  return 1
}

msg "Cloning git repositories..."
$HOME/PersonalHome/Scripts/clone_repositories.sh

# LOGGING AND CLEANUP

# Every subsequent echo or command output or error is sent to the log file
# while also displaying it on the terminal.
exec > >(tee -a "$LOG_FILE") 2>&1
# The trap command tells the shell to execute a specific command when a signal is received.
# By using EXIT, it sets up a cleanup routine that runs no matter how the script ends
# whether it finishes successfully, encounters an error, or is interrupted (e.g., by pressing Ctrl+C)
trap "rm -rf $TEMP_DIR" EXIT

# Create the default user directories
xdg-user-dirs-update

# Install first group of packages, the essential one
msg "Installing base packages..."
$SETUP_SCRIPTS/install_apps.sh "${BASE_PACKAGES[*]}"

# Install common packages
msg "Installing common packages..."
$SETUP_SCRIPTS/install_apps.sh "${COMMON_PACKAGES[*]}"

# Install common packages
msg "Installing last set of packages..."
$SETUP_SCRIPTS/install_apps.sh "${APPS_LIST[*]}"

# Enable services
msg "Enabling services"
sudo systemctl enable avahi-daemon
sudo systemctl enable acpid

#Fixing bat
question "Is bat in any of the bin directories? (Y/N):"
question "$(whereis bat)"
read answer
if [[ ! "$answer" =~ ^[Yy]$ ]]; then
  mkdir -p $HOME/.local/bin
  ln -s /usr/bin/batcat $HOME/.local/bin/bat
fi

# ###############################################
# INSTALL EXTRA TOOLS AND CONFIGURATIONS
# ###############################################

if $(option_found "LIGHTDM"); then
  $SETUP_SCRIPTS/lightdm.sh
fi

if $(option_found "WINDOW_MANAGERS"); then
  # Choose and install window managers
  $SETUP_SCRIPTS/WMS/window_managers.sh
fi

if $(option_found "DOTFILES"); then
  # Symlink the dotfiles using stow
  $SETUP_SCRIPTS/dotfiles.sh
fi

if $(option_found "DMENU"); then
  # Installing my version of dmenu
  install_my_suckless "dmenu"
fi

if $(option_found "ST"); then
  install_my_suckless "st"
fi

if $(option_found "BRAVE"); then
  # installing brave software
  msg "Installing brave browser"
  curl -fsS https://dl.brave.com/install.sh | sh
fi

if $(option_found "MY_APPS"); then
  # simlink myapps
  msg "Creating symlinks for My Apps"
  $MY_APPS/install_my_scripts.sh
fi

if $(option_found "AUDIO"); then
  $SETUP_SCRIPTS/audio.sh
fi

if $(option_found "BLUETOOTH"); then
  $SETUP_SCRIPTS/bluetooth.sh
fi

if $(option_found "FLATPAK"); then
  $SETUP_SCRIPTS/flatpak.sh
fi

if $(option_found "NERD_FONTS"); then
  $SETUP_SCRIPTS/nerdfonts.sh
fi

if $(option_found "PICOM"); then
  $SETUP_SCRIPTS/picom.sh
fi

if $(option_found "PRINTERS"); then
  $SETUP_SCRIPTS/printers.sh
fi

if $(option_found "SNAP"); then
  $SETUP_SCRIPTS/snap.sh
  $SETUP_SCRIPTS/snap_packages.sh
fi

if $(option_found "WIFI_APPLET_SYSTRAY"); then
  $SETUP_SCRIPTS/wifi_applet_systray.sh
fi

if $(option_found "BASH_OPTION"); then
  $DEBIAN_BASE/bash/bash_options.sh
fi

if $(option_found "CHEAT_SHEET"); then
  $SETUP_SCRIPTS/cheat_sheet_client.sh
fi

if $(option_found "APPIMAGE"); then
  $SETUP_SCRIPTS/install_appimage.sh
fi

if $(option_found "GEANY"); then
  $SETUP_SCRIPTS/geany_install.sh
fi

if $(option_found "LIBREOFFICE"); then
  $SETUP_SCRIPTS/libreoffice.sh
fi

if $(option_found "YAZI"); then
  $SETUP_SCRIPTS/yazi.sh
fi

if $(option_found "VIRTUAL_MACHINES"); then
  $SETUP_SCRIPTS/virtual_machines.sh
fi
