#!/bin/sh

sudo mkdir -p /mnt/gentoo
sudo mount /dev/nvme0n1p2 /mnt/gentoo
sudo mkdir -p /mnt/gentoo/boot/efi
sudo mount /dev/nvme0n1p1 /mnt/gentoo/boot/efi
cd /mnt/gentoo

sudo mount -t proc none /mnt/gentoo/proc
sudo mount --rbind /dev /mnt/gentoo/dev
sudo mount --rbind /sys /mnt/gentoo/sys

echo sudo chroot /mnt/gentoo /bin/bash
echo source /etc/profile
echo 'export PS1="(chroot) $PS1"'

exit 0
