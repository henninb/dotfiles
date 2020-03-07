#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u "${UID}" -x polybar >/dev/null; do sleep 1; done

polybar -c "$HOME/.config/polybar/config-master.ini" i3 2>> "$HOME/polybar.log" &
echo $? >> "$HOME/polybar.log"
