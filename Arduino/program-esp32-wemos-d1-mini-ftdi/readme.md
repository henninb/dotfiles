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


Using the CP2102 drivers from silabs will fail if your CP2102 is fake (as about 80% are). There are special "hacked" drivers you need (no idea where they are, I use Linux which never has any of these issues). 


i will try that
[7:33 AM]
that doesn't seem to work. here is how the esptool is called.
esptool.py --chip esp32 --port /dev/ttyUSB0 --baud 115200 --before default_reset --after hard
[7:36 AM]
i appreciate your help by the way.  i have run out of ideas.
￼
JustinOng — Today at 7:36 AM
if you connect to the ESP32 over UART at 115200, could you confirm that you see something about "waiting for download" when you press and release the RST button?
￼
henninb — Today at 7:37 AM
in the serial monitor. let me check.
￼
@henninb
i appreciate your help by the way.  i have run out of ideas.
￼
JustinOng — Today at 7:37 AM
my advice soon is going to be "repair the USB interface or get a new one"  ￼
￼
@JustinOng
my advice soon is going to be "repair the USB interface or get a new one"  ￼
￼
henninb — Today at 7:38 AM
makes sense ￼
[7:39 AM]
i am not seeing anything in the serial monitor, to your point above I should see something.
￼
JustinOng — Today at 7:41 AM
Thats odd...you should see a message like this upon reset since GPIO0 is pulled to ground https://discord.com/channels/401811448470306818/401889075117948939/829576313315786772
[7:42 AM]
still nothing even if you held down the BOOT button, then pressed and released RST button?
￼
henninb — Today at 7:42 AM
i only have a reset button on this particular module.
￼
JustinOng — Today at 7:44 AM
Ah
￼
henninb — Today at 7:44 AM
my understanding is the reset button is mapped to the EN (enable pin) on the chip.
￼
JustinOng — Today at 7:45 AM
Yeah, the esptool documentation suggests you can pass --before no_reset --after no_reset to get it ignore control signals
[7:46 AM]
My current train of thought is to manually enter the serial bootloader mode (ie the "waiting for download" message), then no_reset should just program it directly
[7:46 AM]
I don't have any idea as to why its not entering the bootloader mode though
