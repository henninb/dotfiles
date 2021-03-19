FTDI    -  UNO

GND -> GND
CTS ->GND not connected!
5V  -> 5V
TXD ->RX (D0)
RXD ->TX (D1
DTR -> Reset GND
during upload the auto-reset-function is not working, though you need to press the reset button on the arduino. I didn't figure out when exactly the button needs to be pushed. For me it worked well when I pushed the reset button when the RX-Diode on the FTDI-break out is blinking. By the way the wireconnection worked as well for the arduino pro mini.

OR: DTR -> 100nanoFahrrad capacitor  -> RESET (on Arduino)  then the auto-reset function is given!!

not working as of 3/19/2021
