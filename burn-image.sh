#!/bin/sh

if [ $# -ne 1 ]; then
  echo "Usage: $0 <file>"
  exit 1
fi

FILE=$1

wodim  dev=/dev/sr0 -checkdrive -prcap
echo does not write dvdr+ disks

if [ -x "$(command -v wodim)" ]; then
  wodim dev=/dev/sr0 --scanbus
  #sudo wodim dev=/dev/sr0 -v -data "${FILE}"
  sudo wodim -eject -tao speed=0 dev=/dev/sr0 -v -data  "${FILE}"
  #driver=mmc_dvdplusr
  #driveropts=burnfree
else
  echo wodim is not installed.
fi

echo sudo mount -t iso9660 /dev/cdrom /media/cdrom
echo sudo mkdir -p /media/cdrom
echo cdrecord -scanbus
echo cdrecord -v -eject speed=48 dev=ATAPI:0,0,0 CentOS-8-x86_64-1905-boot.iso
echo ls -l /dev/cdrom

exit 0
