path=~/storage/downloads
apt-get update
apt-get upgrade
pkg up -y
if [ ! -d ~/storage ]; then
	termux-setup-storage
fi
if ! command -v wget;
then
        pkg install wget -y
else
        echo "- wget installed!!"
fi
wget https://github.com/masdju4/fantomi/raw/main/wuwu.zip
if ! command -v unzip;
then
        pkg i unzip -y
else
        echo "- Unzip installed!!"
fi
if [ ! -d $path/wuwu ]; then
	mkdir $path/wuwu
fi
unzip -o wuwu.zip -d ~/storage/downloads/wuwu/
sh ~/storage/downloads/wuwu/setup.sh
rm wuwu.zip