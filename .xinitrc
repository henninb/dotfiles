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

if [ -f /etc/os-release ]; then
    . /etc/os-release
    export OS=$NAME
    export OS_VER=$VERSION_ID
elif type lsb_release >/dev/null 2>&1; then
    export OS=$(lsb_release -si)
    export OS_VER=$(lsb_release -sr)
elif [ -f /etc/lsb-release ]; then
    . /etc/lsb-release
    export OS=$DISTRIB_ID
    export OS_VER=$DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
    export OS=Debian
    export OS_VER=$(cat /etc/debian_version)
elif [ -f /etc/SuSe-release ]; then
    ...
elif [ -f /etc/redhat-release ]; then
    ...
else
  export OS=$(uname -s)
  export OS_VER=$(uname -r)
fi

xrdb -merge ~/.Xresources
#xrdb -load ~/.Xresources

#TODO: is this required?
for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
    [ -x "$f" ] && . "$f"
done
unset f

echo sudo mkfontdir /usr/share/fonts/TTF
#xset +fp ~/.fonts
#exec feh --bg-scale --randomize $HOME/backgrounds/* &
exec feh --bg-scale $HOME/backgrounds/minnesota-vikings-dark.jpg &
exec xscreensaver -no-splash &
if [ "$OS" = "Arch Linux" ]; then
  exec picom &
else
  exec compton &
fi

cd $HOME/.xmonad
make $(cat "$HOME/.xmonad/.active") > /dev/null 2>&1
cd -

#echo "ghc $(date)" >> xinit.log

#exec mate-session
#exec i3
#exec awesome
exec xmonad 2>> xinit.log
#exec xmonad
#exec qtile
