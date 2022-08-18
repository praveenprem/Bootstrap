echo ' __  __     __   __     __     ______   __        ______     ______     __   __     ______   ______     ______     __         __         ______     ______    '
echo '/\ \/\ \   /\ "-.\ \   /\ \   /\  ___\ /\ \      /\  ___\   /\  __ \   /\ "-.\ \   /\__  _\ /\  == \   /\  __ \   /\ \       /\ \       /\  ___\   /\  == \   '
echo '\ \ \_\ \  \ \ \-.  \  \ \ \  \ \  __\ \ \ \     \ \ \____  \ \ \/\ \  \ \ \-.  \  \/_/\ \/ \ \  __<   \ \ \/\ \  \ \ \____  \ \ \____  \ \  __\   \ \  __<   '
echo ' \ \_____\  \ \_\\"\_\  \ \_\  \ \_\    \ \_\     \ \_____\  \ \_____\  \ \_\\"\_\    \ \_\  \ \_\ \_\  \ \_____\  \ \_____\  \ \_____\  \ \_____\  \ \_\ \_\ '
echo '  \/_____/   \/_/ \/_/   \/_/   \/_/     \/_/      \/_____/   \/_____/   \/_/ \/_/     \/_/   \/_/ /_/   \/_____/   \/_____/   \/_____/   \/_____/   \/_/ /_/ '
echo '                                                                                                                                                              '

echo "Version: 5.6.42"

UNIFI_BRANCH="unifi-5.6"
UNIFI_VERSION="5.6.42"

apt update && apt upgrade -y
apt install gnupg

echo "**** add mongo repository ****"
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" >> /etc/apt/sources.list.d/mongo.list

echo "**** install packages ****"
apt-get update
apt-get install -y binutils jsvc mongodb-org-server	openjdk-8-jre-headless wget curl

echo "**** install unifi ****"
curl -o unifi.deb -L "http://dl.ubnt.com/unifi/${UNIFI_VERSION}/unifi_sysvinit_all.deb"
dpkg -i unifi.deb

echo "Completed"
