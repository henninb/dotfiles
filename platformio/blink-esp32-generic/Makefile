all: build
build:
	@platformio run
install:
	@echo ${date}
	@sed -i "s/#define uploadTimestamp.*/#define uploadTimestamp \"$(date)\"/g" src/main.cpp
	@platformio run -t upload
	@platformio device monitor
clean:
	@platformio run -t clean
install-manual:
	@esptool.py --chip esp32 --port /dev/ttyUSB0 --baud 9600 --before default_reset --after hard_reset write_flash -z --flash_mode dio --flash_freq 40m --flash_size detect 0x1000 /home/henninb/.platformio/packages/framework-arduinoespressif32/tools/sdk/bin/bootloader_dio_40m.bin 0x8000 /home/henninb/platformio/blink-esp32-generic/.pio/build/esp32dev/partitions.bin 0xe000 /home/henninb/.platformio/packages/framework-arduinoespressif32/tools/partitions/boot_app0.bin 0x10000 .pio/build/esp32dev/firmware.bin
