#!/bin/sh

address=""

touch bluetooth.txt
for address in $(cat bluetooth.txt);do
  status=$(bluetoothctl info "$address" | grep Connected | grep -v grep)
  echo "status=$status"
  if echo "$status" | grep -q "no"; then
    echo
    bluetoothctl disconnect "$address" >/dev/null 2>&1
    bluetoothctl trust "$address" >/dev/null 2>&1
    bluetoothctl connect "$address"
  fi
done

exit 0
