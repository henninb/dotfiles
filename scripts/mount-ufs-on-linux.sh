#!/bin/sh

sudo mkdir -p /mnt/freebsd
sudo mount -t ufs -o loop,offset=$((532520 * 512)),ro,ufstype=ufs2 /dev/sdb /mnt/freebsd

exit 0

Use fdisk /dev/sdX using command b (for BSD disklabels) followed by p (for print) to get the list of BSD disklabels/slices. This will look like this:

Slice   Start     End Sectors   Size Type     Fsize Bsize   Cpg
a     4082400 4606687  524288   256M 4.2BSD    2048 16384 32776
b     4606688 5079391  472704 230.8M swap         0     0     0
c     4082400 8164799 4082400     2G unused       0     0     0
d     5079392 5603679  524288   256M 4.2BSD    2048 16384 32776
e     5603680 6127967  524288   256M 4.2BSD    2048 16384 32776
f     6127968 8164799 2036832 994.6M 4.2BSD    2048 16384 28552
This gives you the start sector for each partition. The sector multiplied by the sector size (512 bytes; see fdisk output) gives you an offset that you can use with with mount.

For example for slice 6127968
# vim: set ft=sh:
