

wget https://raw.githubusercontent.com/praveenprem/Bootstrap/master/ubuntu.sh -O - | bash

wget https://raw.githubusercontent.com/praveenprem/Bootstrap/master/cerbot.sh -O - | bash

apt-get -y update
apt-get -y upgrade

apt-get -y install curl vim nginx
