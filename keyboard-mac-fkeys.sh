#!/bin/sh

echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode

if [ ! -f "/etc/modprobe.d/hid_apple.conf" ]; then
  sudo touch /etc/modprobe.d/hid_apple.conf
fi

if ! grep -q "hid_apple" < /etc/modprobe.d/hid_apple.conf; then
  echo "options hid_apple fnmode=2" | sudo tee -a /etc/modprobe.d/hid_apple.conf
  sudo update-initramfs -u -k all
fi

if [ ! -f "/etc/default/keyboard" ]; then
  echo 'XKBOPTIONS=""' | sudo tee -a /etc/default/keyboard
fi

sudo sed -i 's/XKBOPTIONS=""/XKBOPTIONS="caps:escape"/' /etc/default/keyboard

echo keyboard
cat /etc/default/keyboard

echo hid_apple.conf
cat /etc/modprobe.d/hid_apple.conf


cat > 00-keyboard.conf <<EOF
Section "InputClass"
    Identifier "system-keyboard"
    MatchIsKeyboard "on"
    Option "XkbOptions" "caps:escape"
    Option "XkbVariant" "mac"
EndSection
EOF

echo sysctl dev.akbd.0.fn_keys_function_as_primary=1
echo sudo cp us.apple.kbd /usr/share/syscons/keymaps
echo setxkbmap -option "altwin:swap_alt_win"
echo setxkbmap -option

if [ ! -f "/etc/X11/xorg.conf.d/00-keyboard.conf" ]; then
  sudo mv -v 00-keyboard.conf /etc/X11/xorg.conf.d/
fi

exit 0
