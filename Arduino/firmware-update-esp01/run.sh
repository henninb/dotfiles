#!/bin/sh

esptool.py --port /dev/ttyUSB0  write_flash 0x00000 v0.9.2.2-AT-Firmware.bin

exit 0
