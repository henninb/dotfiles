#!/bin/sh

sudo netstat -tulp
netstat -na | grep tcp | grep LIST
sockstat -4 -l

exit 0
