#!/bin/sh

if [ ! -x "$(command -v go)" ]; then
  echo go not installed.
  exit 1
fi

go get github.com/charmbracelet/glow
#git clone http://github.com/charmbracelet/glow

exit 0
