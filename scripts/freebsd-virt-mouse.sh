#!/bin/sh

sudo pkg install utouch-kmod xf86-input-evdev

edit /boot/loader.conf as instructed.
utouch_load="YES"

exit 0
