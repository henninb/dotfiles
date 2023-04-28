#!/bin/sh

sudo pkg install utouch-kmod xf86-input-evdev

edit /boot/loader.conf as instructed.
utouch_load="YES"

echo start xterm to desktop from remote system
DISPLAY=:0 xterm &

exit 0
# vim: set ft=sh:
