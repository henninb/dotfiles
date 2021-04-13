

minicom --baudrate 115200 --device /dev/ttyUSB0

pip install adafruit-ampy --upgrade

import machine
pin21 = machine.Pin(21, machine.Pin.OUT)
pin21.value(1)
pin21.value(0)



ampy --port /dev/ttyUSB0 run blink.py
ampy --port /dev/ttyUSB0 run blink.py
