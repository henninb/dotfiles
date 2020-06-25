#!/bin/sh

mkdir -p electron
sudo npm install nativefier -g

cd electron
nativefier --name "reddit" "reddit.com"
nativefier --name "github" "github.com"

exit 0
