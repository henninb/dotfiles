#!/bin/sh

pactl info

echo pipewire
wpctl status
echo wpctl set-default 56
wpctl set-default 56
echo pwtop

arecord -l
arecord -f S16_LE -d 10 -r 16000 -c 2 --device="hw:3,0" -t wav yetti-mic.wav
arecord -f S16_LE -d 10 -r 16000 -c 1 --device="hw:0,0" -t wav plantronics-mic.wav
arecord -f S16_LE -d 10 -r 16000 -c 2 --device="hw:4,0" -t wav brio-mic.wav

exit 0
# vim: set ft=sh:
