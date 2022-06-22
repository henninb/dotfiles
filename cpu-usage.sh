#!/bin/sh

ps -eo pcpu,pid,user,args | sort -r -k1 | head

exit 0

# vim: set ft=sh:

