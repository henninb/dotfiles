/*
I2C1
SDA=PB7
SCL=PB6

  5V to stm32f103 5V pin
  GND to stm32f103 GND pin
*/
/* #include <LiquidCrystal_I2C.h> */
/* #include <LiquidCrystalIO.h> */
#include <LiquidCrystal_I2C.h>

#define ledPin PC13

int isPrime( int );

/* LiquidCrystal_I2C lcd(0x27); */
LiquidCrystal_I2C lcd(0x3f);
/* LiquidCrystal_I2C lcd(0x3f, 16, 2); */

int idx = 0;

void setup() {
  Serial.begin(9600);
  while (!Serial);
  Serial.println("setup started...");
  pinMode(ledPin,OUTPUT);
  lcd.begin(16, 2);
  /* lcd.backlight(); */
  delay(500);
  /* lcd.noBacklight(); */
  lcd.setCursor(0, 0);
  lcd.clear();
  lcd.print("Hello, world!");
  delay(2000);
  Serial.println("setup completed...");
}

void loop() {
  idx++;
  /* lcd.backlight(); */
  String message = String(idx);
  lcd.setCursor(0, 0);

  if( isPrime(idx) == 1 ) {
    message.concat(" is prime");
    lcd.clear();
    /* lcd.backlight(); */
    lcd.print(message);
    Serial.println(message);
  } else {
    message.concat(" NOT prime");
    lcd.clear();
    lcd.print(message);
    Serial.println(message);
  }
  /* lcd.noBacklight(); */
  digitalWrite(ledPin, HIGH);
  delay(2000);
  digitalWrite(ledPin, LOW);
  delay(2000);
}

int isPrime(int number) {
    int i;
    for (i=2; i<number; i++) {
        if (number % i == 0 && i != number) {
          return 0;
        }
    }
    return 1;
}
