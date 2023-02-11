#!/bin/sh

if [ $# -ne 1 ] && [ $# -ne 2 ]; then
  echo "Usage: $0 <os> [disk]"
  echo "gentoo or archlinux or fedora"
  echo "disk sdc sdb"
  exit 1
fi

os=$1
disk=$2

if command -v camcontrol; then
  sudo camcontrol devlist
  gpart show ada0
  sudo pkg install -y fusefs-lkl 
  sudo lklfuse -o type=ext4 /dev/ada0p3 /mnt/archlinux
fi

if [ "$os" = "voidlinux" ]; then
  disk=nvme0n1
  sudo mkdir -p /mnt/voidlinux
  sudo mount /dev/${disk}p2 /mnt/voidlinux
  sudo mkdir -p /mnt/voidlinux/boot/efi
  sudo mount /dev/${disk}p1 /mnt/voidlinux/boot/efi
  cd /mnt/voidlinux

  sudo mount -t proc none /mnt/voidlinux/proc
  sudo mount --rbind /dev /mnt/voidlinux/dev
  sudo mount --rbind /sys /mnt/voidlinux/sys

  echo 'export PS1="(voidlinux-chroot) $PS1"'
  sudo chroot /mnt/voidlinux /bin/bash
elif [ "$os" = "gentoo-new" ]; then
  disk=sdd
  sudo mkdir -p /mnt/gentoo-new
  sudo mount /dev/${disk}2 /mnt/gentoo-new
  sudo mkdir -p /mnt/gentoo-new/boot/efi
  sudo mount /dev/${disk}1 /mnt/gentoo-new/boot/efi
  cd /mnt/gentoo-new

  sudo mount -t proc none /mnt/gentoo-new/proc
  sudo mount --rbind /dev /mnt/gentoo-new/dev
  sudo mount --rbind /sys /mnt/gentoo-new/sys
  echo 'export PS1="(gentoo-new-chroot) $PS1"'

  sudo chroot /mnt/gentoo-new /bin/bash
elif [ "$os" = "fedora" ]; then
  disk=sdc
  sudo mkdir -p /mnt/fedora
  sudo mount /dev/${disk}3 /mnt/fedora
  sudo mount /dev/${disk}2 /mnt/fedora/root/boot
  # sudo mkdir -p /mnt/fedora/boot/efi
  sudo mount /dev/${disk}1 /mnt/fedora/root/boot/efi
  cd /mnt/fedora

  sudo mount --rbind home /mnt/fedora/root/home
  sudo mount -t proc none /mnt/fedora/root/proc
  sudo mount --rbind /dev /mnt/fedora/root/dev
  # echo mount --bind /dev/mnt/dev
  sudo mount --rbind /sys /mnt/fedora/root/sys
  sudo mount --rbind /run /mnt/fedora/root/run

  echo 'export PS1="(fedora-chroot) $PS1"'
  sudo chroot /mnt/fedora/root /bin/bash
  # echo source /etc/profile
elif [ "$os" = "archlinux" ]; then
  disk=sdb
  sudo mkdir -p /mnt/archlinux
  sudo mount /dev/${disk}2 /mnt/archlinux
  sudo mkdir -p /mnt/archlinux/boot/efi
  sudo mount /dev/${disk}1 /mnt/archlinux/boot/efi
  cd /mnt/archlinux

  sudo mount -t proc none /mnt/archlinux/proc
  sudo mount --rbind /dev /mnt/archlinux/dev
  sudo mount --rbind /sys /mnt/archlinux/sys

  echo 'export PS1="(archlinux-chroot) $PS1"'
  sudo chroot /mnt/archlinux /bin/bash
  # echo source /etc/profile
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

chroot /fedora /bin/env -i \
    HOME=/root TERM="$TERM" PS1='[\u@f24chroot \W]\$ ' \
    PATH=/bin:/usr/bin:/sbin:/usr/sbin:/bin \
    /bin/bash --login
