all: platformio
platformio:
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
	@platformio run
