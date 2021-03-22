//#include <TinyWireM.h>
//#include <USI_TWI_Master.h>

/*
  5V to Arduino 5V pin
  GND to Arduino GND pin
  CLK to Arduino Analog 5 SCL
  DAT to Arduino Analog 4 SDA
*/
#include <Wire.h>
#include <LiquidCrystal_I2C.h>

  // Set the LCD address to 0x27 for a 16 chars and 2 line display
  //LiquidCrystal_I2C lcd(0x27, 16, 2);
  LiquidCrystal_I2C lcd(0x3f, 16, 2);

int idx = 0;

void setup() {
  Serial.begin(9600);
  while (!Serial);

  Serial.println("I2C Scanner");
  scan();

  lcd.begin();
  lcd.backlight();
  lcd.setCursor(0, 1);
  lcd.clear();
  Wire.begin();
}

void loop() {
  idx++;
  String counter = String(idx);
  lcd.setCursor(0, 1);

  if( IsPrime(idx) == 1 ) {
    counter.concat(" is prime");
    lcd.clear();
    lcd.print(counter);
    Serial.println(counter);
    delay(5000);
  } else {
    counter.concat(" NOT prime");
    lcd.clear();
    lcd.print(counter);
    Serial.println(counter);
    delay(500);
  }
}

int IsPrime(int number) {
    int i;
    for (i=2; i<number; i++) {
        if (number % i == 0 && i != number) {
          return 0;
        }
    }
    return 1;
}

void scan() {
  byte error, address;
  int nDevices;

  Serial.println("Scanning...");

  nDevices = 0;
  for(address = 1; address < 127; address++ ) {
    // The i2c_scanner uses the return value of
    // the Write.endTransmisstion to see if
    // a device did acknowledge to the address.
    Wire.beginTransmission(address);
    error = Wire.endTransmission();

    if (error == 0) {
      Serial.print("I2C device found at address 0x");
      if (address<16) {
        Serial.print("0");
      }
      Serial.print(address,HEX);
      //Serial.println("  !");

      nDevices++;
    } else if (error==4) {
      Serial.print("Unknow error at address 0x");
      if (address<16)
        Serial.print("0");
      Serial.println(address,HEX);
    }
  }
  if (nDevices == 0) {
    Serial.println("No I2C devices found.");
  }
  else {
    Serial.println("done");
  }
  delay(5000);
}
