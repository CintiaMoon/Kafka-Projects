#!/usr/bin/env bash

echo "\n###### Installing Java ------\n"
sudo apt-get install -y python-software-properties debconf-utils
# Add the PPA
sudo add-apt-repository -y ppa:webupd8team/java
# update our packages
sudo apt-get update
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
#install Oracle Java 8 with the PPA installer
sudo apt-get install -y oracle-java8-installer

echo "###### Creating DevTools folder to store Kafka and Zookeeper"
mkdir /opt/devtools
echo "\n####### Downloading Zookeeper ------\n"
wget -nc -nv http://mirrors.dcarsat.com.ar/apache/zookeeper/zookeeper-3.4.9/zookeeper-3.4.9.tar.gz

mkdir /opt/devtools/zookeeper
tar -zxvf zookeeper-3.4.9.tar.gz --directory /opt/devtools/zookeeper

echo "\n####### Downloading Kafka ------\n"
wget -nc -nv http://mirror.fibergrid.in/apache/kafka/0.10.1.1/kafka_2.10-0.10.1.1.tgz
mkdir /opt/devtools/kafka
tar -zxvf kafka_2.10-0.10.1.1.tgz
mv kafka_2.10-0.10.1.1 /opt/devtools/kafka

echo "\n####### Configuring Exports"
export ZK_HOME=/opt/devtools/zookeeper/zookeeper-3.4.9
export KAFKA_HOME=/opt/devtools/kafka/kafka_2.10-0.10.1.1
export PATH=$ZK_HOME/bin:$KAFKA_HOME/bin:$PATH

echo "\n####### Copying zoo_sample.cfg"
cp $ZK_HOME/conf/zoo_sample.cfg $ZK_HOME/conf/zoo.cfg
sed -i 's/\/tmp\/zookeeper/\/var\/zookeeper\/data/g' $ZK_HOME/conf/zoo.cfg

echo 'server.1=192.168.33.10:2888:3888' >> /$ZK_HOME/conf/zoo.cfg
mkdir -p /var/zookeeper/data
#Zookeeper uses a file named “myid” to identify itself within the cluster. It holds a single character, 1-255. Let’s set it to 1.
echo "1" > /var/zookeeper/data/myid

echo "\n####### Configuring Kafka"
#configure kafka
sed -i 's/broker\.id\=0/broker\.id\=1/g' $KAFKA_HOME/config/server.properties

#uncomment host.name=localhost
sed -i 's/\#host.name\=localhost/host.name\=192.168.33.10/g' $KAFKA_HOME/config/server.properties
sed -i 's/zookeeper.connect=localhost:2181/zookeeper.connect=192.168.33.10:2181/g' $KAFKA_HOME/config/server.properties
sed -i 's/listeners\=PLAINTEXT\:\/\/\:9092/listeners\=PLAINTEXT\:\/\/192.168.33.10\:9092/g' $KAFKA_HOME/config/server.properties

