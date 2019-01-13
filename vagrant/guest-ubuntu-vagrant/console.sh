#!/bin/sh

echo sudo vi /mnt/etc/default/grub

GRUB_CMDLINE_LINUX='console=tty0 console=ttyS0,19200n8'
GRUB_TERMINAL=serial
GRUB_SERIAL_COMMAND="serial --speed=19200 --unit=0 --word=8 --parity=no --stop=1"

echo sudo update-grub

exit 0
