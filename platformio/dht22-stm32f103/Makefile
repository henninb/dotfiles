all: platformio
platformio:
	@pio lib install "adafruit/DHT sensor library"
	@pio lib install "adafruit/Adafruit Unified Sensor"
	@platformio run
install:
	@platformio run -t upload
