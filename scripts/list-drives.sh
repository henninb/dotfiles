#!/bin/sh

cat /proc/partitions
# ls /dev/[s|x|v]d*
lsblk
sudo fdisk -l

grep -v nodev /proc/filesystems | cut -f2

exit 0
# vim: set ft=sh:
