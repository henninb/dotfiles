#include <SPI.h>
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
#include "config.h"

/*
oled | arduino uno
SDA  | SDA
SDL  | SDL
VCC  | 5V
GND  | GND
*/

#define SCREEN_WIDTH 128 // OLED display width, in pixels
#define SCREEN_HEIGHT 64 // OLED display height, in pixels

// Declaration for an SSD1306 display connected to I2C (SDA, SCL pins)
#define OLED_RESET     -1 // Reset pin # (or -1 if sharing Arduino reset pin)
Adafruit_SSD1306 oled(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, OLED_RESET);

#define NUMFLAKES     10 // Number of snowflakes in the animation example

#define LOGO_HEIGHT   16
#define LOGO_WIDTH    16
static const unsigned char PROGMEM logo_bmp[] =
{ B00000000, B11000000,
  B00000001, B11000000,
  B00000001, B11000000,
  B00000011, B11100000,
  B11110011, B11100000,
  B11111110, B11111000,
  B01111110, B11111111,
  B00110011, B10011111,
  B00011111, B11111100,
  B00001101, B01110000,
  B00011011, B10100000,
  B00111111, B11100000,
  B00111111, B11110000,
  B01111100, B11110000,
  B01110000, B01110000,
  B00000000, B00110000 };


void testdrawline() {
  int16_t i;

  oled.clearDisplay(); // Clear display buffer

  for(i=0; i<oled.width(); i+=4) {
    oled.drawLine(0, 0, i, oled.height()-1, WHITE);
    oled.display(); // Update screen with each newly-drawn line
    delay(1);
  }
  for(i=0; i<oled.height(); i+=4) {
    oled.drawLine(0, 0, oled.width()-1, i, WHITE);
    oled.display();
    delay(1);
  }
  delay(250);

  oled.clearDisplay();

  for(i=0; i<oled.width(); i+=4) {
    oled.drawLine(0, oled.height()-1, i, 0, WHITE);
    oled.display();
    delay(1);
  }
  for(i=oled.height()-1; i>=0; i-=4) {
    oled.drawLine(0, oled.height()-1, oled.width()-1, i, WHITE);
    oled.display();
    delay(1);
  }
  delay(250);

  oled.clearDisplay();

  for(i=oled.width()-1; i>=0; i-=4) {
    oled.drawLine(oled.width()-1, oled.height()-1, i, 0, WHITE);
    oled.display();
    delay(1);
  }
  for(i=oled.height()-1; i>=0; i-=4) {
    oled.drawLine(oled.width()-1, oled.height()-1, 0, i, WHITE);
    oled.display();
    delay(1);
  }
  delay(250);

  oled.clearDisplay();

  for(i=0; i<oled.height(); i+=4) {
    oled.drawLine(oled.width()-1, 0, 0, i, WHITE);
    oled.display();
    delay(1);
  }
  for(i=0; i<oled.width(); i+=4) {
    oled.drawLine(oled.width()-1, 0, i, oled.height()-1, WHITE);
    oled.display();
    delay(1);
  }

  delay(2000); // Pause for 2 seconds
}

void testdrawrect(void) {
  oled.clearDisplay();

  for(int16_t i=0; i<oled.height()/2; i+=2) {
    oled.drawRect(i, i, oled.width()-2*i, oled.height()-2*i, WHITE);
    oled.display(); // Update screen with each newly-drawn rectangle
    delay(1);
  }

  delay(2000);
}

void testfillrect(void) {
  oled.clearDisplay();

  for(int16_t i=0; i<oled.height()/2; i+=3) {
    // The INVERSE color is used so rectangles alternate white/black
    oled.fillRect(i, i, oled.width()-i*2, oled.height()-i*2, INVERSE);
    oled.display(); // Update screen with each newly-drawn rectangle
    delay(1);
  }

  delay(2000);
}

void testdrawcircle(void) {
  oled.clearDisplay();

  for(int16_t i=0; i<max(oled.width(),oled.height())/2; i+=2) {
    oled.drawCircle(oled.width()/2, oled.height()/2, i, WHITE);
    oled.display();
    delay(1);
  }

  delay(2000);
}

