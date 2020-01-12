#!/bin/sh

if [ "$OS" = "Gentoo" ]; then
  rc-service xrdp status
else
  sudo systemctl status xrdp
fi

netstat -na | grep 3389 | grep LIST
netstat -na | grep 3350 | grep LIST
sudo fuser 3389/tcp
sudo fuser 3350/tcp
sudo lsof -Pi | grep LISTEN | grep xrdp

exit 0
