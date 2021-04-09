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


1) VDD = tied to 3.3V
2) GND = all GND pins tied to GND
3) EN = pulled up via 10k resistor to 3.3V

4) IO0 = jumper to flip between being pulled up via 10k to 3.3v or pulled down via 10k to GND (for flashing)
5) IO2 = IO0 = pulled to GND via 10k resistor
