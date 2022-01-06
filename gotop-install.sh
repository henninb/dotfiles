#!/bin/sh

if [ ! -x "$(command -v go)" ]; then
  echo go not installed.
  exit 1
else
  sudo pacman --noconfirm --needed -S go
  # sudo apt install -y golang
  brew install golang
fi

go get github.com/cjbassi/gotop

exit 0
