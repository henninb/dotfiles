all: build
build:
	@arduino-cli compile --fqbn esp32:esp32:d1_mini32 .
install:
	@arduino-cli upload --port /dev/ttyUSB0 --fqbn esp32:esp32:d1_mini32 .
