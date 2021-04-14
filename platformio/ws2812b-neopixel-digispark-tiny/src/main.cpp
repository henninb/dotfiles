#include <SoftSerial.h>
#include <Adafruit_NeoPixel.h>
#ifdef __AVR__
  #include <avr/power.h>
#endif

#define uploadTimestamp "2021-04-14 05:27:58"
#define PIN 0
#define pixelCount 16

// pixels.Color takes RGB values, from 0,0,0 up to 255,255,255
// When we setup the NeoPixel library, we tell it how many pixels, and which pin to use to send signals.
// Note that for older NeoPixel strips you might need to change the third parameter--see the strandtest
// example for more information on possible values.
Adafruit_NeoPixel pixels = Adafruit_NeoPixel(pixelCount, PIN, NEO_GRB + NEO_KHZ800);

#define RX    3
#define TX    4
SoftSerial mySerial(RX, TX);

void setup() {
/* #if defined (__AVR_ATtiny85__) */
/*   if (F_CPU == 16000000) clock_prescale_set(clock_div_1); */
/* #endif */
  // End of trinket special code
  mySerial.begin(9600);

  pixels.begin();
  pixels.setBrightness(25);
  pinMode(1, OUTPUT);
}

void loop() {

  pixels.show();
  for( unsigned int idx = 0; idx < pixels.numPixels(); idx++ ) {
    pixels.setPixelColor(idx, pixels.Color(200,0,0)); // red
    pixels.show();
    delay(250);
  }

  pixels.clear();

  pixels.show();
  for( unsigned int idx = 0; idx < pixels.numPixels(); idx++ ) {
    pixels.setPixelColor(idx, pixels.Color(255,255,0)); // yellow
    pixels.show();
    delay(250);
  }

  pixels.clear();

  pixels.show();
  for( unsigned int idx = 0; idx < pixels.numPixels(); idx++ ) {
    pixels.setPixelColor(idx, pixels.Color(0,150,0)); // green
    pixels.show();
    delay(250);
  }

  pixels.clear();

  mySerial.println("end of loop");
  digitalWrite(1, HIGH);
  delay(1000);
  digitalWrite(1, LOW);
  delay(1000);
}
