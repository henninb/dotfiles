#!/bin/sh

scala_version=2.13
kafka_version=3.3.1

export PATH=/opt/kafka-client/bin:$PATH

if [ ! -f "$HOME/tmp/kafka_${scala_version}-${kafka_version}.tgz" ]; then
  wget https://archive.apache.org/dist/kafka/${kafka_version}/kafka_${scala_version}-${kafka_version}.tgz -O "$HOME/tmp/kafka_${scala_version}-${kafka_version}.tgz"
  cd /opt/kafka-client
  sudo rm -rf /opt/kafka-client
  tar xvf "$HOME/tmp/kafka_${scala_version}-${kafka_version}.tgz"
  sudo mv kafka_${scala_version}-${kafka_version} /opt/kafka-client
fi

echo kafka-topics.sh --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic ynot
echo kafka-topics.sh --bootstrap-server localhost:9092 --list

which kafka-topics.sh

exit 0

# vim: set ft=sh
