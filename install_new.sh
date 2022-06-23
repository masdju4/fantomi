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
wget https://github.com/masdju4/fantomi/raw/main/wuwu_new.zip -O $DOWNLOAD_DIR/wuwu_new.zip
unzip $DOWNLOAD_DIR/wuwu_new.zip -d $DATA_DIR
sed -i "1 i\DATA_DIR=$DATA_DIR" $DATA_DIR/setup.sh
sh $DATA_DIR/setup.sh