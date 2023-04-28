#!/bin/sh

if [ ! -x "$(command -v go)" ]; then
  echo go not installed.
  exit 1
fi

go get -u github.com/eliukblau/pixterm/cmd/pixterm

exit 0

# vim: set ft=sh:
