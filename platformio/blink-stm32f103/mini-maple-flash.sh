#!/bin/sh

echo set the boot0 jumper on the stm32f103
export LD_LIBRARY_PATH=/usr/local/lib/
st-flash write mini-maple-generic_boot20_pc13-march-2020.bin 0x8000000

exit 0
