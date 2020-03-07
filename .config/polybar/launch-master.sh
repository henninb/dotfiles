#!/usr/bin/env sh

if [ $# -ne 1 ]; then
    echo "Usage: $0 <wm>"
    exit 1
fi
WM=$1

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u "${UID}" -x polybar >/dev/null; do sleep 1; done

polybar -c "$HOME/.config/polybar/config-master.ini" "${WM}" 2>> "$HOME/polybar.log" &
echo $? >> "$HOME/polybar.log"
