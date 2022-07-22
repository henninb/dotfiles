#!/bin/sh

while true; do
  if ssh matthew uptime >/dev/null 2>&1; then
    notify-send "Machine" "The machine is online!"
    echo "the machine is online"
  fi
  sleep 15
done

exit 0

# vim: set ft=sh:
