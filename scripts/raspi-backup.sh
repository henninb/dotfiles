#!/bin/sh

# sudo dd if=/dev/mmcblk0 of=/home/bruni/backup.img
# For the restore, after you have unmounted and replaced the sd card with a fresh one:
# sudo dd bs=4M if=/home/bruni/backup.img of=/dev/mmcblk0
sudo dd of=raspi.img if=/dev/sdb bs=1M status=progress
sudo dd bs=4M of=/dev/sdb if=raspi.img status=progress

https://elinux.org/RPi_Resize_Flash_Partitions

echo sudo mkdosfs -I -F32 /dev/sdb
echo sudo mkfs.vfat /dev/sdb0
sudo dd bs=1M if=2020-02-13-raspbian-buster.img of=/dev/sdb status=progress

exit 0

# vim: set ft=sh:
