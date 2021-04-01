all: build
build:
	@arduino-cli compile --fqbn arduino:avr:uno .
install:
	@arduino-cli upload --port /dev/ttyUSB0 --fqbn arduino:avr:uno .
