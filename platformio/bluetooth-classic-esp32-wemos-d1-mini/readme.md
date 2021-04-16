sudo rfcomm bind 0 30:AE:A4:1C:BA:DE

pin: 1234

minicom -D /dev/rfcomm0 -b 9600 -8
^a + q to quit minicom

sudo vi /etc/bluetooth/rfcomm.conf
uncomment and change it to :

    rfcomm0 {
        # Automatically bind the device at startup
        bind no;

        # Bluetooth address of the device
        device 30:AE:A4:1C:BA:DE;

        # RFCOMM channel for the connection
        channel    1;

        # Description of the connection
        comment "ynot-01";
    }

Finally, bind the device with :

$ sudo rfcomm bind rfcomm0
Then use minicom to communicate with the modue in serial !

$ sudo minicom -D /dev/rfcomm0 -b 9600 -8
and don’t forget to release the device when you finished

$ sudo rfcomm release rfcomm0

platformio device monitor -p /dev/rfcomm0
