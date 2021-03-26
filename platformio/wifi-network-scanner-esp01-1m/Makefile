all: build
build:
	@platformio run
	# @platformio run -t uploa
usb0:
	@arduino-cli compile --fqbn esp8266:esp8266:generic .
	@arduino-cli upload --port /dev/ttyUSB0 --fqbn esp8266:esp8266:generic .
install:
	@platformio run -t upload
clean:
	@platformio run -t clean
