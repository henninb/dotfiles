## flash size
generic.menu.eesz.4M2M=4MB (FS:2MB OTA:~1019KB)


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
