all: usb0
usb0:
	@arduino-cli compile --fqbn arduino:avr:uno .
	@arduino-cli upload --port /dev/ttyUSB0 --fqbn arduino:avr:uno .
	@./serial-monitor.py
usbasp:
	@arduino-cli compile --fqbn arduino:avr:uno .
	@arduino-cli upload -P usbasp --fqbn arduino:avr:uno .
