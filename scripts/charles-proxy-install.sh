#!/bin/sh

curl -sO "https://www.charlesproxy.com/assets/release/4.6.4/charles-proxy-4.6.4_amd64.tar.gz" -o "$HOME/tmp/charles-proxy-4.6.4_amd64.tar.gz"
cd "$HOME/tmp/" || exit
doas tar -xvf charles-proxy-4.6.4_amd64.tar.gz -C /opt

exit 0

# vim: set ft=sh:
