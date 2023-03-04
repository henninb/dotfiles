#!/bin/sh

if [ ! -x "$(command -v go)" ]; then
  echo go not installed.
  exit 1
else
  if [ -x "$(command -v pacman)" ]; then
    sudo pacman --noconfirm --needed -S go
  elif [ -x "$(command -v emerge)" ]; then
    test
  elif [ -x "$(command -v apt)" ]; then
    test
  elif [ -x "$(command -v xbps-install)" ]; then
    test
  elif [ -x "$(command -v eopkg)" ]; then
    test
  elif [ -x "$(command -v dnf)" ]; then
    test
  elif [ -x "$(command -v brew)" ]; then
    brew install golang
  else
    echo "$OS is not yet implemented."
    exit 1
  fi
fi


# echo https://github.com/charmbracelet/glow
# echo go get github.com/charmbracelet/glow
# git clone https://github.com/charmbracelet/glow.git
# cd glow || exit
# go build
# go install
# cd - || exit
# rm -rf glow
go env -w GO111MODULE=off
go get github.com/gokcehan/lf

exit 0

# vim: set ft=sh:
