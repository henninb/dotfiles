import machine
import os
import network

pin2 = machine.Pin(2, machine.Pin.OUT)
pin2.value(1)
pin2.value(0)

# sta_if = network.WLAN(network.STA_IF); sta_if.active(True)
# sta_if.scan()
# sta_if.connect("CNX-TRANSLATION", "password")
# os.listdir()
# print ("ESP32 PICO Core says Hello")
# machine.reset()
