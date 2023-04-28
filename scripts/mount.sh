#!/bin/sh

# if [ $# -ne 1 ]; then
#     echo "Usage: $0 <file>"
#     exit 1
# fi
# FILE=$1

echo "ntfsfix /dev/sdc2"
#sudo mount -t ntfs -o ro /dev/sdc2 /mnt/ntfs
echo "240GB"
echo sudo mount -t ntfs /dev/sdc2 /mnt/ntfs
#sudo mount -t ntfs-3g /dev/sdc2 /mnt/ntfs

echo "sudo mkdir -p /storage_3TB"
echo "3TB"
echo sudo mount -t ntfs /dev/sdb2 /storage_3TB

echo Gentoo
echo 'sda (320 GB/298 GiB) WDC WD3200AAKS-0'
echo 'sdb (240 GB/224 GiB) TEAML5Lite3D240G'
echo 'sdc (120 GB/112 GiB) OCZ-TRION100'

echo 'sudo mount -o loop VBoxGuestAdditions_6.0.10.iso /mnt'

exit 0

# vim: set ft=sh:
