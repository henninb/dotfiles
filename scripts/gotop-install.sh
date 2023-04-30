#!/bin/sh

if [ ! -x "$(command -v go)" ]; then
  echo go not installed.
  exit 1
else
  doas pacman --noconfirm --needed -S go
  # sudo apt install -y golang
  brew install golang
fi

go get github.com/cjbassi/gotop

exit 0

# vim: set ft=sh:
