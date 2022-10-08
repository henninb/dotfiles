#!/bin/sh

if [ $# -ne 1 ]; then
  echo "Usage: $0 <os>"
  echo "gentoo or archlinux"
  exit 1
fi

os=$1

if [ "$os" = "gentoo" ]; then
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
elif [ "$os" = "archlinux" ]; then
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
else
  echo "chose the correct os."
fi

exit 0
