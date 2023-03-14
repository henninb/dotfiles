#!/bin/sh

if command -v debootstrap; then
  sudo mkdir -p bullseye
  sudo debootstrap --arch amd64 bullseye "$HOME/chroot/bullseye" http://deb.debian.org/debian/
  xhost +local:
  sudo mount -t proc none bullseye/proc
  sudo mount --rbind /dev bullseye/dev
  sudo mount --rbind /sys bullseye/sys
  sudo chroot bullseye
fi

exit 0
