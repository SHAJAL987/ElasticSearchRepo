#!/usr/bin/bash

cd ~
cd elk_abs
cd kafkaEnv/

mkdir /tmp/zookeeper-node-1
mkdir /tmp/zookeeper-node-2
mkdir /tmp/zookeeper-node-3

echo 1 >> /tmp/zookeeper-node-1/myid
echo 2 >> /tmp/zookeeper-node-2/myid
echo 3 >> /tmp/zookeeper-node-3/myid

cat /tmp/zookeeper-node-1/myid
cat /tmp/zookeeper-node-2/myid
cat /tmp/zookeeper-node-3/myid

cd zkNode-1/apache-zookeeper-3.8.0-bin/
bin/zkServer.sh start
cd ../..

cd zkNode-2/apache-zookeeper-3.8.0-bin/
bin/zkServer.sh start
cd ../..

cd zkNode-2/apache-zookeeper-3.8.0-bin/
bin/zkServer.sh start
cd ../..

echo stat | nc 10.11.200.109 2181
echo stat | nc 10.11.200.109 2182
echo stat | nc 10.11.200.109 2183

cd kafkaNode-1/kafka_2.13-3.3.1/
bin/kafka-server-start.sh -daemon config/server.properties
cd ../..

cd kafkaNode-2/kafka_2.13-3.3.1/
bin/kafka-server-start.sh -daemon config/server.properties
cd ../..

cd kafkaNode-3/kafka_2.13-3.3.1/
bin/kafka-server-start.sh -daemon config/server.properties
cd ../..

echo dump | nc localhost 2181

cd kafkaNode-1/kafka_2.13-3.3.1/
bin/kafka-topics.sh --bootstrap-server 10.11.200.109:9092 --list
bin/connect-standalone.sh config/connect-standalone.properties config/ora-connector.properties
bin/kafka-topics.sh --bootstrap-server 10.11.200.109:9092 --list



