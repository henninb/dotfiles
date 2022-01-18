#!/bin/sh

# cat > 99-usb-kbd.rules <<EOF
# ACTION=="add", ATTRS{idVendor}=="258a", ATTRS{idProduct}=="0090", ENV{XKBLAYOUT}="us", ENV{XKBOPTIONS}="altwin:swap_alt_win"
# EOF

cat > 98-magic-kbd.rules <<EOF
ACTION=="add", ATTRS{idVendor}=="05ac", ATTRS{idProduct}=="0267", RUN+="/usr/local/bin/dierya"
EOF

cat > magic << 'EOF'
export DISPLAY=:0
xmodmap -e "keycode 169 = Insert"
xmodmap -e "keycode 66 = Escape"
EOF

sudo mkdir -p /etc/udev/rules.d/

sudo xbps-install setxkbmap
sudo xbps-install xinput
sudo xbps-install xmodmap

chmod 755 magic
# xinput | grep -i 'Mechanical Keyboard'
sudo mv -v 98-magic-kbd.rules  /etc/udev/rules.d/
sudo mv -v magic /usr/local/bin/

sudo udevadm control --reload-rules

echo udevadm monitor --udev
echo "lsusb | grep 'Magic Keyboard'"

exit 0
