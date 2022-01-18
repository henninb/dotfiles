## keyboard remapping

# example
```
If you only want to swap left alt and super key execute the command in your terminal:

setxkbmap -option altwin:swap_alt_win

To restore the default behavior just use:

setxkbmap -option
```


# fkeys for the mac
```
echo 0 | sudo tee /sys/module/hid_apple/parameters/fnmode
```

# remap keys by device
```
export DISPLAY=:0
kbd_ids=$(xinput -list | grep "SINO WEALTH Mechanical Keyboard" | grep -v pointer | awk -F'=' '{print $2}' | cut -c 1-2)
for kbd_id in $kbd_ids; do
  setxkbmap -device "${kbd_id}" -option altwin:swap_alt_win
done
```

# remap details
```
Each keysym column in the table corresponds to a particular combination of modifier keys:

1. Key
2. Shift+Key
3. mode_switch+Key
4. mode_switch+Shift+Key
5. AltGr+Key
6. AltGr+Shift+Key

xmodmap -e "keycode 75 = Insert Insert Insert Insert Insert Insert"
```

# eject key maps to insert
```
xmodmap -e "keycode 169 = Insert"
```


# capslock key maps to escape
```
xmodmap -e "keycode 66 = Escape"
```
