#!/bin/sh

if [ $# -ne 1 ]; then
    echo "Usage: $0 <file>"
    exit 1
fi

FILE=$1

sudo mkdir -p /media/cdrom

echo cdrecord -scanbus
echo cdrecord -v -eject speed=48 dev=ATAPI:0,0,0 CentOS-8-x86_64-1905-boot.iso

ls -l /dev/cdrom
wodim dev=/dev/sr0 --scanbus
sudo wodim dev=/dev/sr0 -v -data $FILE
echo sudo mount -t iso9660 /dev/cdrom /media/cdrom

exit 0
