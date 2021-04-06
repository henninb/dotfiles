sudo rfcomm bind 0 98:D3:37:90:BD:DF

pin: 1234

minicom -D /dev/rfcomm0 -b 9600 -8
^a + q to quit minicom

hc-06 blinks red when not connected
hc-06 solid red when connected


sudo vi /etc/bluetooth/rfcomm.conf
uncomment and change it to :


    rfcomm0 {
        # Automatically bind the device at startup
        bind no;

        # Bluetooth address of the device
        device 98:03:31:80:51:48;

        # RFCOMM channel for the connection
        channel    1;

        # Description of the connection
        comment "HC-06";
    }
Make sure you change the device to your HC-06 Module Address !.

Finally, bind the device with :

$ sudo rfcomm bind rfcomm0
Then use minicom to communicate with the modue in serial !

$ sudo minicom -D /dev/rfcomm0 -b 9600 -8
and don’t forget to release the device when you finished

$ sudo rfcomm release rfcomm0

