#!/bin/sh

curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "$HOME/tmp/awscliv2.zip"
cd "$HOME/tmp/"
unzip -o awscliv2.zip
sudo ./aws/install
sudo ./aws/install --update
exit 0

# vim: set ft=sh
