
apt-get -y update
apt-get -y upgrade
export LANGUAGE=en_UK.UTF-8
export LANG=en_UK.UTF-8
export LC_ALL=en_UK.UTF-8
locale-gen en_UK.UTF-8
dpkg-reconfigure locales

apt-get -y install vim
