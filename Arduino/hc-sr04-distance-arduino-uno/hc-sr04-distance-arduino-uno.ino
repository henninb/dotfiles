#include <NewPing.h>

#define  TRIGGER_PIN  13
#define  ECHO_PIN     12
#define MAX_DISTANCE 400 // Maximum distance we want to ping for (in centimeters).
                         //Maximum sensor distance is rated at 400-500cm.

NewPing sonar(TRIGGER_PIN, ECHO_PIN, MAX_DISTANCE); // NewPing setup of pins and maximum distance.

int DistanceIn;
int DistanceCm;

#define trigPin 13
#define echoPin 12
//#define led 11
//#define led2 10

void setup() {
  Serial.begin(9600);
  while(!Serial);
  Serial.println("UltraSonic Distance Measurement - setup completed.");
}


void loop() {
  delay(1000);// Wait 100ms between pings (about 10 pings/sec). 29ms should be the shortest delay between pings.
  DistanceIn = sonar.ping_in();
  Serial.print("Distance: ");
  Serial.print(DistanceIn); // Convert ping time to distance and print result
                            // (0 = outside set distance range, no ping echo)
  Serial.print(" in     ");

  delay(100);// Wait 100ms between pings (about 10 pings/sec). 29ms should be the shortest delay between pings.
  DistanceCm = sonar.ping_cm();
  Serial.print("Distance: ");
  Serial.print(DistanceCm);
  Serial.println(" cm");
}
