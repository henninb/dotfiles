date=$(shell date '+%Y-%m-%d %H:%M:%S')
all: build
build:
	@platformio run
usb0:
	@arduino-cli compile --fqbn esp8266:esp8266:generic .
	@arduino-cli upload --port /dev/ttyUSB0 --fqbn esp8266:esp8266:generic .
install:
	@echo ${date}
	@sed -i "s/#define uploadTimestamp.*/#define uploadTimestamp \"$(date)\"/g" src/config.h
	@platformio run -t upload
	@platformio device monitor
clean:
	@platformio run -t clean

