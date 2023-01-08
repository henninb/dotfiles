#!/bin/sh

sudo debootstrap --arch amd64 bullseye "$HOME/chroot/bullseye" http://deb.debian.org/debian/

exit 0
