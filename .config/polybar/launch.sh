#!/usr/bin/env sh

if [ $# -ne 1 ]; then
    echo "Usage: $0 <wm>"
    exit 1
fi
WM=$1

killall -q polybar

while pgrep -x polybar >/dev/null; do sleep 1; done

echo "polybar master called. $(date)" | tee -a "$HOME/polybar.log"
echo "XRDP_SESSION $XRDP_SESSION" | tee -a "$HOME/polybar.log"

if [ -n "${XRDP_SESSION}" ]; then
  echo xrdp environment | tee -a "$HOME/polybar.log"
else
  echo xrdp environment not found | tee -a "$HOME/polybar.log"
fi
polybar -c "$HOME/.config/polybar/config-master.ini" "${WM}" | tee -a "$HOME/polybar.log" &
echo "result code: $?" | tee -a "$HOME/polybar.log"
exit 0
