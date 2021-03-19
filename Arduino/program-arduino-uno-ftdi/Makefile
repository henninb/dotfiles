all:
	@arduino-cli compile --fqbn arduino:avr:uno .
	@arduino-cli upload --port /dev/ttyUSB0 --fqbn arduino:avr:uno .
	@avrdude -v -patmega328p -c arduino -P /dev/ttyUSB0 -b115200 -D -Uflash:w:blink-arduino.hex:i
