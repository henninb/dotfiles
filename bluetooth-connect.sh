#!/usr/bin/sh

address=""

sudo bluetoothctl trust "$address"
sudo bluetoothctl disconnect "$address"
sudo bluetoothctl connect "$address"

exit 0
