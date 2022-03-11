#!/bin/sh

sudo pacman -S obs-studio
yay -S v4l2loopback-dkms
sudo modprobe v4l2loopback devices=1 video_nr=10 card_label="OBS Cam" exclusive_caps=1

exit 0
