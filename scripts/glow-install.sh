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


if [ -x "$(command -v pacman)" ]; then
  sudo pacman --noconfirm --needed -S glow
elif [ -x "$(command -v emerge)" ]; then
  echo https://github.com/charmbracelet/glow
  echo go get github.com/charmbracelet/glow
  git clone https://github.com/charmbracelet/glow.git
  cd glow || exit
  go build
  go install
  cd - || exit
  rm -rf glow
elif [ -x "$(command -v apt)" ]; then
  echo
elif [ -x "$(command -v xbps-install)" ]; then
  echo
elif [ -x "$(command -v eopkg)" ]; then
  echo
elif [ -x "$(command -v dnf)" ]; then
  echo
elif [ -x "$(command -v brew)" ]; then
  echo
else
  echo "$OS is not yet implemented."
  exit 1
fi

exit 0

# vim: set ft=sh:
