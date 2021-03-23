all: usb1
usb1:
	@arduino-cli compile --fqbn arduino:avr:uno .
	@arduino-cli upload --port /dev/ttyUSB1 --fqbn arduino:avr:uno .
usb0:
	@arduino-cli compile --fqbn arduino:avr:uno .
	@arduino-cli upload --port /dev/ttyUSB0 --fqbn arduino:avr:uno .
usbasp:
	@arduino-cli compile --fqbn arduino:avr:uno .
	@arduino-cli upload -P usbasp --fqbn arduino:avr:uno .
