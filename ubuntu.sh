apt-get -y update
apt-get -y upgrade

apt-get install software-properties-common -y
apt-get -y update

apt-get -y install vim wget

locale-gen --purge en_GB.UTF-8
dpkg-reconfigure --frontend noninteractive locales
