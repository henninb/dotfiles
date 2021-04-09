## flash size
generic.menu.eesz.4M2M=4MB (FS:2MB OTA:~1019KB)

[env:myenv]
board_build.ldscript = eagle.flash.4m.ld

https://www.instructables.com/Using-ESP8266-SPIFFS/

esptool.py -p /dev/ttyUSB0 flash_id

python esptool.py -p /dev/ttyUSB0 flash_id
/*
  Operational Mode (6 wires)
  ESP01    | FTDI
  ===============
  VCC      | 3.3V
  GND      | GND
  TX       | RX
  RX       | TX
  GPIO0    | DTR
  CHPD     | 3.3V
  *** Required 1000uF capacitor (between VCC and GND), shorter leg=GND
  Optional RST - to button for resetting
*/

/*
  Programming Mode (7 wires)
  ESP12    | FTDI
  ===============
  VCC      | 3.3V
  GND      | GND
  TX       | RX
  RX       | TX
  RST      | RTS
  GPIO0    | DTR
  CHPD     | 3.3V
  1000uF capacitor (between VCC and GND), shorter leg=GND
*/
