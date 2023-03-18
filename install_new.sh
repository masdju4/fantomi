#!/usr/bin/env sh
DOWNLOAD_DIR=~/download
DATA_DIR=~/www4
OLD_DIR=~/www3
FILE="w4.zip"
apt-get update
apt-get upgrade


if [ $1 = "o" ]; then
    FILE="w3.zip"
    DATA_DIR=$OLD_DIR
fi 

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
if [ -d $DATA_DIR/log ]; then
	rm -r $DATA_DIR/log
fi
wget https://github.com/masdju4/fantomi/raw/main/$FILE -O $DOWNLOAD_DIR/wuwu_new.zip
unzip -o $DOWNLOAD_DIR/wuwu_new.zip -d $DATA_DIR
sed -i "1 i\DATA_DIR=$DATA_DIR" $DATA_DIR/setup.sh
sed -i "1 i\DATA_DIR=$DATA_DIR" $DATA_DIR/log
sh $DATA_DIR/setup.sh
