#!/bin/sh

scp pi@192.168.100.25:/home/pi/json_in.zip .

mkdir -p json_in
cd json_in
unzip -o ../json_in.zip
cd -

exit 0
