#!/bin/sh

doas dnf upgrade --refresh
doas dnf install dnf-plugin-system-upgrade

doas dnf system-upgrade download --refresh --releasever=38
doas dnf system-upgrade reboot

exit 0

# vim: set ft=sh:
