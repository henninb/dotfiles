If you only want to swap left alt and super key execute the command in your terminal:

setxkbmap -option altwin:swap_alt_win

To restore the default behavior just use:

setxkbmap -option


# fkeys for the mac
echo 0 | sudo tee /sys/module/hid_apple/parameters/fnmode


https://superuser.com/questions/760602/how-to-remap-keys-under-linux-for-a-specific-keyboard-only



# remap keys by device
Yes, it's possible using XKB. Unlike xmodmap, XKB can remap your keys for individual devices.

Note: Make sure you have xkbcomp > 1.2.0

First list your devices with:

xinput list

SINO WEALTH Mechanical Keyboard Consumer Control	id=11	[slave  keyboard (3)]
