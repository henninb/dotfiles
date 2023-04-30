#!/bin/sh

doas netstat -tulp | grep LIST
doas netstat -anp | grep LISTEN
doas lsof -i :80

exit 0

# vim: set ft=sh:
