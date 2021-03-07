#!/bin/sh

# arduino-cli compile --fqbn arduino:avr:uno ~/Arduino/nrf24l01-radio-transmitter-arduino
arduino-cli compile --fqbn arduino:avr:uno .
arduino-cli upload --port /dev/ttyUSB0 --fqbn arduino:avr:uno .

exit 0
