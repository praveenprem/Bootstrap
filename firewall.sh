wget https://raw.githubusercontent.com/praveenprem/Bootstrap/master/ubuntu.sh -O - | bash

apt-get -y install ufw

ufw allow 22/tcp
ufw allow OpenSSH
ufw --force enable
