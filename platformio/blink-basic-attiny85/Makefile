date=$(shell date '+%Y-%m-%d %H:%M:%S')
all:
	# @avr-gcc -Os -mmcu=attiny85 blink.c -nostdlib
	@avr-gcc -g -Os -Wall -mcall-prologues -DF_CPU=16000000UL -mmcu=attiny85 -c -o blink.o blink.c
