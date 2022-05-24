#!/bin/sh

if [ ! -x "$(command -v go)" ]; then
  echo go not installed.
  exit 1
else
  # sudo apt install -y golang
  brew install golang
fi
curl -sSf https://moncho.github.io/dry/dryup.sh | sudo sh
sudo chmod 755 /usr/local/bin/dry


# go get github.com/moncho/dry

exit 0

# vim: set ft=sh:
