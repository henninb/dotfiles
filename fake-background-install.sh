#!/bin/sh

sudo pacman --noconfirm --needed -S v4l2loopback-dkms
git clone https://github.com/fangfufu/Linux-Fake-Background-Webcam.git fake-background
cd fake-background
./install.sh
echo install pip3
echo ./fake.py --no-foreground --width 640 --height 480 --background-blur 0

exit 0

# vim: set ft=sh:
