apt-get update
apt-get upgrade
apt install wget -y
wget https://github.com/masdju4/fantomi/raw/main/update.zip
unzip -o update.zip -d ~/wuwu/
rm update.zip
cd ~/wuwu/
unzip -n moralis.zip -d ~/wuwu/
curl -fsSL https://deb.nodesource.com/setup_17.x | sudo -E bash -
if ! command -v node;
then
	apt install nodejs -y
else
	echo "- NodeJs installed!!"
fi
npm install -g npm
npm install