#!/bin/sh

git clone https://github.com/martin-ger/esp_wifi_repeater.git

esptool.py --port /dev/ttyUSB0 write_flash 0x00000 esp_wifi_repeater/firmware/0x00000.bin
esptool.py --port /dev/ttyUSB0 write_flash 0x02000 esp_wifi_repeater/firmware/0x02000.bin
esptool.py --port /dev/ttyUSB0 write_flash 0x82000 esp_wifi_repeater/firmware/0x82000.bin

exit 0
