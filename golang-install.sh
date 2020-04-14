#!/bin/sh

VER=$(curl -s https://golang.org/VERSION?m=text)

if [ ! -f "${VER}.linux-amd64.tar.gz" ]; then
  wget "https://dl.google.com/go/${VER}.linux-amd64.tar.gz"
fi
tar xvf "${VER}.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo mv -v go /usr/local
go version

exit 0
