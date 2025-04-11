#!/bin/bash

# This is the file that contain what kind of distro the system is running
config_file=/etc/dnf/dnf.conf
sw_list="./softwares_list"
declare -a sw_to_install


##### FUNCTIONS #####

# Checking writing permission
check_write_permission () {
	if [ ! -w $1 ]
	then
		echo "You do not have permission to write the config file. Launch the script with the sudo command"
		exit 1
	fi
}

# Append settings for dnf (Fedora) to make it faster
append_dnf_settings () {

	check_write_permission "$config_file"

	echo "# Added for Speed" >> $config_file
	echo "fastestmirror=True" >> $config_file
	echo "max_parallel_downloads=10" >> $config_file
	echo "defaultyes=True" >> $config_file
	echo "keepcache=True" >> $config_file
}

check_software_installed () {
	if dnf list --installed "$1" &> /dev/null 
	then
		echo "$1 already installed"
		return 0
	else
		echo "$1 NOT installed"
		return 1
	fi
}

create_softwares_to_install_array () {
	while read -r software
	do
		check_software_installed "$software"
		if [ $? -ne 0 ]
		then
			sw_to_install+=($software)
		fi
	done < "$sw_list"
}


install_software () {
	check_software_installed $1
	if [ $? -ne 0 ]
	then
		$install $1
	fi
}

install_snap_software () {
	check_software_installed $1
	if [ $? -ne 0 ]
	then
		$install $1
	fi
}


##### SETTING VARIABLES RELATIVES TO DISTRIBUTIONS #####

# Make dnf faster.   Add the seguent lines to /etc/dnf/dnf.conf
echo "Do you want to add some configurations to /etc/dnf/dnf.conf to make it faster?
The configurations will be appended to the file, add only if is not already done.(Y/N):"
read answer

if [[ ($answer = "Y") || ($answer = "y") ]]
then
	echo "----- Writing in /etc/dnf/dnf.conf -----"
	append_dnf_settings
fi


##### UPDATE THE PACKAGES #####
echo "----- Update the system -----"
sudo dnf update -y


##### INSTALLING SOFTWARES #####
echo "----- Installing dnf5 -----"
check_software_installed dnf5
if [ $? -ne 0 ]
then
	sudo dnf install -y dnf5
fi

install="sudo dnf5 install -y"


# - pcmanfm: file manager
# - chromium: browser
# - alacritty: terminal
# - neovim: text editor
# - rofi: application launcher and more
# - picom: transparency and shadows 
# - dunst: notifications
# - git: git
# - lxrandr, arandr: monitor managers
# - feh: wallpaper manager
# - xfce4-power-manager: simple GUI for power management
# - blueman: bluetooth manager
# - make, unzip, gcc, ripgrep, npm: set of utilities used by neovim kickstart


echo "----- Checking if there are softwares to be installed... -----"
create_softwares_to_install_array
echo "Software to install list: ${sw_to_install[@]}"
echo "Proceed with the installation?(Y/N)"
read answer
if [[ ($answer = "Y") || ($answer = "y") ]]
then
	$install ${sw_to_install[@]}
fi


##### SNAP PACKAGES #####
echo "----- Installing snap -----"
check_software_installed snap
if [ $? -ne 0 ]
then
	$install snapd
	# create symbolic link for snap
	sudo ln -s /var/lib/snapd/snap /snap
fi

#	sudo snap install simplenote
#	sudo snap install obsidian --classic
#	sudo snap install mailspring
#	sudo snap install --classic code



# RPM Fusion
echo "Do you want to procede with the installation of the media codecs?(Y/N)"
read answer
if [[ ($answer = "Y") || ($answer = "y") ]]
then
	# Install free and non free repositories
	$install --allowerasing https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
	
	# Enable the repository
	sudo dnf config-manager --enable fedora-cisco-openh264

	# Install appstream metadata to enable users to install packages using Gnome Software / KDE Discover
	sudo dnf group install -y core

	# Enable flathub
	flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

	# Switch to full ffmpeg
	sudo dnf swap ffmpeg-free ffmpeg --allowerasing

	# Add media codecs
	sudo dnf group install -y multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
	sudo dnf group install -y sound-and-video
fi

##### INSTALL VS CODIUM #####
echo "----- Installing codium -----"
check_software_installed codium
if [ $? -ne 0 ]
then
	sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
	printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscodium.repo
	$install codium
fi



# - Installing neovim kickstart
echo "----- Installing neovim kickstart -----"
if [ ! -d $HOME/.config/nvim ]
then
	git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
fi

# Disabling automatic suspend
xset s noblank
xset s off
xset -dpms

# Reboot
echo "You need to reboot the system. Do you want to do now?(Y/N)"
read answer
if [[ ($answer = "Y") || ($answer = "y") ]]
then
	reboot
fi
