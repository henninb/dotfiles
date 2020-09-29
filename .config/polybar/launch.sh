#!/usr/bin/env sh

# if [ $# -ne 1 ]; then
#     echo "Usage: $0 <wm>"
#     exit 1
# fi
# WM=$1

desktop=$DESKTOP_SESSION
#count=$(xrandr --query | grep " connected" | cut -d" " -f1 | wc -l)

killall -q polybar

while pgrep -x polybar >/dev/null; do sleep 1; done

echo $desktop > /tmp/wm

case $desktop in

    spectrwm|/usr/share/xsessions/spectrwm)
      polybar -c "$HOME/.config/polybar/config-master.ini" spectrwm | tee -a "$HOME/polybar.log" &
      ;;
    xmonad|/usr/share/xsessions/xmonad)
      polybar -c "$HOME/.config/polybar/config-master.ini" xmonad | tee -a "$HOME/polybar.log" &
      ;;
    i3|/usr/share/xsessions/i3)
      polybar -c "$HOME/.config/polybar/config-master.ini" i3 | tee -a "$HOME/polybar.log" &
      ;;
    bspwm|/usr/share/xsessions/bspwm)
      polybar -c "$HOME/.config/polybar/config-master.ini" bspwm | tee -a "$HOME/polybar.log" &
      ;;
esac

# echo "polybar master called. $(date)" | tee -a "$HOME/polybar.log"
# echo "XRDP_SESSION $XRDP_SESSION" | tee -a "$HOME/polybar.log"

# if [ -n "${XRDP_SESSION}" ]; then
#   echo xrdp environment | tee -a "$HOME/polybar.log"
# else
#   echo xrdp environment not found | tee -a "$HOME/polybar.log"
# fi
# polybar -c "$HOME/.config/polybar/config-master.ini" "${WM}" | tee -a "$HOME/polybar.log" &
# echo "result code: $?" | tee -a "$HOME/polybar.log"

exit 0
