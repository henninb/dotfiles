#!/bin/sh

sudo pacman -S go
sudo apt install -y golang

if [ ! -x "$(command -v go)" ]; then
  echo go not installed.
  exit 1
fi

go get github.com/gokcehan/lf

exit 0
