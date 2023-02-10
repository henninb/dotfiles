#!/bin/sh


mkdir -p voidlinux

if [ ! -f .void-created ]; then
  wget https://repo-default.voidlinux.org/live/current/void-x86_64-ROOTFS-20221001.tar.xz
  tar xvf void-x86_64-ROOTFS-20221001.tar.xz -C voidlinux
  rm void-x86_64-ROOTFS-20221001.tar.xz
  touch .void-created
fi

xhost +local:
cp /etc/resolv.conf voidlinux/etc
sudo mount -t proc none voidlinux/proc
sudo mount --rbind /dev voidlinux/dev
sudo mount --rbind /sys voidlinux/sys
sudo chroot voidlinux

exit 0
