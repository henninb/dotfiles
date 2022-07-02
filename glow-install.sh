#!/bin/sh

if [ ! -x "$(command -v go)" ]; then
  echo go not installed.
  exit 1
fi

#go get github.com/charmbracelet/glow
#git clone http://github.com/charmbracelet/glow

# git clone https://github.com/charmbracelet/glow.git
# cd glow
# go build

sudo pacman --noconfirm --needed -S glow

exit 0

# vim: set ft=sh:
