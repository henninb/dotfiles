all: build
build:
	@arduino-cli compile --fqbn esp8266:esp8266:generic .
install:
	@arduino-cli upload --port /dev/ttyUSB0 --fqbn esp8266:esp8266:generic .
	@serial-monitor.py
