# OpenSSH Upgrade
wget https://raw.githubusercontent.com/praveenprem/Bootstrap/master/resources/sshd_config -O /tmp/sshd_config
mv /tmp/sshd_config /etc/ssh/sshd_config
service ssh restart

wget https://github.com/praveenprem/sshauth/releases/download/v1.1.0/sshauth-1.1.0-binary.tar.gz -O- | tar -xzvf -
mv sshauth /usr/local/bin/
chmod +x /usr/local/bin/sshauth
mkdir -p /etc/sshauth/
mv config.yml /etc/sshauth/
