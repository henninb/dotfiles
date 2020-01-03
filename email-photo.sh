#!/bin/sh

/usr/bin/raspistill -q 8 -o /home/pi/file.jpg
#/usr/bin/scp /home/pi/file.jpg pi@192.168.100.134:/home/pi/file.jpg
/bin/echo photo_below | /usr/bin/mutt -s "Office photo" -a /home/pi/file.jpg -- henninb@msn.com > /dev/null 2>&1
/bin/mv /home/pi/file.jpg /home/pi/file_bak.jpg
/usr/bin/wget https://raw.githubusercontent.com/BitExplorer/howto/master/raspberry_pi/camera_usage.txt -O camera.txt

exit 0
