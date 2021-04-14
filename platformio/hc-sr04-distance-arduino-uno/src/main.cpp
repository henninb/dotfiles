#include <NewPing.h>

#define uploadTimestamp "2021-04-14 05:27:58"

#define MAX_DISTANCE 400 // Maximum distance we want to ping for (in centimeters).
                         //Maximum sensor distance is rated at 400-500cm.

#define triggerPin 13
#define echoPin 12

NewPing sonar(triggerPin, echoPin, MAX_DISTANCE); // NewPing setup of pins and maximum distance.

int distanceIn;
int distanceCm;

void setup() {
  Serial.begin(9600);
  while(!Serial);
  delay(2000);
  Serial.print("upload timestamp: ");
  Serial.println(uploadTimestamp);
  Serial.println("UltraSonic Distance Measurement - setup completed.");
}


void loop() {
  delay(1000);
  distanceIn = sonar.ping_in();
  Serial.print("Distance: ");
  Serial.print(distanceIn);
                            // (0 = outside set distance range, no ping echo)
  Serial.println(" inches");

  delay(100);
  distanceCm = sonar.ping_cm();
  Serial.print("Distance: ");
  Serial.print(distanceCm);
  Serial.println(" centimeters");
}
