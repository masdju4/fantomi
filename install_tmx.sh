#!/usr/bin/env sh
DOWNLOAD_DIR=~/storage/downloads
DATA_DIR=$DOWNLOAD_DIR/wuwu
apt-get update
apt-get upgrade -y
if [ ! -d $DATA_DIR ]; then
	mkdir $DATA_DIR
fi
if [ ! -d $DOWNLOAD_DIR ]; then
	mkdir $DOWNLOAD_DIR
fi
if ! command -v wget;
then
  pkg install wget -y
fi
if ! command -v unzip;
then
  pkg intall unzip -y
fi 
if [ ! -d $DOWNLOAD_DIR/wuwu.zip ]; then
	rm $DOWNLOAD_DIR/wuwu.zip
fi
wget https://github.com/masdju4/fantomi/raw/main/wuwu_tmx.zip -O $DOWNLOAD_DIR/wuwu.zip
unzip -o $DOWNLOAD_DIR/wuwu.zip -d $DATA_DIR
sed -i "1 i\DATA_DIR=$DATA_DIR" $DATA_DIR/setup.sh
sh $DATA_DIR/setup.sh