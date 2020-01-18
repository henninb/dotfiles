# radio

## tool
git@github.com:rxseger/rx_tools.git

## get info Software Defined Radio (SDR)
lsusb

The last line was the Realtek dongle:
Bus 001 Device 008: ID 0bda:2838 Realtek Semiconductor Corp.

The important parts are "0bda" (the vendor id) and "2838" (the product id).

Create a new file as root named /etc/udev/rules.d/20.rtlsdr.rules that contains the following line:

SUBSYSTEM=="usb", ATTRS{idVendor}=="0bda", ATTRS{idProduct}=="2838", GROUP="adm", MODE="0666", SYMLINK+="rtl_sdr"

## FM stations - Minneapolis
- 107900.000
- 92500.000
- 102100.000

## Linux Front end SDR software
- gqrx

## Baofeng UV-5R
- Station for family walkie talkie
- 467.287


 police fire and rescure

 radio reference

Hi,Civil Channel of United States is 462-467.You needn't license in these channel.
The frequency of this radio is UHF 400-470MHz,So,you can tuned on 462-467 channel,then you needn't have license

aprs

## Family Radio Service (FRS)
Channel	Frequency (MHz)
1	462.5625
2	462.5875
3	462.6125
4	462.6375
5	462.6625
6	462.6875
7	462.7125
8	467.5625
9	467.5875
10	467.6125
11	467.6375
12	467.6625
13	467.6875
14	467.7125
15	462.5500
16	462.5750
17	462.6000
18	462.6250
19	462.6500
20	462.6750
21	462.7000
22	462.7250
