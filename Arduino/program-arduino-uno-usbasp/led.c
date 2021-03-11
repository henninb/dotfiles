#define F_CPU 1000000UL
/* #include <avr/io.h> */
/* #include <util/delay.h> */

int main() {

 DDRC = 255;

 while(1){

 PORTC=255;
 _delay_ms(200);

 PORTC=0;
 _delay_ms(200);
 }
 return 0;
}


