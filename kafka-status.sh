#!/bin/sh

echo "netstat -na | grep LISTEN | grep tcp | grep 9092"
netstat -na | grep LISTEN | grep tcp | grep 9092
echo "netstat -na | grep LISTEN | grep tcp | grep 2181"
netstat -na | grep LISTEN | grep tcp | grep 2181

sudo fuser 2181/tcp
sudo fuser 9092/tcp
sudo fuser 9093/tcp

echo 'kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic ynot'
kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic ynot

echo 'kafka-topics.sh --delete --zookeeper localhost:2181 --topic ynot'
kafka-topics.sh --delete --zookeeper localhost:2181 --topic ynot

exit 0

# vim: set ft=sh:

