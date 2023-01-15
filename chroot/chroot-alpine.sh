#!/bin/sh

mkdir -p alpine
curl -LO http://dl-cdn.alpinelinux.org/alpine/latest-stable/main/x86_64/apk-tools-static-2.12.10-r1.apk
# wget https://repo-default.alpine.org/live/current/void-x86_64-ROOTFS-20221001.tar.xz
tar -xzf apk-tools-static-2.12.10-r1.apk -C alpine
#rm apk-tools-static-2.12.10-r1.apk
alpine/sbin/apk.static -X http://dl-cdn.alpinelinux.org/latest-stable/main -U --allow-untrusted -p alpine --initdb add alpine-base

xhost +local:
cp /etc/resolv.conf alpine/etc
sudo mount -t proc none alpine/proc
sudo mount --rbind /dev alpine/dev
sudo mount --rbind /sys alpine/sys
sudo chroot alpine

exit 0
