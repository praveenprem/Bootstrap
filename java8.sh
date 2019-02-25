# Pre-requisites
apt-get -y update
apt-get -y upgrade
apt install software-properties-common

# Java 8 installation
add-apt-repository -y ppa:webupd8team/java

apt-get -y update

echo 'oracle-java8-installer shared/accepted-oracle-license-v1-1 boolean true' | debconf-set-selections

DEBIAN_FRONTEND=noninteractive apt-get -y install oracle-java8-installer

export JAVA_HOME=/usr/lib/jvm/java-8-oracle/

export PATH=$JAVA_HOME/bin:$PATH

echo "export JAVA_HOME=/usr/lib/jvm/java-8-oracle/" >> ~/.bashrc

echo "export PATH=$JAVA_HOME/bin:$PATH" >> ~/.bashrc

source ~/.bashrc

java -version
