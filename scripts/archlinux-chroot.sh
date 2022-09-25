#!/bin/sh

sudo mkdir -p /mnt/archlinux
sudo mount /dev/sda3 /mnt/archlinux
sudo mkdir -p /mnt/archlinux/boot/efi
sudo mount /dev/sda1 /mnt/archlinux/boot/efi
cd /mnt/archlinux

sudo mount -t proc none /mnt/archlinux/proc
sudo mount --rbind /dev /mnt/archlinux/dev
sudo mount --rbind /sys /mnt/archlinux/sys

echo sudo chroot /mnt/archlinux /bin/bash
echo source /etc/profile
echo 'export PS1="(chroot) $PS1"'

exit 0
