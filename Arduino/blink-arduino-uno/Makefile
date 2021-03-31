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
