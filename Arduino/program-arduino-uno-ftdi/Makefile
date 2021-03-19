all:
	@arduino-cli compile --fqbn arduino:avr:uno .
	@arduino-cli upload --port /dev/ttyUSB0 --fqbn arduino:avr:uno .

	@avr-g++ -c -g -Os -w -std=gnu++11 -fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics -Wno-error=narrowing -flto -w -x c++ -E -CC -mmcu=atmega328p -DF_CPU=16000000L -DARDUINO=10813 -DARDUINO_AVR_UNO -DARDUINO_ARCH_AVR -I/home/henninb/.arduino15/packages/arduino/hardware/avr/1.8.3/cores/arduino -I/home/henninb/.arduino15/packages/arduino/hardware/avr/1.8.3/variants/standard /tmp/arduino_build_956759/sketch/blink-arduino.ino.cpp -o /dev/null -DARDUINO_LIB_DISCOVERY_PHASE

	@avr-g++ -c -g -Os -w -std=gnu++11 -fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics -Wno-error=narrowing -flto -w -x c++ -E -CC -mmcu=atmega328p -DF_CPU=16000000L -DARDUINO=10813 -DARDUINO_AVR_UNO -DARDUINO_ARCH_AVR -I/home/henninb/.arduino15/packages/arduino/hardware/avr/1.8.3/cores/arduino -I/home/henninb/.arduino15/packages/arduino/hardware/avr/1.8.3/variants/standard /tmp/arduino_build_956759/sketch/blink-arduino.ino.cpp -o /tmp/arduino_build_956759/preproc/ctags_target_for_gcc_minus_e.cpp -DARDUINO_LIB_DISCOVERY_PHASE
	@arduino-ctags -u --language-force=c++ -f - --c++-kinds=svpf --fields=KSTtzns --line-directives /tmp/arduino_build_956759/preproc/ctags_target_for_gcc_minus_e.cpp
Compiling sketch...
	@avr-g++ -c -g -Os -w -std=gnu++11 -fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics -Wno-error=narrowing -MMD -flto -mmcu=atmega328p -DF_CPU=16000000L -DARDUINO=10813 -DARDUINO_AVR_UNO -DARDUINO_ARCH_AVR -I/home/henninb/.arduino15/packages/arduino/hardware/avr/1.8.3/cores/arduino -I/home/henninb/.arduino15/packages/arduino/hardware/avr/1.8.3/variants/standard /tmp/arduino_build_956759/sketch/blink-arduino.ino.cpp -o /tmp/arduino_build_956759/sketch/blink-arduino.ino.cpp.o

	@avr-gcc -w -Os -g -flto -fuse-linker-plugin -Wl,--gc-sections -mmcu=atmega328p -o /tmp/arduino_build_956759/blink-arduino.ino.elf /tmp/arduino_build_956759/sketch/blink-arduino.ino.cpp.o /tmp/arduino_build_956759/../arduino_cache_796593/core/core_arduino_avr_uno_8cfe8d7686d593b43d7bd336e90a4d3c.a -L/tmp/arduino_build_956759 -lm
	@avr-objcopy -O ihex -j .eeprom --set-section-flags=.eeprom=alloc,load --no-change-warnings --change-section-lma .eeprom=0 /tmp/arduino_build_956759/blink-arduino.ino.elf /tmp/arduino_build_956759/blink-arduino.ino.eep
	@avr-objcopy -O ihex -R .eeprom /tmp/arduino_build_956759/blink-arduino.ino.elf /tmp/arduino_build_956759/blink-arduino.ino.hex
	@avr-size -A /tmp/arduino_build_956759/blink-arduino.ino.elf

	@avrdude -v -patmega328p -c arduino -P /dev/ttyUSB0 -b115200 -D -Uflash:w:blink-arduino.hex:i
