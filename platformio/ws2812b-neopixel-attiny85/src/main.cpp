#include <Adafruit_NeoPixel.h>
#ifdef __AVR__
  #include <avr/power.h>
#endif

#define PIN 0

#define NUMPIXELS 16

// When we setup the NeoPixel library, we tell it how many pixels, and which pin to use to send signals.
// Note that for older NeoPixel strips you might need to change the third parameter--see the strandtest
// example for more information on possible values.
Adafruit_NeoPixel pixels = Adafruit_NeoPixel(NUMPIXELS, PIN, NEO_GRB + NEO_KHZ800);


void setup() {
/* #if defined (__AVR_ATtiny85__) */
/*   if (F_CPU == 16000000) clock_prescale_set(clock_div_1); */
/* #endif */
  // End of trinket special code

  pixels.begin(); // This initializes the NeoPixel library.
}

void loop() {
  for( unsigned int i = 0; i < NUMPIXELS; i++ ) {

    // pixels.Color takes RGB values, from 0,0,0 up to 255,255,255
    pixels.setPixelColor(i, pixels.Color(0,150,0)); // Moderately bright green color.

    pixels.show();
    delay(1000);
  }
}
