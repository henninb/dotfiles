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
	@arduino-cli compile --fqbn esp8266:esp8266:generic .
install:
	@arduino-cli upload --port /dev/ttyUSB0 --fqbn esp8266:esp8266:generic .
	@serial-monitor.py
