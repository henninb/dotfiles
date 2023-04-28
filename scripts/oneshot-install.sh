#!/bin/sh

if [ ! -x "$(command -v go)" ]; then
  echo go not installed.
  exit 1
else
  sudo pacman --noconfirm --needed -S go
  # sudo apt install -y golang
  brew install golang
fi

go get -u -v github.com/raphaelreyna/oneshot

exit 0

# vim: set ft=sh:
