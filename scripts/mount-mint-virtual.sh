#!/bin/sh

sudo modprobe nbd max_part=8

sudo qemu-nbd --connect=/dev/nbd0 /var/lib/libvirt/images/guest-mint.qcow2

sudo fdisk -l /dev/nbd0

sudo mount /dev/nbd0p2 /mnt/disk

echo sudo umount /mnt/disk
echo sudo qemu-nbd --disconnect /dev/nbd0

exit 0

