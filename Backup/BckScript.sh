#!/bin/sh

BASE_DIR="/home/maky"
ACTUAL_BASE_DIR=$BASE_DIR

BASE_DEST_DIR=$(df -h | awk '{print $6}' | tail -n 1)'/Backup'
CURRENTDATE=`date +"%Y_%m_%d"`
DEST_DIR=$BASE_DEST_DIR'/Lenovo_'$CURRENTDATE


echo -e "The backup will be stored in: "
echo $DEST_DIR
echo "If the destination directory is not correct try to check that the driver is properly mounted"
echo "Is the directory correct?(Y/N)"
read ANSWER

if [ $ANSWER = 'N' -o $ANSWER = 'n' ]
then
   exit 1 
fi

function backup_dir(){
    ACTUAL_DIR=$1
    SOURCE_DIR="$ACTUAL_BASE_DIR/$ACTUAL_DIR"
    echo -e "\n =========================================="
    echo "SOURCE DIR: $SOURCE_DIR"
    echo "DEST_DIR: $DEST_DIR"
    echo -e " ========================================== \n"
    rsync -rav --exclude-from='rsync_exclude.txt' $SOURCE_DIR $DEST_DIR
}

while IFS= read -r line; do
    FIRST_CHAR=${line:0:1}
    if [[ $FIRST_CHAR = '[' ]]; then
        INNER_STRING=${line:1:${#line}-2}
        if [[ $INNER_STRING = '' ]]; then
            ACTUAL_BASE_DIR=$BASE_DIR
        else
            ACTUAL_BASE_DIR="$BASE_DIR/$INNER_STRING"
        fi
    elif [[ $FIRST_CHAR != '' ]]; then
        echo $line
        backup_dir $line
    else
        echo "Empty line!"
    fi
done < rsync_list.txt

