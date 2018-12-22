wget https://raw.githubusercontent.com/praveenprem/Bootstrap/master/ubuntu.sh -O - | bash

apt-get -y remove docker docker-engine docker.io

apt-get -y update

apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

apt-key fingerprint 0EBFCD88

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
   
apt-get -y update

apt-get -y install docker-ce
