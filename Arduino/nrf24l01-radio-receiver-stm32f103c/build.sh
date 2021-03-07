#!/bin/sh

arduino-cli compile --fqbn stm32duino:STM32F1:genericSTM32F103C6:upload_method=serialMethod .
arduino-cli upload --port /dev/ttyUSB1 --fqbn stm32duino:STM32F1:genericSTM32F103C6:upload_method=serialMethod .

exit 0
