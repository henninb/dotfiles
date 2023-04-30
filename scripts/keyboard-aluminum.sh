#!/bin/sh

# Bus 003 Device 009: ID 05ac:024f Apple, Inc. Aluminium Keyboard (ANSI)
# Bus 003 Device 006: ID 05ac:1006 Apple, Inc. Hub in Aluminum Keyboard

cat > 99-aluminum-kbd.rules <<EOF
ACTION=="add", ATTRS{idVendor}=="05ac", ATTRS{idProduct}=="0267", ENV{DISPLAY}=":0", ENV{XAUTHORITY}="/home/henninb/.Xauthority" RUN+="/bin/sh /usr/local/bin/aluminum"
EOF
#SUBSYSTEM=="usb"
# sudo udevadm trigger --action=add --subsystem-match=usb

cat > aluminum << 'EOF'
export DISPLAY=:0
export XAUTHORITY=/home/henninb/.Xauthority
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus

sleep 1
# xhost +
xmodmap -e "keycode 169 = Insert"
xmodmap -e "keycode 66 = Escape"
EOF

sudo mkdir -p /etc/udev/rules.d/

chmod 755 aluminum
sudo mv -v 99-aluminum-kbd.rules /etc/udev/rules.d/
sudo mv -v aluminum /usr/local/bin/

doas udevadm control --reload-rules
# sudo udevadm control -R
doas udevadm control --reload

# xinput | grep -i 'Mechanical Keyboard'
echo udevadm monitor --udev
echo "lsusb | grep -i 'aluminum Keyboard'"

exit 0

# vim: set ft=sh:
