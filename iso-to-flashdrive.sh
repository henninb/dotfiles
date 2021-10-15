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

lsusb | grep Toshiba
sudo dmesg | grep -A 5 'Direct-Access' | grep sd | grep -i log
#drive=$(dmesg | grep -A 5 'Direct-Access' | grep sd | grep -i log)

echo sudo dd "if=${FILE}" of=/dev/sdc bs=4M status=progress && sync
echo sudo dd "if=${FILE}" of=/dev/sdd bs=4M status=progress && sync
echo sudo dd "if=${FILE}" of=/dev/sdg bs=4M status=progress && sync
echo sudo dd "if=${FILE}" of=/dev/sdg bs=16k status=progress && sync

#hdparm -i /dev/sdg

exit 0
