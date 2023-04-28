#!/bin/sh

systemctl get-default
echo sudo systemctl set-default multi-user
echo sudo systemctl set-default graphical

exit 0
# vim: set ft=sh:
