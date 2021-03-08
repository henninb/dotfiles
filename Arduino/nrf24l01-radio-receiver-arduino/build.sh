#!/bin/sh

# arduino-cli compile --fqbn arduino:avr:uno ~/Arduino/nrf24l01-radio-transmitter-arduino
if arduino-cli compile --fqbn arduino:avr:uno .; then
  echo "build failed."
  exit 1
fi
arduino-cli upload --port /dev/ttyUSB1 --fqbn arduino:avr:uno .

exit 0
