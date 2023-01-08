#!/bin/sh

sudo debootstrap --variant=buildd --arch amd64 jammy "$HOME/chroot/jammy" http://archive.ubuntu.com/ubuntu/

exit 0
