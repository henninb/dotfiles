#!/bin/sh

curl -s "https://011d6d2c3b16566b4a68d3410328c12a.r2.cloudflarestorage.com/caido-releases/v0.44.1/caido-cli-v0.44.1-linux-x86_64.tar.gz" -o "$HOME/tmp/caido-cli-v0.44.1-linux-x86_64.tar.gz"
cd "$HOME/tmp/" || exit
tar xvf caido-cli-v0.44.1-linux-x86_64.tar.gz
exit 0

# vim: set ft=sh:
