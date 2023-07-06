#!/bin/sh

mkdir -p /mnt/alpine
curl -LO http://dl-cdn.alpinelinux.org/alpine/latest-stable/main/x86_64/apk-tools-static-2.14.0-r2.apk
# wget https://repo-default.alpine.org/live/current/void-x86_64-ROOTFS-20221001.tar.xz
tar -xzf apk-tools-static-2.14.0-r2.apk -C /mnt/alpine
#rm apk-tools-static-2.12.10-r1.apk
alpine/sbin/apk.static -X http://dl-cdn.alpinelinux.org/latest-stable/main -U --allow-untrusted -p /mnt/alpine --initdb add alpine-base

xhost +local:
cp /etc/resolv.conf /alpine/etc
sudo mount -t proc none /mnt/alpine/proc
sudo mount --rbind /dev /mnt/alpine/dev
sudo mount --rbind /sys /mnt/alpine/sys
sudo chroot /mnt/alpine

mkdir -p /mnt/alpine/etc/apk
echo "${mirror}/${branch}/main" > /mnt/alpine/etc/apk/repositories

rc-update add devfs sysinit
rc-update add dmesg sysinit
rc-update add mdev sysinit

rc-update add hwclock boot
rc-update add modules boot
rc-update add sysctl boot
rc-update add hostname boot
rc-update add bootmisc boot
rc-update add syslog boot

rc-update add mount-ro shutdown
rc-update add killprocs shutdown
rc-update add savecache shutdown

exit 0
