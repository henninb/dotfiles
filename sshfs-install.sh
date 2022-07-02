#!/bin/sh

sudo emerge --update --newuse sshfs
mkdir -p "$HOME/mnt/downloads"
mkdir -p "$HOME/mnt/audio"
echo sshfs pi@raspi:/home/pi/downloads ~/mnt/downloads -o reconnect
echo sshfs henninb@hornsup:/home/henninb/src/api/youtube/audio ~/mnt/audio -o reconnect


exit 0
