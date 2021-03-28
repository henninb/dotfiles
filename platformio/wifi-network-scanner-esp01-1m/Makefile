all: build
build:
	@platformio run
usb0:
	@arduino-cli compile --fqbn esp8266:esp8266:generic .
	@arduino-cli upload --port /dev/ttyUSB0 --fqbn esp8266:esp8266:generic .
install:
	@platformio run -t upload
	@platformio device monitor
clean:
	@platformio run -t clean
