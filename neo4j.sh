# Pre-requisites
wget --no-cache https://raw.githubusercontent.com/praveenprem/Bootstrap/master/java8.sh -O- | bash

wget --no-cache -O - https://debian.neo4j.org/neotechnology.gpg.key | sudo apt-key add -
echo 'deb https://debian.neo4j.org/repo stable/' | tee -a /etc/apt/sources.list.d/neo4j.list

apt-get -y update
apt-get -y install neo4j

service neo4j enable
service neo4j start