void testfillcircle(void) {
  oled.clearDisplay();

  for(int16_t i=max(oled.width(),oled.height())/2; i>0; i-=3) {
    // The INVERSE color is used so circles alternate white/black
    oled.fillCircle(oled.width() / 2, oled.height() / 2, i, INVERSE);
    oled.display(); // Update screen with each newly-drawn circle
    delay(1);
  }

  delay(2000);
}

void testdrawroundrect(void) {
  oled.clearDisplay();

  for(int16_t i=0; i<oled.height()/2-2; i+=2) {
    oled.drawRoundRect(i, i, oled.width()-2*i, oled.height()-2*i,
      oled.height()/4, WHITE);
    oled.display();
    delay(1);
  }

  delay(2000);
}

void testfillroundrect(void) {
  oled.clearDisplay();

  for(int16_t i=0; i<oled.height()/2-2; i+=2) {
    // The INVERSE color is used so round-rects alternate white/black
    oled.fillRoundRect(i, i, oled.width()-2*i, oled.height()-2*i,
      oled.height()/4, INVERSE);
    oled.display();
    delay(1);
  }

  delay(2000);
}

void testdrawtriangle(void) {
  oled.clearDisplay();

  for(int16_t i=0; i<max(oled.width(),oled.height())/2; i+=5) {
    oled.drawTriangle(
      oled.width()/2  , oled.height()/2-i,
      oled.width()/2-i, oled.height()/2+i,
      oled.width()/2+i, oled.height()/2+i, WHITE);
    oled.display();
    delay(1);
  }

  delay(2000);
}

void testfilltriangle(void) {
  oled.clearDisplay();

  for(int16_t i=max(oled.width(),oled.height())/2; i>0; i-=5) {
    // The INVERSE color is used so triangles alternate white/black
    oled.fillTriangle(
      oled.width()/2  , oled.height()/2-i,
      oled.width()/2-i, oled.height()/2+i,
      oled.width()/2+i, oled.height()/2+i, INVERSE);
    oled.display();
    delay(1);
  }

  delay(2000);
}

void testdrawchar(void) {
  oled.clearDisplay();

  oled.setTextSize(1);      // Normal 1:1 pixel scale
  oled.setTextColor(WHITE); // Draw white text
  oled.setCursor(0, 0);     // Start at top-left corner
  oled.cp437(true);         // Use full 256 char 'Code Page 437' font

  // Not all the characters will fit on the oled. This is normal.
  // Library will draw what it can and the rest will be clipped.
  for(int16_t i=0; i<256; i++) {
    if(i == '\n') oled.write(' ');
    else          oled.write(i);
  }

  oled.display();
  delay(2000);
}

void testdrawstyles(void) {
  oled.clearDisplay();

  oled.setTextSize(1);             // Normal 1:1 pixel scale
  oled.setTextColor(WHITE);        // Draw white text
  oled.setCursor(0,0);             // Start at top-left corner
  oled.println(F("Hello, world!"));

  oled.setTextColor(BLACK, WHITE); // Draw 'inverse' text
  oled.println(3.141592);

  oled.setTextSize(2);             // Draw 2X-scale text
  oled.setTextColor(WHITE);
  oled.print(F("0x")); oled.println(0xDEADBEEF, HEX);

  oled.display();
  delay(2000);
}

void testscrolltext(void) {
  oled.clearDisplay();

  oled.setTextSize(2); // Draw 2X-scale text
  oled.setTextColor(WHITE);
  oled.setCursor(10, 0);
  oled.println(F("scroll"));
  oled.display();      // Show initial text
  delay(100);

  // Scroll in various directions, pausing in-between:
  oled.startscrollright(0x00, 0x0F);
  delay(2000);
  oled.stopscroll();
  delay(1000);
  oled.startscrollleft(0x00, 0x0F);
  delay(2000);
  oled.stopscroll();
  delay(1000);
  oled.startscrolldiagright(0x00, 0x07);
  delay(2000);
  oled.startscrolldiagleft(0x00, 0x07);
  delay(2000);
  oled.stopscroll();
  delay(1000);
}

