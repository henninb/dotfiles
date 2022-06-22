#!/bin/sh

if [ ! -x "$(command -v go)" ]; then
  echo go not installed.
  exit 1
else
  sudo pacman --noconfirm --needed -S go
  # sudo apt install -y golang
  brew install golang
fi

go env -w GO111MODULE=off
go get github.com/gokcehan/lf

exit 0

# vim: set ft=sh:

