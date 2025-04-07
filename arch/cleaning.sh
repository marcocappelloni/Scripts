#!/bin/sh


echo "sudo pacman -Sc"
sudo pacman -Sc
echo "sudo pacman -Qdt"
sudo pacman -Qdt
echo "sudo journalctl --vacuum-size=50M"
sudo journalctl --vacuum-size=50M

# Vacuum journals
echo "sudo journalctl --vacuum-size=500M && sudo journalctl --vacuum-time=7d"
sudo journalctl --vacuum-size=500M && sudo journalctl --vacuum-time=7d

# Remove all uninstalled packages
echo "sudo paccache -rvuk0"
sudo paccache -rvuk0

# Remove old installed packages, leave 3
echo "sudo paccache -rvk3"
sudo paccache -rvk3

# Clean yay cache
echo "yay -Sc -a"
yay -Sc -a

# Clean pamac build cache
echo "pamac clean -bv"
pamac clean -bv

# Clean temporary build files
echo "rm -rf ~/{.bundle,.cargo,.cmake,.dotnet,.electron,.electron-gyp,.gem,.gradle,.lazarus,.node-gyp,.npm,.nuget,.nvm,.racket,.rustup,.stack,.yarn} || true"
rm -rf ~/{.bundle,.cargo,.cmake,.dotnet,.electron,.electron-gyp,.gem,.gradle,.lazarus,.node-gyp,.npm,.nuget,.nvm,.racket,.rustup,.stack,.yarn} || true
echo "rm -rf ~/.cache/{electron,electron-builder,go-build,node-gyp,pip,yarn} || true"
rm -rf ~/.cache/{electron,electron-builder,go-build,node-gyp,pip,yarn} || true
echo "sudo rm -rf ~/go || true"
sudo rm -rf ~/go || true
echo "execute also: sudo pacman -Rns \$(pacman -Qtdq)"
