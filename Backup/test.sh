#!/bin/sh

BASE_DEST_DIR=$(df -h | awk '{print $6}' | tail -n 1)'/Backup'
CURRENTDATE=`date +"%Y_%m_%d"`
DEST_DIR=$BASE_DEST_DIR'/Lenovo_'$CURRENTDATE
echo $DEST_DIR
