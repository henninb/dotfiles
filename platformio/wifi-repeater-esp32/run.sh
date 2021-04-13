#!/bin/sh
git clone https://github.com/dabare/esp32_nat_router.git

esptool.py --chip esp32 erase_flash
esptool.py --chip esp32 --port /dev/ttyUSB0 write_flash 0x1000 esp32_nat_router/build/bootloader/bootloader.bin
esptool.py --chip esp32 --port /dev/ttyUSB0 write_flash 0x10000 esp32_nat_router/build/esp32_nat_router.bin
esptool.py --chip esp32 --port /dev/ttyUSB0 write_flash 0x8000 esp32_nat_router/build/partitions_example.bin

exit 0
