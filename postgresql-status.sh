#!/bin/sh

if [ "$OS" = "Gentoo" ]; then
  rc-service postgresql status
else
  sudo systemctl status postgresql
fi
echo 'netstat -na | grep tcp | grep LIST | grep 5432'
netstat -na | grep tcp | grep LIST | grep 5432

echo 'sudo fuser 5432/tcp'
sudo fuser 5432/tcp

exit 0
