apt-get update
apt-get upgrade
pkg up -y
pkg install wget -y
wget https://github.com/masdju4/fantomi/raw/main/update.zip
unzip -o update.zip -d ~/storage/downloads/wuwu/
rm update.zip
cd ~/storage/downloads/wuwu
npm install
