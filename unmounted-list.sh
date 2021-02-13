#!/bin/sh

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  sudo pacman --noconfirm --needed -S ntfs-3g
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge  --update --newuse udisks
elif [ "$OS" = "Fedora" ]; then
  sudo dnf install -y parted
else
  echo "$OS is not implemented."
fi

sudo parted -l

lsblk --noheadings --raw | awk '$1~/s.*[[:digit:]]/ && $7==""'

lsblk --noheadings --raw -o NAME,MOUNTPOINT | awk '$1~/[[:digit:]]/ && $2 == ""'

echo udisksctl mount -b /dev/sda1
echo udisksctl mount -b /dev/sdb1
echo udisksctl mount -b /dev/sdc1
echo udisksctl mount -b /dev/md126p1
echo sshfs pi:/home/pi/downloads downloads

echo sudo ntfsfix /dev/sda1
echo sudo mkfs.ext4 /dev/sda1
echo sudo mkfs.vfat -F 32 /dev/sdb1
echo sudo gdisk -l /dev/sda
echo sudo ntfslabel /dev/md126p1 Data
echo sudo e2label /dev/sda1 Data

exit 0
