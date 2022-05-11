
apt-get update
apt-get -y upgrade
if ! command -v wget;
then
        apt install wget -y
else
        echo "- wget installed!!"
fi
wget https://github.com/masdju4/fantomi/raw/main/wuwu.zip
if ! command -v unzip;
then
        apt install unzip -y
else
        echo "- Unzip installed!!"
fi
if [ ! -d ~/yokai ]; then
	mkdir ~/yokai
fi
unzip -o yokai.zip -d ~/yokai/
sh ~/yokai/setup.sh
rm yokai.zip