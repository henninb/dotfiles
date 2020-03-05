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


# if [ -r /etc/default/locale ]; then
# . /etc/default/locale
# export LANG LANGUAGE
# fi

xrdb -merge ~/.Xresources
#xrdb -load ~/.Xresources

#TODO: is this required?
for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
    [ -x "$f" ] && . "$f"
done
unset f

#echo sudo mkfontdir /usr/share/fonts/TTF
#xset +fp ~/.fonts
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
  exec mpd &
fi

if [ -x "$(command -v picom)" ]; then
  exec picom &
elif [ -x "$(command -v compton)" ]; then
  exec compton &
else
  echo picom and compton are not installed. >> "$HOME/xinit.log"
fi

if [ -x "$(command -v wmname)" ]; then
  wmname LG3D
fi


cd "$HOME/.xmonad"
make "$(cat "$HOME/.xmonad/.active")" > /dev/null 2>&1
cd -

#exec mate-session
#exec i3
#exec awesome
#exec qtile
#exec xmonad
#exec bspwm

if [ -s "$HOME/.active-wm" ]; then
  WM=$(head -1 < "$HOME/.active-wm")
else
  echo i3 > "$HOME/.active-wm"
  WM=i3
fi

if [ -x "$(command -v ${WM})" ] && [ "${WM}" = "bspwm" ]; then
  # exec sxhkd &
  #exec bspwm  "$HOME/.config/bspwm/bspwmrc" 2>> "$HOME/xinit.log"
  exec bspwm 2>> "$HOME/xinit.log"
elif [ -x "$(command -v ${WM})" ]; then
  exec ${WM} 2>> "$HOME/xinit.log"
else
  echo "failed to find ${WM}" >> "$HOME/xinit.log"
  exit 1
fi
