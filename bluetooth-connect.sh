#!/usr/bin/sh

address=""

touch bluetooth.txt
for address in $(cat bluetooth.txt);do
  sudo bluetoothctl trust "$address"
  sudo bluetoothctl disconnect "$address"
  sudo bluetoothctl connect "$address"
done

exit 0
