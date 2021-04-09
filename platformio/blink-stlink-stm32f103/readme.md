https://www.youtube.com/watch?v=rfBeq-Fu0hc


openocd -d2 -s /home/henninb/.platformio/packages/tool-openocd/scripts -f interface/stlink.cfg -c "transport select hla_swd" -f target/stm32f1x.cfg -c "reset_config none" -c "program {.pio/build/bluepill_f103c8/firmware.elf}  verify reset; shutdown;"


st-flash write myflash.bin 0x8000000
