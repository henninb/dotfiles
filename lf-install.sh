#!/bin/sh

if [ ! -x "$(command -v go)" ]; then
  echo go not installed.
fi

go get github.com/gokcehan/lf

exit 0
