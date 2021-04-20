A2	A1	A0	hex
================
0	0	0	0x20
0	0	1	0x21
0	1	0	0x22
0	1	1	0x23
1	0	0	0x24
1	0	1	0x25
1	1	1	0x26
1	1	1	0x27


8mHz
avrdude: safemode: Fuses OK (E:FF, H:DF, L:62)


#default
avrdude -pattiny85 -cstk500v1 -P/dev/ttyUSB0 -b19200 -e -Uefuse:w:0xff:m -Uhfuse:w:0xdf:m -Ulfuse:w:0x62:m

avrdude -pattiny85 -cstk500v1 -P/dev/ttyUSB0 -b19200 -e -Uefuse:w:0xfe:m -Uhfuse:w:0xdd:m -Ulfuse:w:0xf1:m


* lfuse  F1 (CKSEL 001, SUT 11 i.e. PLL clock, 16CK/14CK + 64ms)
* hfuse  DD (BODlevel1 2.8V)
* efuse  FE (self program enable)


lfuse  F1 (CKSEL 001, SUT 11 i.e. 16MHz PLL clock, 16CK/14CK + 64ms)
hfuse  DD (Brownout detection level1 2.8V)
efuse  FE (self programming enable)
