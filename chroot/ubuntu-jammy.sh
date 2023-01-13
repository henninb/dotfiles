#!/bin/sh

# sudo debootstrap --variant=buildd --arch amd64 jammy "$HOME/chroot/jammy" http://archive.ubuntu.com/ubuntu/
xhost +local:
sudo mount -t proc none jammy/proc
sudo mount --rbind /dev jammy/dev
sudo mount --rbind /sys jammy/sys
sudo chroot jammy

exit 0
