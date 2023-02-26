#!/bin/sh

if [ $# -ne 1 ] && [ $# -ne 2 ]; then
  echo "Usage: $0 <os> [disk]"
  echo "gentoo or archlinux or fedora or voidlinux or ubuntu"
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
  # disk=nvme0n1
  sudo mkdir -p /mnt/voidlinux
  # sudo mount /dev/${disk}p2 /mnt/voidlinux
  sudo mount UUID=b09663a8-7ff5-42f5-b2ad-8ea0df1f18ff /mnt/voidlinux
  sudo mkdir -p /mnt/voidlinux/boot/efi
  # sudo mount /dev/${disk}p1 /mnt/voidlinux/boot/efi
  sudo mount UUID=F9D5-CA2F /mnt/voidlinux/boot/efi
  cd /mnt/voidlinux

  sudo mount -t proc none /mnt/voidlinux/proc
  sudo mount --rbind /dev /mnt/voidlinux/dev
  sudo mount --rbind /sys /mnt/voidlinux/sys

  echo 'export PS1="(voidlinux-chroot) $PS1"'
  sudo chroot /mnt/voidlinux /bin/su - "$(id -un)"
elif [ "$os" = "gentoo" ]; then
  #disk=sdd
  sudo mkdir -p /mnt/gentoo
  #sudo mount /dev/${disk}2 /mnt/gentoo
  sudo mount UUID=6d8ab46d-3e64-4ee5-b6e2-940433d01d56 /mnt/gentoo
  sudo mkdir -p /mnt/gentoo/boot/efi
  #sudo mount /dev/${disk}1 /mnt/gentoo/boot/efi
  sudo mount UUID=CCF7-57C5 /mnt/gentoo/boot/efi
  cd /mnt/gentoo

  sudo mount -t proc none /mnt/gentoo/proc
  sudo mount --rbind /dev /mnt/gentoo/dev
  sudo mount --rbind /sys /mnt/gentoo/sys
  echo 'export PS1="(gentoo-chroot) $PS1"'

  sudo chroot /mnt/gentoo /bin/su - "$(id -un)"
elif [ "$os" = "fedora" ]; then
  # disk=sdb
  sudo mkdir -p /mnt/fedora
  #sudo mount /dev/${disk}3 /mnt/fedora
  sudo mount UUID=722c5ee8-b300-4b51-86de-9221ebabc617 /mnt/fedora
  # sudo mount /dev/${disk}2 /mnt/fedora/root/boot
  sudo mount UUID=906ecda7-1224-4533-9c0b-a5c070d3e68b /mnt/fedora/root/boot
  # sudo mkdir -p /mnt/fedora/boot/efi
  # sudo mount /dev/${disk}1 /mnt/fedora/root/boot/efi
  sudo mount UUID=1EF4-FD52 /mnt/fedora/root/boot/efi
  cd /mnt/fedora

  sudo mount --rbind home /mnt/fedora/root/home
  sudo mount -t proc none /mnt/fedora/root/proc
  sudo mount --rbind /dev /mnt/fedora/root/dev
  # echo mount --bind /dev/mnt/dev
  sudo mount --rbind /sys /mnt/fedora/root/sys
  sudo mount --rbind /run /mnt/fedora/root/run

  echo 'export PS1="(fedora-chroot) $PS1"'
  sudo chroot /mnt/fedora/root /bin/su - "$(id -un)"
  # echo source /etc/profile
elif [ "$os" = "ubuntu" ]; then
  # disk=sdc
  sudo mkdir -p /mnt/ubuntu
  sudo mount UUID=a7bb907f-6870-40a6-af47-ac881e72caf2 /mnt/ubuntu
  # sudo mount /dev/${disk}3 /mnt/ubuntu
  sudo mkdir -p /mnt/ubuntu/boot/efi
  # sudo mount /dev/${disk}1 /mnt/ubuntu/boot/efi
  sudo mount UUID=F577-6798 /mnt/ubuntu/boot/efi
  cd /mnt/ubuntu

  sudo mount -t proc none /mnt/ubuntu/proc
  sudo mount --rbind /dev /mnt/ubuntu/dev
  sudo mount --rbind /sys /mnt/ubuntu/sys

  echo 'export PS1="(ubuntu-chroot) $PS1"'
  sudo chroot /mnt/ubuntu /bin/su - "$(id -un)"
elif [ "$os" = "archlinux" ]; then 
  # disk=sdb
  sudo mkdir -p /mnt/archlinux
  sudo mount UUID=72ad4c57-06c1-41d6-a72f-34000c848126 /mnt/archlinux
  # sudo mount /dev/${disk}2 /mnt/archlinux
  sudo mkdir -p /mnt/archlinux/boot/efi
  # sudo mount /dev/${disk}1 /mnt/archlinux/boot/efi
  sudo mount UUID=F577-6798 /mnt/archlinux/boot/efi
  cd /mnt/archlinux

  sudo mount -t proc none /mnt/archlinux/proc
  sudo mount --rbind /dev /mnt/archlinux/dev
  sudo mount --rbind /sys /mnt/archlinux/sys

  echo 'export PS1="(archlinux-chroot) $PS1"'
  sudo chroot /mnt/archlinux /bin/su - "$(id -un)"
else
  echo "chose the correct os."
fi

exit 0
