logger() {
    echo "$(date '+%Y/%m/%d %H:%M:%S') nginx.sh: $1"
}

wget https://raw.githubusercontent.com/praveenprem/Bootstrap/master/ubuntu.sh -O - | bash

logger "Installing Nginx"

apt-get -y update
apt-get -y upgrade
apt-get -y install nginx

IFS= read -p "Do you want to install Certbot?: (Only accept yes) " install_certbot
if [[ $install_certbot == "yes" ]]; then
    wget https://raw.githubusercontent.com/praveenprem/Bootstrap/master/cerbot.sh -O - | bash
fi
