#!/usr/bin/sh

address=""

touch bluetooth.txt
for address in $(cat bluetooth.txt);do
  bluetoothctl trust "$address"
  bluetoothctl disconnect "$address"
  bluetoothctl connect "$address"
done

exit 0
