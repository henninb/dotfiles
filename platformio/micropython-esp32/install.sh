#!/bin/sh

rm -rf esp32-idf4-20210202-v1.14.bin
wget https://micropython.org/resources/firmware/esp32-idf4-20210202-v1.14.bin

esptool.py --chip esp32 erase_flash
esptool.py --chip esp32 --port /dev/ttyUSB0 write_flash 0x1000 esp32-idf4-20210202-v1.14.bin

exit 0
