remote_id=$(
    xinput list |
    sed -n 's/.*SINO WEALTH Mechanical Keyboard.*id=\([0-9]*\).*keyboard.*/\1/p'
)
[ "$remote_id" ] || exit

# remap the following keys, only for my custom vintage atari joystick connected
# through an old USB keyboard:
#
# keypad 5 -> keypad 6
# . -> keypad 2
# [ -> keypad 8
# left shift -> left control

# mkdir -p /tmp/xkb/symbols
# This is a name for the file, it could be anything you
# want. For us, we'll name it "custom". This is important
# later.
#
# The KP_* come from /usr/include/X11/keysymdef.h
# Also note the name, "remote" is there in the stanza
# definition.

# cat >/tmp/xkb/symbols/custom <<\EOF
# xkb_symbols "remote" {
#     key <LWIN> {        [       Alt_L               ]       };
#     key <RWIN> {        [       Alt_R               ]       };
#     key <LALT> {       [       Super_L         ]       };
#     key <RALT> {       [       Super_R         ]       };
#     modifier_map Mod1 { <LWIN>, <RWIN> };
#     modifier_map Mod4 { <LALT>, <RALT> };
# };
# EOF

# (1) We list our current definition
# (2) Modify it to have a keyboard mapping using the name
#     we used above, in this case it's the "remote" definition
#     described in the file named "custom" which we specify in
#     this world as "custom(remote)".
# (3) Now we take that as input back into our definition of the
#     keyboard. This includes the file we just made, read in last,
#     so as to override any prior definitions.  Importantly we
#     need to include the directory of the place we placed the file
#     to be considered when reading things in.
#
# Also notice that we aren't including exactly the
# directory we specified above. In this case, it will be looking
# for a directory structure similar to /usr/share/X11/xkb
#
# What we provided was a "symbols" file. That's why above we put
# the file into a "symbols" directory, which is not being included
# below.
# setxkbmap -device $remote_id -print \
#  | sed 's/\(xkb_symbols.*\)"/\1+custom(remote)"/' \
#  | xkbcomp -I/tmp/xkb -i $remote_id -synch - $DISPLAY #2>/dev/null

echo setxkbmap -device 11 -layout "pc+us+inet(evdev)+custom"

echo $remote_id
#setxkbmap -device $remote_id -option altwin:swap_alt_win
setxkbmap -device 9 -option altwin:swap_alt_win

exit 0

xinput | cut -d '=' -f 2 | cut -f 1

xinput --list --name-only

cat /proc/bus/input/devices | grep -i keyboard

xinput list --id-only "DELL DELL USB Keyboard"

xinput --list --long | grep XIKeyClass | head -n 1 | egrep -o '[0-9]+'

xinput --list | grep -i keyboard | grep -iv "Virtual core" | grep -iv Button

xinput --list | grep -i keyboard | grep -iv "Virtual core" | grep -iv Button

xinput --list | grep -i keyboard | egrep -iv 'virtual|video|button|bus'

xinput list --id-only 'Logitech G700 Laser Mouse'


sudo vim /etc/modprobe.d/hid_apple.conf
# For Keychron keyboard -- https://wiki.archlinux.org/index.php/Apple_Keyboard
options hid_apple fnmode=2 swap_opt_cmd=1


echo 0 > /sys/module/hid_apple/parameters/fnmode
echo 0 | sudo tee /sys/module/hid_apple/parameters/fnmode
