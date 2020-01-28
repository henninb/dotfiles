#!/bin/sh

sudo pacman --noconfirm --needed -S ntfs-3g
sudo parted -l

lsblk  --noheadings --raw | awk '$1~/s.*[[:digit:]]/ && $7==""'

lsblk --noheadings --raw -o NAME,MOUNTPOINT | awk '$1~/[[:digit:]]/ && $2 == ""'

echo udisksctl mount -b /dev/sdb1
echo udisksctl mount -b /dev/sda1
echo sudo ntfsfix /dev/yourPartitionToMount
echo sudo mkfs.ext4 /dev/sda1

exit 0
