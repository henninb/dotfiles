all: build
build:
	@arduino-cli compile --fqbn stm32duino:STM32F1:genericSTM32F103C6:upload_method=serialMethod .
dfu:
	@arduino-cli compile --fqbn stm32duino:STM32F1:genericSTM32F103C6:upload_method=DFUUploadMethod .
install:
	@arduino-cli upload --port /dev/ttyUSB0 --fqbn stm32duino:STM32F1:genericSTM32F103C6:upload_method=serialMethod .
install-dfu:
	@arduino-cli upload --port /dev/ttyACM0 --fqbn stm32duino:STM32F1:genericSTM32F103C6:upload_method=DFUUploadMethod .
