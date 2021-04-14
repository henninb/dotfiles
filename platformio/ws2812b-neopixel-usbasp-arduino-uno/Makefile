date=$(shell date '+%Y-%m-%d %H:%M:%S')
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
	@sed -i "s/#define uploadTimestamp.*/#define uploadTimestamp \"$(date)\"/g" src/config.h
	@platformio run -t upload
clean:
	@platformio run -t clean
