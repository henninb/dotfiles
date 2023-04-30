#!/bin/sh

if [ $# -ne 1 ]; then
  echo "Usage: $0 <file>"
  exit 1
fi

FILE=$1

if [ ! -f "$FILE" ]; then
  echo "$FILE is not found."
  exit 1
fi

echo My external burner does not write dvdr+ disks.
doas eopkg install -y cdrtools
doas emerge --update --newuse cdrtools

if command -v wodim; then
  wodim  dev=/dev/sr0 -checkdrive -prcap
  wodim dev=/dev/sr0 --scanbus
  #sudo wodim dev=/dev/sr0 -v -data "${FILE}"
  #sudo wodim -eject -tao speed=0 dev=/dev/sr0 -v -data  "${FILE}"
  #sudo wodim -dao speed=0 dev=/dev/sr0 -v -data "${FILE}"
  sudo wodim speed=0 dev=/dev/sr0 -v -data "${FILE}"
  #driver=mmc_dvdplusr
  #driveropts=burnfree
elif command -v cdrecord; then
  doas cdrecord -scanbus
  doas cdrecord -v -eject speed=4 dev=ATAPI:0,0,0 "${FILE}"
  echo ls -l /dev/cdrom
else
  echo "neither wodim nor cdrecord installed."
  exit 1
fi

echo sudo mount -t iso9660 /dev/cdrom /media/cdrom
echo sudo mkdir -p /media/cdrom

exit 0

# vim: set ft=sh:
