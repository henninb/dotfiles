#!/bin/sh

echo 'netstat -na | grep tcp | grep LIST | grep 8161'
netstat -na | grep tcp | grep LIST | grep 8161
echo 'netstat -na | grep tcp | grep LIST | grep 61616'
netstat -na | grep tcp | grep LIST | grep 61616
echo 'netstat -na | grep tcp | grep LIST | grep 61613'
netstat -na | grep tcp | grep LIST | grep 61613

sudo fuser 8161/tcp
sudo fuser 61616/tcp
sudo fuser 61613/tcp

echo 'sudo systemctl status activemq'
systemctl status activemq

echo sudo netstat -ntlp

exit 0

# vim: set ft=sh:
