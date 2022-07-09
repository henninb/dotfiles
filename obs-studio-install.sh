#!/bin/sh

if [ -x "$(command -v pacman)" ]; then
  sudo pacman --noconfirm --needed -S obs-studio
  yay -S v4l2loopback-dkms
  sudo modprobe v4l2loopback devices=1 video_nr=10 card_label="OBS Cam" exclusive_caps=1
elif [ -x "$(command -v emerge)" ]; then
  sudo emerge --update --newuse media-video/v4l2loopback
  sudo emerge --update --newuse media-video/obs-studio
  echo
elif [ -x "$(command -v apt)" ]; then
  echo
elif [ -x "$(command -v xbps-install)" ]; then
  echo
elif [ -x "$(command -v eopkg)" ]; then
  echo
elif [ -x "$(command -v dnf)" ]; then
  echo
elif [ -x "$(command -v brew)" ]; then
  echo
else
  echo "$OS is not yet implemented."
  exit 1
fi

exit 0

# vim: set ft=sh
