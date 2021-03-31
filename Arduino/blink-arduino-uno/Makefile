all: usb0
usb0:
	@arduino-cli compile --fqbn arduino:avr:uno .
	@arduino-cli upload --port /dev/ttyUSB0 --fqbn arduino:avr:uno .
usb1:
	@arduino-cli compile --fqbn arduino:avr:uno .
	@arduino-cli upload --port /dev/ttyUSB0 --fqbn arduino:avr:uno .
arduinoasisp:
	@arduino-cli compile --fqbn arduino:avr:uno .
	@arduino-cli upload -P arduinoasisp --port /dev/ttyUSB0 --fqbn arduino:avr:uno .
usbasp:
	@arduino-cli compile --fqbn arduino:avr:uno .
	@arduino-cli upload -P usbasp --fqbn arduino:avr:uno .
