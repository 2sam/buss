#!/bin/zsh

if [[ ! $(id -u -n) == root ]]; then echo "run as root"; exit 1; fi

DATE=$(date +"%Y%m%d%H%M")
BACKUP_DIR=$(pwd)/$DATE
if [[ -d "$1" ]]; then BACKUP_DIR=$1/$DATE; fi
LOGFILE=$BACKUP_DIR/backup.log



# bu_dir DIR EXCLUDE_DIR1 EXCLUDE_DIR2...
bu_dir(){
  excludes=()
  for d in "${@:2}"; do 
    excludes+=(--exclude "$d")
  done

  echo "${excludes[@]}"

  echo -n "backing up $1 ... "
  echo "backing up $1 ..." >> $LOGFILE
  
  # remove leading / if necessary
  tar cpjf $(echo $BACKUP_DIR/$(echo $1 | sed "s/\//_/g").tar.bz2 | sed "s/\/\//\//g") "${excludes[@]}" $1 &>> $LOGFILE
  echo "done"
}

mkdir -p $BACKUP_DIR
touch $LOGFILE

bu_dir /etc /etc/systemd /etc/ssh
