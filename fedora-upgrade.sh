#!/bin/sh

sudo dnf upgrade --refresh
sudo dnf install dnf-plugin-system-upgrade

sudo dnf system-upgrade download --refresh --releasever=32
sudo dnf system-upgrade reboot

exit 0
