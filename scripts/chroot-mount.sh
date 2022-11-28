#!/bin/sh

if [ $# -ne 1 ]; then
  echo "Usage: $0 <os>"
  echo "gentoo or archlinux or fedora"
  exit 1
fi

os=$1

if command -v camcontrol; then
  sudo camcontrol devlist
  gpart show ada0
  sudo pkg install -y fusefs-lkl 
  sudo lklfuse -o type=ext4 /dev/ada0p3 /mnt/archlinux
fi

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
elif [ "$os" = "fedora" ]; then
  sudo mkdir -p /mnt/fedora
  sudo mount /dev/sdc3 /mnt/fedora
  sudo mkdir -p /mnt/fedora/boot/efi
  sudo mount /dev/sdc1 /mnt/fedora/boot/efi
  cd /mnt/fedora

  sudo mount --rbind home /mnt/fedora/root/home

  sudo mount -t proc none /mnt/fedora/root/proc
  sudo mount --rbind /dev /mnt/fedora/root/dev
  sudo mount --rbind /sys /mnt/fedora/root/sys
  sudo mount --rbind /run /mnt/fedora/root/run

  echo sudo chroot /mnt/fedora/root /bin/bash
  echo source /etc/profile
  echo 'export PS1="(chroot) $PS1"'
elif [ "$os" = "archlinux" ]; then
  sudo mkdir -p /mnt/archlinux
  sudo mount /dev/sdb2 /mnt/archlinux
  sudo mkdir -p /mnt/archlinux/boot/efi
  sudo mount /dev/sdb1 /mnt/archlinux/boot/efi
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

## for linux on freebsd
  sudo mkdir -p /mnt/archlinux
  sudo mount /dev/ada0s3 /mnt/archlinux
  sudo mkdir -p /mnt/archlinux/boot/efi
  sudo mount /dev/ada0s1 /mnt/archlinux/boot/efi
  cd /mnt/archlinux

  sudo mount -t proc none /mnt/archlinux/proc
  sudo mount --rbind /dev /mnt/archlinux/dev
  sudo mount --rbind /sys /mnt/archlinux/sys

  echo sudo chroot /mnt/archlinux /bin/bash
  echo source /etc/profile
  echo 'export PS1="(chroot) $PS1"'

