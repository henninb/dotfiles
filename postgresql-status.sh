#!/bin/sh

sudo systemctl status postgresql
netstat -na | grep tcp | grep LIST | grep 5432
sudo fuser 5432/tcp

exit 0
