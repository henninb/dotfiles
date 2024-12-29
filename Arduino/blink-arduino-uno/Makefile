# Check if arduino-cli is installed, if not install it via emerge
ifeq (, $(shell which arduino-cli))
    $(error "arduino-cli is not installed. Installing it with emerge...")
    @sudo emerge --ask arduino-cli
endif

# Check if arduino:avr platform is installed, if not install it
ifeq (, $(shell arduino-cli core list | grep arduino:avr))
    @arduino-cli core install arduino:avr
endif

all: build
build:
	@arduino-cli compile --fqbn arduino:avr:uno .
usb0:
	@arduino-cli upload --port /dev/ttyUSB0 --fqbn arduino:avr:uno .
usb1:
	@arduino-cli upload --port /dev/ttyUSB0 --fqbn arduino:avr:uno .
arduinoasisp:
	@arduino-cli upload -P arduinoasisp --port /dev/ttyUSB0 --fqbn arduino:avr:uno .
usbasp:
	@arduino-cli upload -P usbasp --fqbn arduino:avr:uno .
install:
	@arduino-cli upload --port /dev/ttyUSB0 --fqbn arduino:avr:uno
	@serial-monitor.py
