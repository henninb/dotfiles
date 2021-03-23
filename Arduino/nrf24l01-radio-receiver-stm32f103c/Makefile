all: usb1
usb1:
	@arduino-cli compile --fqbn stm32duino:STM32F1:genericSTM32F103C6:upload_method=serialMethod .
	@arduino-cli upload --port /dev/ttyUSB1 --fqbn stm32duino:STM32F1:genericSTM32F103C6:upload_method=serialMethod .
usb0:
	@arduino-cli compile --fqbn stm32duino:STM32F1:genericSTM32F103C6:upload_method=serialMethod .
	@arduino-cli upload --port /dev/ttyUSB0 --fqbn stm32duino:STM32F1:genericSTM32F103C6:upload_method=serialMethod .
