#!/usr/bin/env python

from datetime import datetime
import serial
import sys

device="/dev/ttyUSB0"

if len(sys.argv) != 1 and len(sys.argv) != 2:
    print("not zero or one\n");
if len(sys.argv) == 2:
    device=sys.argv[1]

print("Serial Monitor");
print(device)
#     for i, arg in enumerate(sys.argv):
#         print(f"Argument {i:>6}: {arg}")

ser = serial.Serial( port=device, baudrate = 9600, parity=serial.PARITY_NONE, stopbits=serial.STOPBITS_ONE, bytesize=serial.EIGHTBITS, timeout=1)

while 1:
  try:
    payload = ser.readline()
    # print(payload)
    string = payload.decode('UTF-8').strip("\r\n")
    if string != "":
      print(str(datetime.now()) + "  " + string)
  except serial.serialutil.SerialException:
    print("serial port disconnected.")
  except UnicodeDecodeError:
    print("non printable char found.")
    print(payload)
