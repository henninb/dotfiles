#!/bin/sh

if command -v debootstrap; then
  sudo mkdir -p bullseye
  if [ ! -f bullseye/etc/os-release ]; then
    sudo debootstrap --arch amd64 bullseye "$HOME/chroot/bullseye" http://deb.debian.org/debian/
  fi
  xhost +local:
  sudo mount -t proc none bullseye/proc
  sudo mount --rbind /dev bullseye/dev
  sudo mount --rbind /sys bullseye/sys
  sudo chroot bullseye
fi

exit 0
