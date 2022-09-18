#!/bin/sh

cat /proc/partitions
ls /dev/[s|x|v]d*
lsblk
fdisk –l

exit 0
