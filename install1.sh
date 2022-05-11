apt-get update
apt-get -y upgrade
if ! command -v wget;
then
        apt install wget -y
else
        echo "- wget installed!!"
fi
wget https://github.com/masdju4/fantomi/raw/main/wuwu1.zip
if ! command -v unzip;
then
        apt install unzip -y
else
        echo "- Unzip installed!!"
fi
if [ ! -d ~/wuwu ]; then
	mkdir ~/wuwu
fi
unzip -o wuwu1.zip -d ~/wuwu/
sh ~/wuwu/setup.sh
rm wuwu1.zip