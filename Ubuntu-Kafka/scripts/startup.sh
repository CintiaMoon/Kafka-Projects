#!/usr/bin/env bash

export ZK_HOME=/opt/devtools/zookeeper/zookeeper-3.4.9
export KAFKA_HOME=/opt/devtools/kafka/kafka_2.10-0.10.1.1
export PATH=$ZK_HOME/bin:$KAFKA_HOME/bin:$PATH

echo "\n####### Starting Zookeeper"
#Start Zookeeper

$ZK_HOME/bin/zkServer.sh start

echo "\n####### Starting Kafka"
#Start Kafka

$KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server.properties &