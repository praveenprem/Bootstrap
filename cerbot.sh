wget https://raw.githubusercontent.com/praveenprem/Bootstrap/master/ubuntu.sh -O - | bash

add-apt-repository ppa:certbot/certbot -y

apt-get update -y

apt-get install python-certbot-nginx -y
