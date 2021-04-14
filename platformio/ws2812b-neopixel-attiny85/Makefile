all: build
build:
	@platformio run
arduino-cli:
	@arduino-cli compile --fqbn arduino:avr:uno .
install-usb0:
	@arduino-cli upload --port /dev/ttyUSB0 --fqbn arduino:avr:uno .
install-usb1:
	@arduino-cli upload --port /dev/ttyUSB0 --fqbn arduino:avr:uno .
install-arduinoasisp:
	@arduino-cli upload -P arduinoasisp --port /dev/ttyUSB0 --fqbn arduino:avr:uno .
install-usbasp:
	@arduino-cli upload -P usbasp --fqbn arduino:avr:uno .
install:
	@echo ${date}
	@sed -i "s/#define uploadTimestamp.*/#define uploadTimestamp \"$(date)\"/g" src/main.cpp
	@platformio run -t upload
	@platformio device monitor
clean:
	@platformio run -t clean
bootloader:
	@echo avrdude -pattiny85 -cstk500v1 -P/dev/ttyUSB0 -b19200 -e -Uefuse:w:0xff:m -Uhfuse:w:0xdf:m -Ulfuse:w:0xf1:m
	@platformio run -t fuses
	# @avrdude -pattiny85 -cstk500v1 -P/dev/ttyUSB0 -b19200
	# @avrdude -pattiny85 -cstk500v1 -P/dev/ttyUSB0 -b19200 -Uflash:w:./.pio/build/attiny85/firmware.hex:i
