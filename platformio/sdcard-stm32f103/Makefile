all: build
build:
	@platformio run
install:
	@platformio run -t upload
	@platformio device monitor
clean:
	@pio run --target clean
