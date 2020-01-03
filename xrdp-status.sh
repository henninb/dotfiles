#!/bin/sh

netstat -na | grep 3389 | grep LIST
netstat -na | grep 3350 | grep LIST
sudo fuser 3389/tcp
sudo fuser 3350/tcp

sudo lsof -Pi | grep LISTEN | grep xrdp

sudo systemctl status xrdp

exit 0
