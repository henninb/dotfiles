export PATH=${HOME}/.local/bin:${HOME}/.nix-profile/bin:/sbin:/usr/sbin:/usr/local/sbin:${PATH}

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
export LC_ALL="en_US.UTF-8"

# export LC_ALL=C
# export LANG=C

export CM_SELECTION="primary clipboard"
export CM_DEBUG=0
export CM_OUTPUT_CLIP=1
export CM_MAX_CLIPS=25

xmodmap ~/.Xmodmap
# xmodmap -e "keycode 169 = Insert"
# turn the capslock key to be an escape key
# turn right alt key becomes the compose key
# setxkbmap -option "caps:escape,compose:ralt"

# kbd_ids=$(xinput -list | grep "SINO WEALTH Mechanical Keyboard" | grep -v pointer | awk -F'=' '{print $2}' | cut -c 1-2)
# for kbd_id in $kbd_ids; do
#   setxkbmap -device "${kbd_id}" -option altwin:swap_alt_win
# done

# swap the alt and windows keys on my K-63 keyboard
# turn the capslock key to be an escape key
# setxkbmap -device 9 -option "altwin:swap_alt_win,caps:escape"

if [ "${OS}" = "FreeBSD" ]; then
  setxkbmap -option
fi

if [ "$DISPLAY" != ":0" ]; then
    xclipsync &
fi

# xrandr --output HDMI-0 --mode 3840x2160

echo "$(date) start xsesson" >> "$HOME/tmp/xsession.log"

# vim: set ft=conf:
