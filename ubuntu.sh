dpkg-reconfigure locales
apt-get -y update
apt-get -y upgrade
apt-get -y install vim

# OpenSSH Upgrade
wget https://raw.githubusercontent.com/praveenprem/Bootstrap/master/resources/sshd_config -O /tmp/sshd_config
mv /tmp/sshd_config /etc/ssh/sshd_config
service ssh restart

# Network security
ufw allow 22/tcp
ufw allow OpenSSH
ufw --force enable
