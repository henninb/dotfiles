#!/bin/sh

curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "$HOME/tmp/awscliv2.zip"
cd "$HOME/tmp/" || exit
unzip -o awscliv2.zip
echo sudo ./aws/install --update
sudo ./aws/install --update
sudo ./aws/install
exit 0

# vim: set ft=sh:
