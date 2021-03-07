#!/usr/bin/env python

# import time
import serial
import codecs

ser = serial.Serial(
  port='/dev/ttyUSB0',
  baudrate = 9600,
  parity=serial.PARITY_NONE,
  stopbits=serial.STOPBITS_ONE,
  bytesize=serial.EIGHTBITS,
  timeout=1
)

while 1:
  payload = ser.readline()
  string = payload.decode('UTF-8').strip("\r\n")
  if string != "":
    print(string)
  # else:
  #   print("is not empty")
