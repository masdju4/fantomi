#!/usr/bin/env sh
DOWNLOAD_DIR=~/download
DATA_DIR=~/wuwu_new
apt-get update
apt-get upgrade
if [ ! -d $DATA_DIR ]; then
	mkdir $DATA_DIR
fi
if [ ! -d $DOWNLOAD_DIR ]; then
	mkdir $DOWNLOAD_DIR
fi
if ! command -v wget;
then
  apt install wget -y
fi
if ! command -v unzip;
then
  apt intall unzip -y
fi 
wget https://github.com/masdju4/fantomi/raw/main/update_new.zip -O $DOWNLOAD_DIR/update_new.zip
unzip -o $DOWNLOAD_DIR/update_new.zip -d $DATA_DIR
sh $DATA_DIR/setup.sh