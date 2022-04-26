apt-get update
apt-get upgrade
apt install wget -y
wget https://github.com/masdju4/fantomi/raw/main/update.zip
unzip -o update.zip -d ~/wuwu/
rm update.zip
cd ~/wuwu/
if ! command -v node;
then
	pkg i nodejs -y
else
	echo "- NodeJs installed!!"
fi
npm install -g npm
npm install