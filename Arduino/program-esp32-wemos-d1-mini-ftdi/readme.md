ESP32 Wemos D1 | FTDI
VCC            | 3.3v
GND            | GND
RX             | TX
TX             | RX

GPI0 to GND (on the esp32)


CTS -----------------> GPIO 15
RTS -----------------> GPIO 13 AND GPIO IO0
RX -----------------> TXD0
TX -----------------> RXD0
DTR -----------------> EN
VCC -----------------> Vin
GND -----------------> GND


https://electronics.stackexchange.com/questions/448187/esp32-with-ftdi-programmer


Vcc, GND, TX, and RX 



are all the same as yours. GPIO 0 to DTR.
RST on ESP to RTS on the FTDI. EN may need a pullup. I forget if the chips have them built in.


