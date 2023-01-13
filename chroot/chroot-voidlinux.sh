#!/bin/sh

mkdir -p voidlinux
# wget https://repo-default.voidlinux.org/live/current/void-x86_64-musl-ROOTFS-20221001.tar.xz
wget https://repo-default.voidlinux.org/live/current/void-x86_64-ROOTFS-20221001.tar.xz

# tar xvf void-*-ROOTFS.tar.xz -C voidlinux 
tar xvf void-x86_64-ROOTFS-20221001.tar.xz -C voidlinux
rm void-x86_64-ROOTFS-20221001.tar.xz

xhost +local:
cp /etc/resolv.conf voidlinux/etc
sudo mount -t proc none voidlinux/proc
sudo mount --rbind /dev voidlinux/dev
sudo mount --rbind /sys voidlinux/sys
sudo chroot voidlinux

exit 0
