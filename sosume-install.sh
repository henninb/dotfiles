#!/bin/sh

sudo pacman -S snapd
sudo snap install sosumi
sudo usermod -aG kvm $USER
sosumi

exit 0
