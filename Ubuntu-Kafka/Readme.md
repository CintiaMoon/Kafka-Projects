Created: 2017/02/12
Author: Cintia 

Testing Kafka Server from the host
----------------------------------
To test Kafka, create a sample topic with name "customTopic" in Apache Kafka using the following command:

Create Topic from the host
--------------------------
kafka-topics.bat --create --zookeeper 192.168.33.10:2181 --replication-factor 1  --partitions 1 --topic customTopic

List available topics on Apache Kafka from the host
---------------------------------------------------
kafka-topics.bat --list --zookeeper 192.168.33.10:2181 

You should see the following output:
customTopic


Publish a sample messages from the host
---------------------------------------
you can publish sample messages to Apache Kafka topic called customTopic by using the following producer command:
kafka-console-producer.bat --broker-list 192.168.33.10:9092 --topic customTopic

After running above command, enter some messages like "Hi how are you?" press enter, then enter another message like "Where are you?"

Consume sample messages from the host
--------------------------------------
Use consumer command to check for messages on Apache Kafka Topic called customTopic by running the following command:

kafka-console-consumer.bat --zookeeper 192.168.33.10:2181 --topic customTopic --from-beginning
You should see the following output:

Hi how are you?
Where are you?

