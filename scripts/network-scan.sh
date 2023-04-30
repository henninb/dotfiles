#!/bin/sh

nmap nmap -sP --host-timeout 10 192.168.100.0/24
doas lsof -nP -iTCP -sTCP:LISTEN


exit 0

# vim: set ft=sh:
