#!/bin/sh

# cat > 10-udiskie.pkla <<EOF
# [udisks]
# Identity=unix-group:plugdev
# Action=org.freedesktop.udisks.*
# ResultAny=yes
# [udisks2]
# Identity=unix-group:plugdev
# Action=org.freedesktop.udisks2.*
# ResultAny=yes
# EOF


#echo /etc/polkit-1/localauthority/50-local.d/10-udiskie.pkla
# cat > 50-udisks.rules <<EOF
cat << EOF > "$HOME/tmp/50-udisks.rules"
polkit.addRule(function(action, subject) {
  var YES = polkit.Result.YES;
  var permission = {
    // only required for udisks1:
    "org.freedesktop.udisks.filesystem-mount": YES,
    "org.freedesktop.udisks.filesystem-mount-system-internal": YES,
    "org.freedesktop.udisks.luks-unlock": YES,
    "org.freedesktop.udisks.drive-eject": YES,
    "org.freedesktop.udisks.drive-detach": YES,
    // only required for udisks2:
    "org.freedesktop.udisks2.filesystem-mount": YES,
    "org.freedesktop.udisks2.filesystem-mount-system": YES,
    "org.freedesktop.udisks2.encrypted-unlock": YES,
    "org.freedesktop.udisks2.eject-media": YES,
    "org.freedesktop.udisks2.power-off-drive": YES,
    // required for udisks2 if using udiskie from another seat (e.g. systemd):
    "org.freedesktop.udisks2.filesystem-mount-other-seat": YES,
    "org.freedesktop.udisks2.encrypted-unlock-other-seat": YES,
    "org.freedesktop.udisks2.eject-media-other-seat": YES,
    "org.freedesktop.udisks2.power-off-drive-other-seat": YES
  };
  if (subject.isInGroup("wheel")) {
    return permission[action.id];
  }
});
EOF

cat << EOF > "$HOME/tmp/10-udisks.rules"
polkit.addRule(function(action, subject) {
    if (action.id == "org.freedesktop.udisks2.filesystem-mount" &&
        subject.user == "henninb") {
        return "yes";
    }
});
EOF

# sudo mv -v 10-udisks.rules /etc/polkit-1/rules.d/
sudo mv -v 50-udisks.rules /etc/polkit-1/rules.d/

pkaction --verbose --action-id org.freedesktop.udisks2.filesystem-mount
echo "pkaction | grep mount"

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  sudo pacman --noconfirm --needed -S ntfs-3g
elif [ "$OS" = "Gentoo" ]; then
  if ! command -v udisksctl; then
    sudo emerge  --update --newuse udisks
    sudo emerge  --update --newuse ntfs3g
  fi
elif [ "$OS" = "Fedora Linux" ]; then
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
echo sudo ntfsfix /dev/sdb2
echo sudo modprobe ufs
echo sudo mount -t ufs -o ufstype=ufs2 /dev/sdb3 /mnt
echo sudo mount -t ufs -o ufstype=44bsd /dev/sdb3 /mnt

exit 0

# vim: set ft=sh
