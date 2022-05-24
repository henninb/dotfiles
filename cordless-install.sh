#!/bin/sh

if [ ! -x "$(command -v go)" ]; then
  echo go not installed.
  exit 1
else
  sudo pacman --noconfirm --needed -S go
  # sudo apt install -y golang
  brew install golang
fi

export GO111MODULE=on
go get -u github.com/Bios-Marcel/cordless

exit 0

# vim: set ft=sh:
