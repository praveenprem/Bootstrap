logger() {
    echo "$(date '+%Y/%m/%d %H:%M:%S') ubuntu.sh: $1"
}

logger "Updating sysytem"

apt-get -y update
apt-get -y upgrade

logger "Installing common software properties"
apt-get install software-properties-common -y
apt-get -y update

apt-get -y install vim wget curl

logger "Installing language pack"
locale-gen --purge en_GB.UTF-8
dpkg-reconfigure --frontend noninteractive locales
