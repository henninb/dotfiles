#!/bin/sh

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

for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
    [ -x "$f" ] && . "$f"
done
unset f

echo sudo mkfontdir /usr/share/fonts/TTF
#xset +fp ~/.fonts
#exec feh --bg-scale --randomize $HOME/backgrounds/* &
exec feh --bg-scale $HOME/backgrounds/minnesota-vikings-dark.jpg &
exec xscreensaver -no-splash &

# cp ~/.xmonad/xmonad-master.hs ~/.xmonad/xmonad.hs
ln -sfn $HOME/.xmonad/xmonad-master.hs $HOME/.xmonad/xmonad.hs

if [ "$OS" = "Arch Linux" ]; then
  #[ -n "$XRDP_SESSION" ] && cp ~/.xmonad/xmonad-archlinux-xrdp.hs ~/.xmonad/xmonad.hs
  [ -n "$XRDP_SESSION" ] && ln -sfn $HOME/.xmonad/xmonad-archlinux-xrdp.hs $HOME/.xmonad/xmonad.hs
fi

xmonad --recompile > /dev/null 2>&1

#exec mate-session
#exec i3
#exec awesome
exec xmonad
#exec qtile
