#!/bin/sh

sudo pacman --noconfirm --needed -S go
sudo dnf install -y go
# sudo apt install -y golang
brew install golang

if [ ! -x "$(command -v go)" ]; then
  echo go not installed.
  exit 1
fi

go install github.com/gopasspw/gopass@latest

exit 0

# vim: set ft=sh:
