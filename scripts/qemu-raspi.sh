#!/bin/sh

wget https://downloads.raspberrypi.org/raspbian_lite/images/raspbian_lite-2018-10-11/2018-10-09-raspbian-stretch-lite.zip
wget https://github.com/wimvanderbauwhede/limited-systems/raw/master/Raspberry-Pi-3-QEMU/Raspbian/raspbian_bootpart/kernel-qemu-4.14.50-stretch

qemu-system-arm \
   -kernel raspbian_bootpart/kernel-qemu-4.14.50-stretch \
   -dtb raspbian_bootpart/versatile-pb.dtb \
   -m 256 -M versatilepb -cpu arm1176 \
   -serial stdio \
   -append "rw console=ttyAMA0 root=/dev/sda2 rootfstype=ext4  loglevel=8 rootwait fsck.repair=yes memtest=1" \
   -drive file=2018-10-09-raspbian-stretch-lite.img,format=raw \
   -redir tcp:5022::22  \
   -no-reboot

exit 0

# vim: set ft=sh:
