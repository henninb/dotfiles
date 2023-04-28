#!/bin/sh

sudo netstat -tulp | grep LIST
sudo netstat -anp | grep LISTEN
sudo lsof -i :80

exit 0

# vim: set ft=sh:
