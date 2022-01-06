#!/bin/sh

sudo pacman --noconfirm --needed -S snapd
sudo snap install sosumi
sudo usermod -aG kvm $USER
sosumi

exit 0
