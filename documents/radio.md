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
- Frequency Range: 136-174MHz and 400-520 MHz
- Transmit on Narrowband (12.5 kHz) and Wideband (25 kHz).
- 128 channels total

## GMRS - general mobile radio service
- requires licence

## ham radio band
- starts at 140 mHz
- 2 meter band
- 7 meter band
- national callin freq - (7 meter) 147.52
- (2 meter) 466.0

## police fire and rescure
radio reference

## aprs

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

CB Channel	Frequency	Typical Use (US)
Channel 1	26.965 MHz
Channel 2	26.975 MHz
Channel 3	26.985 MHz
Channel 4	27.005 MHz
Channel 5	27.015 MHz
Channel 6	27.025 MHz
Channel 7	27.035 MHz
Channel 8	27.055 MHz
Channel 9	27.065 MHz
Channel 10	27.075 MHz
Channel 11	27.085 MHz
Channel 12	27.105 MHz
Channel 13	27.115 MHz
Channel 14	27.125 MHz
Channel 15	27.135 MHz
Channel 16	27.155 MHz
Channel 17	27.165 MHz
Channel 18	27.175 MHz
Channel 19	27.185 MHz
Channel 20	27.205 MHz
Channel 21	27.215 MHz
Channel 22	27.225 MHz
Channel 23	27.255 MHz
Channel 24	27.235 MHz
Channel 25	27.245 MHz
Channel 26	27.265 MHz
Channel 27	27.275 MHz
Channel 28	27.285 MHz
Channel 29	27.295 MHz
Channel 30	27.305 MHz
Channel 31	27.315 MHz
Channel 32	27.325 MHz
Channel 33	27.335 MHz
Channel 34	27.345 MHz
Channel 35	27.355 MHz
Channel 36	27.365 MHz
Channel 37	27.375 MHz
Channel 38	27.385 MHz
Channel 39	27.395 MHz
Channel 40	27.405 MHz

## FM frequencies
92.500 MHz

## NOAA
167.75	168	NOAA Weather Radio (162)
215.75	216	TV ch. 13
