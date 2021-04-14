#include <Arduino.h>
#include <Adafruit_GFX.h>
#include <Adafruit_TFTLCD.h>

#define uploadTimestamp "2021-04-14 05:27:58"

#define LCD_CS A3
#define LCD_CD A2
#define LCD_WR A1
#define LCD_RD A0
#define LCD_RESET A4
#define BLACK       0x0000
#define BLUE        0x001F
#define RED         0xF800
#define GREEN       0x07E0
#define CYAN        0x07FF
#define MAGENTA     0xF81F
#define YELLOW      0xFFE0
#define WHITE       0xFFFF
#define ORANGE      0xFD20
#define GREENYELLOW 0xAFE5
#define NAVY        0x000F
#define DARKGREEN   0x03E0
#define DARKCYAN    0x03EF
#define MAROON      0x7800
#define PURPLE      0x780F
#define OLIVE       0x7BE0
#define LIGHTGREY   0xC618
#define DARKGREY    0x7BEF

Adafruit_TFTLCD tft(LCD_CS, LCD_CD, LCD_WR, LCD_RD, LCD_RESET);

unsigned long FillScreen() {
  unsigned long start = micros();
  tft.fillScreen(RED);
  delay(500);
  tft.fillScreen(GREEN);
  delay(500);
  tft.fillScreen(BLUE);
  delay(500);
  tft.fillScreen(WHITE);
  delay(500);
  tft.fillScreen(MAGENTA);
  delay(500);
  tft.fillScreen(PURPLE);
  delay(500);
  return micros() - start;
}

unsigned long testFilledRects(uint16_t color1, uint16_t color2) {
  unsigned long start, t = 0;
  int n, i, i2, cx = tft.width() / 2 - 1, cy = tft.height() / 2 - 1;
  tft.fillScreen(BLACK);
  n = min(tft.width(), tft.height());
  for (i = n; i > 0; i -= 6) {
    i2    = i / 2;
    start = micros();
    tft.fillRect(cx - i2, cy - i2, i, i, color1);
    t    += micros() - start;
    // Outlines are not included in timing results
    tft.drawRect(cx - i2, cy - i2, i, i, color2);
  }
  return t;
}

void setup() {
 Serial.begin(9600);
 Serial.println(F("TFT LCD"));
#ifdef USE_ADAFRUIT_SHIELD_PINOUT
 Serial.println(F("Using Adafruit 2.4\" TFT Arduino Shield Pinout"));
#else
 Serial.println(F("Using Adafruit 2.4\" TFT Breakout Board Pinout"));
#endif
 Serial.print("TFT size is ");
 Serial.print(tft.width());
 Serial.print("x");
 Serial.println(tft.height());
 tft.reset();
 /* uint16_t identifier = tft.readID(); */
 /* if (identifier == 0x9325) { */
 /*   Serial.println(F("Found ILI9325 LCD driver")); */
 /* } else if (identifier == 0x9328) { */

  tft.begin(0x9341);
  Serial.println(F("Benchmark Time (microseconds)"));
  Serial.print(F("Screen fill"));
  Serial.println(FillScreen());
  delay(500);
  tft.setTextColor(YELLOW);
  tft.setCursor(70, 180);
  tft.setTextSize(1);
  tft.println("Brian");
  delay(200);
  tft.fillScreen(PURPLE);
  tft.setCursor(50, 170);
  tft.setTextSize(2);
  tft.println("Brian");
  delay(200);
  tft.fillScreen(PURPLE);
  tft.setCursor(20, 160);
  tft.setTextSize(3);
  tft.println("Brian");
  delay(500);
  tft.fillScreen(PURPLE);
  for (int rotation = 0; rotation < 4; rotation++) {
    tft.setRotation(rotation);
    tft.setCursor(0, 0);
    tft.setTextSize(3);
    tft.println("Brian");
    delay(700);
  }
  delay(500);
  Serial.print(F("Rectangles (filled) "));
  Serial.println(testFilledRects(YELLOW, MAGENTA));
  delay(500);
}

 void loop() { }
