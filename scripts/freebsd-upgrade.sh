#!/bin/sh

doas freebsd-update -r 13.0 upgrade
doas freebsd-update fetch
doas freebsd-update install

exit 0

# vim: set ft=sh:
