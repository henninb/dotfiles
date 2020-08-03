#!/usr/bin/env sh

if [ $# -ne 1 ]; then
    echo "Usage: $0 <wm>"
    exit 1
fi
WM=$1

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

echo polybar master called. >> "$HOME/polybar.log"
echo "XRDP_SESSION $XRDP_SESSION" >> "$HOME/polybar.log"

if [ -n "${XRDP_SESSION}" ]; then
  echo xrdp environment >> "$HOME/polybar.log"
else
  echo xrdp environment not found >> "$HOME/polybar.log"
fi
polybar -c "$HOME/.config/polybar/config-master.ini" "${WM}" 2>> "$HOME/polybar.log" &
echo "result code: $?" >> "$HOME/polybar.log"
