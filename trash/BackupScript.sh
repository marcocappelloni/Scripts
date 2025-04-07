#!/bin/sh

#rsync -av --exclude-from='rsync_exclude.txt' /home/maky '/run/media/maky/TOSHIBA EXT/Backup/BackupManjaro/Home/'

# Backup of the home directory inside the external hard drive of 500 GB
# sudo rsync -rtpogvP --progress --delete --exclude={/home/maky/.cache/*,/home/maky/.local/share/Trash/# *,/home/lost+found/*,/home/maky/Downloads/*} /home /run/media/maky/Elements/RsyncHomeBackup | grep # # failed

function backup_config(){
  mkdir -vp '/run/media/maky/TOSHIBA EXT/Backup/BackupManjaro/Home/'${NEWDIRECTORY}/.config/$1
  rsync -av /home/maky/.config/$1 '/run/media/maky/TOSHIBA EXT/Backup/BackupManjaro/Home/'${NEWDIRECTORY}/.config
}

echo -e "\n"
echo "Do you want remove the old backup? (Y/N)"
read ANSWER
if [ $ANSWER = 'Y' -o $ANSWER = 'y' ]
then
    rm -rfv '/run/media/maky/TOSHIBA EXT/Backup/BackupManjaro/Home'/*
    echo -e "\n"
    echo "Old backup removed."
fi

echo -e "\n"
echo "Proceed with the backup? (Y/N)"
read ANSWER
if [ $ANSWER = 'Y' -o $ANSWER = 'y' ]
then
    CURRENTDATE=`date +"%Y_%m_%d"`
    NEWDIRECTORY=${CURRENTDATE}_maky
    mkdir -v '/run/media/maky/TOSHIBA EXT/Backup/BackupManjaro/Home/'${NEWDIRECTORY}
    rsync -av --exclude-from='rsync_exclude.txt' /home/maky/ '/run/media/maky/TOSHIBA EXT/Backup/BackupManjaro/Home/'${NEWDIRECTORY}
    backup_config nvim
    backup_config alacritty
    backup_config ranger
    backup_config rofi
    backup_config awesome
    backup_config i3
    backup_config i3status
    backup_config picom.conf
    backup_config polybar
    backup_config powerline-shell
    #mkdir -vp '/run/media/maky/TOSHIBA EXT/Backup/BackupManjaro/Home/'${NEWDIRECTORY}/.config/nvim
    #rsync -av /home/maky/.config/nvim '/run/media/maky/TOSHIBA EXT/Backup/BackupManjaro/Home/'${NEWDIRECTORY}/.config
    #rsync -av /home/maky/.config/nvim '/run/media/maky/TOSHIBA EXT/Backup/BackupManjaro/Home/'${NEWDIRECTORY}/.config
    mkdir -vp '/run/media/maky/TOSHIBA EXT/Backup/BackupManjaro/Home/'${NEWDIRECTORY}/bookmars_chromium
    cp -fv /home/maky/.config/chromium/Default/Bookmarks '/run/media/maky/TOSHIBA EXT/Backup/BackupManjaro/Home/'${NEWDIRECTORY}/bookmars_chromium
    # mkdir -vp '/run/media/maky/TOSHIBA EXT/Backup/BackupManjaro/Home/'${NEWDIRECTORY}/.config/$1
    rsync -av /home/maky/.dotfiles/.config '/run/media/maky/TOSHIBA EXT/Backup/BackupManjaro/Home/'${NEWDIRECTORY}/.dotfiles/.config

fi
