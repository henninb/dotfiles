#!/bin/sh

mkdir -p "$HOME/projects/bartobri"
cd "$HOME/projects/bartobri" || exit
git clone https://github.com/bartobri/no-more-secrets.git
cd ./no-more-secrets || exit
make nms
make sneakers             ## Optional
sudo make install

exit 0
# vim: set ft=sh:
