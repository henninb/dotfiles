#!/bin/sh

# sudo pacman --noconfirm --needed -S snapd
# sudo snap install sosumi
sudo snap install sosumi --edge
sudo usermod -aG kvm $USER
sosumi

exit 0

# vim: set ft=sh
