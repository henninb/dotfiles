#!/bin/sh

export PATH=/opt/kafka-client/bin:$PATH

if [ ! -f "kafka_2.12-1.1.1.tgz" ]; then
  wget https://archive.apache.org/dist/kafka/1.1.1/kafka_2.12-1.1.1.tgz
  tar xvf kafka_2.12-1.1.1.tgz
  sudo mv kafka_2.12-1.1.1 /opt/kafka-client
fi



echo 'kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic ynot'
echo kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic ynot

exit 0
