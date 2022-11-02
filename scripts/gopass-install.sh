#!/bin/sh

if [ ! -x "$(command -v go)" ]; then
  echo go not installed.
  exit 1
else
  sudo pacman --noconfirm --needed -S go
  # sudo apt install -y golang
  brew install golang
fi

# go install github.com/gopasspw/gopass@latest
go get github.com/gopasspw/gopass

exit 0

# vim: set ft=sh:
