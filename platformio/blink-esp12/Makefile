all: build
build:
	@platformio run
arduino-cli:
	@arduino-cli compile --fqbn esp8266:esp8266:generic .
usb0:
	@arduino-cli upload --port /dev/ttyUSB0 --fqbn esp8266:esp8266:generic .
usb1:
	@arduino-cli upload --port /dev/ttyUSB1 --fqbn esp8266:esp8266:generic .
install:
	@platformio run -t upload
clean:
	@platformio run -t clean
