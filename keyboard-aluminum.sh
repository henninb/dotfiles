#!/bin/sh

# Bus 003 Device 009: ID 05ac:024f Apple, Inc. Aluminium Keyboard (ANSI)
# Bus 003 Device 006: ID 05ac:1006 Apple, Inc. Hub in Aluminum Keyboard

cat > 99-aluminum-kbd.rules <<EOF
ACTION=="add", ATTRS{idVendor}=="05ac", ATTRS{idProduct}=="0267", RUN+="/bin/sh /usr/local/bin/aluminum"
EOF
#SUBSYSTEM=="usb"
# sudo udevadm trigger --action=add --subsystem-match=usb

cat > aluminum << 'EOF'
export DISPLAY=:0
export XAUTHORITY=/home/henninb/.Xauthority
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus

sleep 1
# xhost +
xmodmap -e "keycode 169 = Insert" 2>> /tmp/aluminum.txt
xmodmap -e "keycode 66 = Escape" 2>> /tmp/aluminum.txt
EOF

sudo mkdir -p /etc/udev/rules.d/

chmod 755 aluminum
sudo mv -v 99-aluminum-kbd.rules /etc/udev/rules.d/
sudo mv -v aluminum /usr/local/bin/

sudo udevadm control --reload-rules
# sudo udevadm control -R
sudo udevadm control --reload

# xinput | grep -i 'Mechanical Keyboard'
echo udevadm monitor --udev
echo "lsusb | grep 'aluminum Keyboard'"

exit 0
