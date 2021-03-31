the 0.1uF (100 nF) ceramic cap between vcc and gnd of the tiny 85 is required for proper operation.

  ATtiny 85
                ------
         Reset |1    8| Vcc
     ADC3, PB3 |2    7| PB2, SCL, ADC1
     ADC2, PB4 |3    6| PB1, MISO, PWM
           GND |4    5| PB0, MOSI, PWM, SDA
                ------
