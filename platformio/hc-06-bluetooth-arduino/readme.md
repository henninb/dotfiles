sudo rfcomm bind 0 98:D3:37:90:BD:DF

pin: 1234

minicom -D /dev/rfcomm0 -b 9600 -8
^a + q to quit minicom

hc-06 blinks red when not connected
hc-06 solid red when connected
