cat <<EOF > /tmp/nginx.sh
logger() {
    echo "\$(date '+%Y/%m/%d %H:%M:%S') nginx.sh: \$1"
}

wget https://raw.githubusercontent.com/praveenprem/Bootstrap/master/ubuntu.sh -O /tmp/ubuntu.sh
bash /tmp/ubuntu.sh

logger "Installing Nginx"

apt-get -y update
apt-get -y upgrade
apt-get -y install nginx

logger "Nginx installation completed"

IFS= read -p "Do you want to install Certbot?: (Only accept yes) " install_certbot
if [[ \$install_certbot == "yes" ]]; then
    wget https://raw.githubusercontent.com/praveenprem/Bootstrap/master/cerbot.sh -O /tmp/certbot.sh 
    bash /tmp/certbot.sh
fi
EOF
bash /tmp/nginx.sh
