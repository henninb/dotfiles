#!/bin/sh

if [ -x "$(command -v netstat)" ]; then
  doas netstat -tulp
  netstat -na | grep tcp | grep LIST
fi

if [ -x "$(command -v socketstat)" ]; then
  sockstat -4 -l
fi
ss -tulpn4

doas lsof -i TCP:22

exit 0

# vim: set ft=sh:
