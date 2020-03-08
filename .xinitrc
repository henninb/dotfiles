#!/bin/sh

export PATH=${HOME}/.local/bin:${PATH}
export PATH=/usr/local/sbin:/usr/sbin:${PATH}

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_NUMERIC=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export LC_COLLATE=C
export LC_MONETARY=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_PAPER=en_US.UTF-8
export LC_NAME=en_US.UTF-8
export LC_ADDRESS=en_US.UTF-8
export LC_TELEPHONE=en_US.UTF-8
export LC_MEASUREMENT=en_US.UTF-8
export LC_IDENTIFICATION=en_US.UTF-8


if [ -x "$(command -v xrdb)" ]; then
  #xrdb -merge ~/.Xresources
  xrdb -load "$HOME/.Xresources" >> "$HOME/xinit.log"
fi

for f in /etc/X11/Xsession.d/*; do
  echo $f >> "$HOME/xinit.log"
  [ -x "$f" ] && . "$f"
done
unset f

#TODO: is this required?
for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
    [ -x "$f" ] && . "$f"
done
unset f

if [ -x "$(command -v feh)" ]; then
  #exec feh --bg-scale --randomize $HOME/backgrounds/* &
  exec feh --bg-scale "$HOME/backgrounds/minnesota-vikings-dark.jpg" &
else
  echo feh is not installed >> "$HOME/xinit.log"
fi

if [ -x "$(command -v xscreensaver)" ]; then
  exec xscreensaver -no-splash &
else
  echo xscreensaver is not installed >> "$HOME/xinit.log"
fi

if [ -x "$(command -v mpd)" ]; then
  exec mpd  &
fi

if [ -x "$(command -v picom)" ]; then
  exec picom &
elif [ -x "$(command -v compton)" ]; then
  exec compton &
else
  echo Neither picom nor compton are installed. >> "$HOME/xinit.log"
fi

if [ -x "$(command -v wmname)" ]; then
  wmname LG3D >> "$HOME/xinit.log"
fi


# cd "$HOME/.xmonad"
# make "$(cat "$HOME/.xmonad/.active")" > /dev/null 2>&1
# cd -

#exec mate-session
#exec i3
#exec awesome
#exec qtile
#exec xmonad
#exec bspwm

WM=$(head -1 < "$HOME/.active-wm")
if [ -s "$HOME/.active-wm" ] && [ -x "$(command -v "${WM}")" ]; then
  echo "Found window manager = ${WM}." >> "$HOME/xinit.log"
else
  echo i3 > "$HOME/.active-wm"
  WM=i3
  echo "Set to default window manager = ${WM}." >> "$HOME/xinit.log"
fi

if [ "${WM}" = "bspwm" ]; then
  # exec sxhkd &
  #exec bspwm  "$HOME/.config/bspwm/bspwmrc" 2>> "$HOME/xinit.log"
  exec bspwm 2>> "$HOME/xinit.log"
elif [ "${WM}" = "xmonad" ]; then
  export "$(dbus-launch)"
  #dbus-update-activation-environment
  #echo "$DBUS_SESSION_BUS_ADDRESS" >> "$HOME/xinit.log"
  #exec xmonad 2>> "$HOME/xinit.log"
  exec dbus-launch xmonad 2>> "$HOME/xinit.log"
  #exec xmonad 2>> "$HOME/xinit.log"
elif [ -x "$(command -v ${WM})" ]; then
  exec ${WM} 2>> "$HOME/xinit.log"
else
  echo "failed to find window manager ${WM}." >> "$HOME/xinit.log"
  exit 1
fi
