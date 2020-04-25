#!/bin/sh


if [ ! -x "$(command -v go)" ]; then
  echo go not installed.
  exit 1
else
  sudo pacman -S go
  # sudo apt install -y golang
  brew install golang
fi

go get github.com/gokcehan/lf

exit 0
