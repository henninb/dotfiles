#!/bin/sh

golang_ver=$(curl -s 'https://golang.org/VERSION?m=text')


if [ ! -x "$(command -v go)" ]; then
  echo "golang needs to be installed"
else
  if grep -q "$golang_ver" <<< "$(go version)"; then
    echo "golang is already up to date"
  else
    echo "updating golang"
    exit 1
    if [ ! -f "${golang_ver}.linux-amd64.tar.gz" ]; then
      wget -q "https://dl.google.com/go/${golang_ver}.linux-amd64.tar.gz"
    fi

    tar xvf "${golang_ver}.linux-amd64.tar.gz"
    sudo rm -rf /usr/local/go
    sudo mv -v go /usr/local
  fi
fi

go version

exit 0
