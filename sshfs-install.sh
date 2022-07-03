#!/bin/sh

if [ -x "$(command -v emerge)" ]; then
  sudo emerge --update --newuse sshfs
fi
if [ -x "$(command -v pacman)" ]; then
  sudo pacman --noconfirm --needed sshfs
fi

mkdir -p "$HOME/mnt/downloads"
mkdir -p "$HOME/mnt/audio"
echo sshfs pi@raspi:/home/pi/downloads ~/mnt/downloads -o reconnect
sshfs pi@raspi:/home/pi/downloads ~/mnt/downloads -o reconnect

echo sshfs henninb@hornsup:/home/henninb/src/api/youtube/audio ~/mnt/audio -o reconnect
sshfs henninb@hornsup:/home/henninb/src/api/youtube/audio ~/mnt/audio -o reconnect

exit 0
