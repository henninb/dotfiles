#!/bin/sh

cat > 10-udiskie.pkla <<EOF
[udisks]
Identity=unix-group:plugdev
Action=org.freedesktop.udisks.*
ResultAny=yes
[udisks2]
Identity=unix-group:plugdev
Action=org.freedesktop.udisks2.*
ResultAny=yes
EOF

#echo /etc/polkit-1/localauthority/50-local.d/10-udiskie.pkla

cat > 10-udisks.rules <<EOF
polkit.addRule(function(action, subject) {
    if (action.id == "org.freedesktop.udisks2.filesystem-mount" &&
        subject.user == "henninb") {
        return "yes";
    }
});
EOF
sudo mv -v 10-udisks.rules /etc/polkit-1/rules.d/10-udisks.rules
pkaction --verbose --action-id org.freedesktop.udisks2.filesystem-mount
echo "pkaction | grep mount"

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  sudo pacman --noconfirm --needed -S ntfs-3g
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge  --update --newuse udisks
elif [ "$OS" = "Fedora" ]; then
  sudo dnf install -y parted
else
  echo "$OS is not implemented."
fi

udisksctl status
lsblk -o name,fstype
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
