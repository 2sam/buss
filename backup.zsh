#!/bin/zsh

BACKUP_DIR=$(pwd)
if [[ -d "$1" ]]; then BACKUP_DIR="$1"; fi

DATE=$(date +"%Y%m%d%H%M")

b_dir(){
  #tar cpjf 
  echo $DATE
  echo $BACKUP_DIR
  echo $BACKUP_DIR/$DATE$(echo $1 | sed "s/\//_/g").tar.bz2
}

b_dir /etc
