#!/bin/sh

echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode

if [ ! -f "/etc/modprobe.d/hid_apple.conf" ]; then
  sudo touch /etc/modprobe.d/hid_apple.conf
fi

if ! grep -q "hid_apple" < /etc/modprobe.d/hid_apple.conf; then
  echo "options hid_apple fnmode=2" | sudo tee -a /etc/modprobe.d/hid_apple.conf
  doas update-initramfs -u -k all
  doas mkinitcpio -p linux
fi

if [ ! -f "/etc/default/keyboard" ]; then
  echo 'XKBOPTIONS=""' | sudo tee -a /etc/default/keyboard
fi

sudo sed -i 's/XKBOPTIONS=""/XKBOPTIONS="caps:escape"/' /etc/default/keyboard

echo keyboard
cat /etc/default/keyboard

echo hid_apple.conf
cat /etc/modprobe.d/hid_apple.conf

cat << EOF > "$HOME/tmp/00-keyboard.conf"
Section "InputClass"
    Identifier "system-keyboard"
    MatchIsKeyboard "on"
    Option "XkbOptions" "caps:escape"
    Option "XkbVariant" "mac"
EndSection
EOF

echo xmodmap -pke

echo sysctl dev.akbd.0.fn_keys_function_as_primary=1
echo sudo cp us.apple.kbd /usr/share/syscons/keymaps
echo setxkbmap -option "altwin:swap_alt_win"
echo setxkbmap -option

if [ ! -f "/etc/X11/xorg.conf.d/00-keyboard.conf" ]; then
  sudo mv -v "$HOME/tmp/00-keyboard.conf" /etc/X11/xorg.conf.d/
fi

echo map f8 to Insert and f8
echo xmodmap -e "keycode 74 = Insert F8"

echo "Function Shift Return is the shift-insert feature on mocos keyboards"

echo map f9 key to the insert key
echo xmodmap -e "keycode 75 = Insert Insert"

exit 0

# vim: set ft=sh:
