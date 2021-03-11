#!/usr/bin/env python

from datetime import datetime
# import time
# import codecs
import serial

ser = serial.Serial(
  port='/dev/ttyUSB0',
  baudrate = 115200,
  parity=serial.PARITY_NONE,
  stopbits=serial.STOPBITS_ONE,
  bytesize=serial.EIGHTBITS,
  timeout=1
)

while 1:
  payload = ser.readline()
  print(payload)
  # string = payload.decode('UTF-8').strip("\r\n")
  # if string != "":
  #   print(str(datetime.now()) + "  " + string)
