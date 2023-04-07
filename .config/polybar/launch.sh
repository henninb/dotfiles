#!/usr/bin/env sh

desktop=$DESKTOP_SESSION

killall -q polybar

while pgrep -x polybar >/dev/null; do sleep 1; done

echo "$desktop" > /tmp/wm

case $desktop in

    spectrwm|/usr/share/xsessions/spectrwm)
      polybar -c "$HOME/.config/polybar/config.ini" spectrwm | tee -a "$HOME/polybar.log" &
      ;;
    xmonad|/usr/share/xsessions/xmonad)
      if [ "${OS}" = "FreeBSD" ]; then
        polybar -c "$HOME/.config/polybar/config.ini" xmonad-freebsd | tee -a "$HOME/polybar.log" &
      else
        polybar -c "$HOME/.config/polybar/config.ini" xmonad | tee -a "$HOME/polybar.log" &
      fi
      ;;
    i3|/usr/share/xsessions/i3)
      polybar -c "$HOME/.config/polybar/config.ini" i3 | tee -a "$HOME/polybar.log" &
      ;;
    bspwm|/usr/share/xsessions/bspwm)
      polybar -c "$HOME/.config/polybar/config.ini" bspwm | tee -a "$HOME/polybar.log" &
      ;;
esac

exit 0

# vim: set ft=sh
