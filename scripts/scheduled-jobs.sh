#!/bin/sh

sudo systemctl list-timers
systemctl --user list-timers -all

exit 0

# vim: set ft=sh:
