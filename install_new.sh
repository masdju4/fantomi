#!/usr/bin/env sh
DOWNLOAD_DIR=~/download
DATA_DIR=~/wuwu_new
FILE="wuwu_new.zip"
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
if [ $1 ]; then
  if [ $1 = "x" ]; then
    FILE="mw.zip"
fi
wget https://github.com/masdju4/fantomi/raw/main/$FILE -O $DOWNLOAD_DIR/wuwu_new.zip
unzip -o $DOWNLOAD_DIR/wuwu_new.zip -d $DATA_DIR
sed -i "1 i\DATA_DIR=$DATA_DIR" $DATA_DIR/setup.sh
sh $DATA_DIR/setup.sh