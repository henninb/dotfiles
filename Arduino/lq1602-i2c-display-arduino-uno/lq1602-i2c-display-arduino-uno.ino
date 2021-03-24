/*
  5V to Arduino 5V pin
  GND to Arduino GND pin
  CLK to Arduino Analog 5 SCL
  DAT to Arduino Analog 4 SDA
*/
#include <Wire.h>
#include <LiquidCrystal_I2C.h>
//#include <TinyWireM.h>
//#include <USI_TWI_Master.h>

  // Set the LCD address to 0x27 for a 16 chars and 2 line display
  //LiquidCrystal_I2C lcd(0x27, 16, 2);
  LiquidCrystal_I2C lcd(0x3f, 16, 2);

int idx = 0;

void setup() {
  Serial.begin(9600);
  while (!Serial);

  //Scanner does not seem to work to discover the device
  //
  //Serial.println("I2C Scanner");
  //scanI2c();

  lcd.begin();
  lcd.backlight();
  lcd.setCursor(0, 1);
  lcd.clear();
  Wire.begin();
  delay(2000);
}

void loop() {
  idx++;
  String counter = String(idx);
  lcd.setCursor(0, 1);

  if( isPrime(idx) == 1 ) {
    counter.concat(" is prime");
    lcd.clear();
    lcd.print(counter);
    //scrollInFromLeft(0, counter);
    Serial.println(counter);
   
    delay(5000);
  } else {
    counter.concat(" NOT prime");
    lcd.clear();
    lcd.print(counter);
    //scrollInFromLeft(1, "is not prime");
    Serial.println(counter);
    delay(500);
  }
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

void scrollInFromRight (int line, char str1[]) {
  int i = strlen(str1);
  int k = 0;
  int j = 0;

  for (j = 16; j >= 0; j--) {

    lcd.setCursor(0, line);

    for (k = 0; k <= 15; k++) {
      lcd.print(" "); // Clear line
    }

    lcd.setCursor(j, line);
    lcd.print(str1);
    delay(350);
  }
}

void scrollInFromLeft( int line, char str1[] ) {
  int i = 40 - strlen(str1);
  int k = 0;
  int j = 0;

  line = line - 1;

  for( j = i; j <= i + 16; j++ ) {
    for ( k = 0; k <= 15; k++ ) {
      lcd.print(" ");
    }
    lcd.setCursor(j, line);
    lcd.print(str1);
    delay(350);
  }
}

// is not working as of 3/23/2021
void scanI2c() {
  byte error;
  byte address;
  int nDevices = 0;

  Serial.println("Scanning...");
  delay(5000);
  
  for (byte address = 1; address < 127; ++address) {
    Wire.beginTransmission(address);
    byte error = Wire.endTransmission();

    if (error == 0) {
      Serial.print("I2C device found at address 0x");
      if (address < 16) {
        Serial.print("0");
      }
      Serial.print(address, HEX);
      Serial.println("");

      ++nDevices;
    } else if (error == 4) {
      Serial.print("Unknown error at address 0x");
      if (address < 16) {
        Serial.print("0");
      }
      Serial.println(address, HEX);
    }
  }
  if (nDevices == 0) {
    Serial.println("No I2C devices found");
  } else {
    Serial.println("I2C scan completed.");
  }
  Serial.println("");

}
