export LANGUAGE=en_UK.UTF-8
export LANG=en_UK.UTF-8
export LC_ALL=en_UK.UTF-8
locale-gen en_UK.UTF-8
dpkg-reconfigure locales
apt-get -y update
apt-get -y upgrade
apt-get -y install git vim software-properties-common wget

add-apt-repository -y ppa:webupd8team/java
apt-get -y update
echo 'oracle-java8-installer shared/accepted-oracle-license-v1-1 boolean true' | debconf-set-selections
DEBIAN_FRONTEND=noninteractive apt-get -y install oracle-java8-installer

export JAVA_HOME=/usr/lib/jvm/java-8-oracle/
export PATH=$JAVA_HOME/bin:$PATH

echo "export JAVA_HOME=/usr/lib/jvm/java-8-oracle/" >> ~/.bashrc
echo "export PATH=$JAVA_HOME/bin:$PATH" >> ~/.bashrc
source .bashrc

wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
echo "deb https://pkg.jenkins.io/debian-stable binary/" >> /etc/apt/sources.list
apt-get -y update
apt-get -y install jenkins
