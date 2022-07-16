logger() {
    echo "$(date '+%Y/%m/%d %H:%M:%S') nginx.sh: $1"
}

bash <(wget -O - https://raw.githubusercontent.com/praveenprem/Bootstrap/master/ubuntu.sh)

logger "Installing Nginx"

apt-get -y update
apt-get -y upgrade
apt-get -y install nginx

logger "Nginx installation completed"

IFS= read -p "Do you want to install Certbot?: (Only accept yes) " install_certbot
if [[ $install_certbot == "yes" ]]; then
    bash <(wget -O -  https://raw.githubusercontent.com/praveenprem/Bootstrap/master/cerbot.sh)
fi