void testdrawbitmap(void) {
  oled.clearDisplay();

  oled.drawBitmap(
    (oled.width()  - LOGO_WIDTH ) / 2,
    (oled.height() - LOGO_HEIGHT) / 2,
    logo_bmp, LOGO_WIDTH, LOGO_HEIGHT, 1);
  oled.display();
  delay(1000);
}

#define XPOS   0 // Indexes into the 'icons' array in function below
#define YPOS   1
#define DELTAY 2

void testanimate(const uint8_t *bitmap, uint8_t w, uint8_t h) {
  int8_t f, icons[NUMFLAKES][3];

  // Initialize 'snowflake' positions
  for(f=0; f< NUMFLAKES; f++) {
    icons[f][XPOS]   = random(1 - LOGO_WIDTH, oled.width());
    icons[f][YPOS]   = -LOGO_HEIGHT;
    icons[f][DELTAY] = random(1, 6);
    Serial.print(F("x: "));
    Serial.print(icons[f][XPOS], DEC);
    Serial.print(F(" y: "));
    Serial.print(icons[f][YPOS], DEC);
    Serial.print(F(" dy: "));
    Serial.println(icons[f][DELTAY], DEC);
  }

  for(;;) { // Loop forever...
    oled.clearDisplay(); // Clear the display buffer

    // Draw each snowflake:
    for(f=0; f< NUMFLAKES; f++) {
      oled.drawBitmap(icons[f][XPOS], icons[f][YPOS], bitmap, w, h, WHITE);
    }

    oled.display(); // Show the display buffer on the screen
    delay(200);        // Pause for 1/10 second

    // Then update coordinates of each flake...
    for(f=0; f< NUMFLAKES; f++) {
      icons[f][YPOS] += icons[f][DELTAY];
      // If snowflake is off the bottom of the screen...
      if (icons[f][YPOS] >= oled.height()) {
        // Reinitialize to a random position, just off the top
        icons[f][XPOS]   = random(1 - LOGO_WIDTH, oled.width());
        icons[f][YPOS]   = -LOGO_HEIGHT;
        icons[f][DELTAY] = random(1, 6);
      }
    }
  }
}

void setup() {
  Serial.begin(9600);
  while( !Serial);
  Serial.println("setup");
  // SSD1306_SWITCHCAPVCC = generate display voltage from 3.3V internally
  if(!oled.begin(SSD1306_SWITCHCAPVCC, 0x3C)) {
    Serial.println(F("SSD1306 allocation failed"));
    while (true);
  }

  Serial.println("setup started...");
  // Show initial display buffer contents on the screen --
  // the library initializes this with an Adafruit splash screen.
  oled.display();
  delay(2000); // Pause for 2 seconds

  // Clear the buffer
  oled.clearDisplay();

  // Draw a single pixel in white
  oled.drawPixel(10, 10, WHITE);

  // Show the display buffer on the screen. You MUST call display() after
  // drawing commands to make them visible on screen!
  oled.display();
  delay(2000);
  // oled.display() is NOT necessary after every single drawing command,
  // unless that's what you want...rather, you can batch up a bunch of
  // drawing operations and then update the screen all at once by calling
  // oled.display(). These examples demonstrate both approaches...

  testdrawline();      // Draw many lines

  testdrawrect();      // Draw rectangles (outlines)

  testfillrect();      // Draw rectangles (filled)

  testdrawcircle();    // Draw circles (outlines)

  testfillcircle();    // Draw circles (filled)

  testdrawroundrect(); // Draw rounded rectangles (outlines)

  testfillroundrect(); // Draw rounded rectangles (filled)

  testdrawtriangle();  // Draw triangles (outlines)

  testfilltriangle();  // Draw triangles (filled)

  testdrawchar();      // Draw characters of the default font

  testdrawstyles();    // Draw 'stylized' characters

  testscrolltext();    // Draw scrolling text

  testdrawbitmap();    // Draw a small bitmap image

  // Invert and restore display, pausing in-between
  oled.invertDisplay(true);
  delay(1000);
  oled.invertDisplay(false);
  delay(1000);

  testanimate(logo_bmp, LOGO_WIDTH, LOGO_HEIGHT); // Animate bitmaps

  Serial.print("upload timestamp: ");
  Serial.println(uploadTimestamp);
  Serial.println("setup completed");
}

void loop() {
}
