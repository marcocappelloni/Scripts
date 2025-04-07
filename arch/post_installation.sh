# INSTALL AS USER
# To do:  create and write:
# "
#	exec xrdb &
#	exec i3
# " inside .xinitrc
echo "----- Update the System -----"
sudo pacman -Syu
sudo pacman -S nano neovim neofetch btop
sudo pacman -S git 
sudo pacman -S alacritty pcmanfm ttf-inconsolata 

# To do: write a theme inside .Xresources

echo "----- configure PacMan and mirrors -----"
echo "UNCOMMENT the line with 'Color' and 'ParallelDownloads' inside the section 'Misc options' "
echo "PRESS ENTER TO CONTINUE"
read answer

sudo nano /etc/pacman.conf

sudo pacman -Sy
sudo pacman -S reflector
sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
sudo reflector --verbose --latest 10 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Sy

echo "----- Install Important Tools -----"
sudo pacman -S bluez blueman bluez-utils
sudo modprobe btusb
sudo systemctl enable bluetooth
sudo systemctl start bluetooth
sudo pacman -S p7zip unrar tar rsync git neofetch htop exfat-utils fuse-exfat ntfs-3g flac jasper aria2
sudo pacman -S jdk-openjdk amd-ucode lxappearance
sudo grub-mkconfig -o /boot/grub/grub.cfg

echo "----- Install Aur Helper & Flatpak -----"
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/yay.git
./yay/makepkg -si
sudo pacman -S flatpak

echo "----- Install GUI apps -----"
sudo pacman -S firefox libreoffice-fresh vlc thunderbird krita timeshift

echo "----- Setup firewall -----"
sudo pacman -S ufw
sudo systemctl enable ufw
sudo systemctl start ufw



startx

