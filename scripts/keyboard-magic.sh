#!/bin/sh

cat > 99-magic-kbd.rules <<EOF
ACTION=="add", ATTRS{idVendor}=="05ac", ATTRS{idProduct}=="0267", ENV{DISPLAY}=":0", ENV{XAUTHORITY}="/home/henninb/.Xauthority" RUN+="/bin/sh /usr/local/bin/magic"
EOF
#SUBSYSTEM=="usb"
# sudo udevadm trigger --action=add --subsystem-match=usb

cat > magic << 'EOF'
export DISPLAY=:0
export XAUTHORITY=/home/henninb/.Xauthority
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus

sleep 1
# xhost +
xmodmap -e "keycode 169 = Insert" 2>> /tmp/magic.txt
xmodmap -e "keycode 66 = Escape" 2>> /tmp/magic.txt
# vim: set ft=sh:
EOF

sudo mkdir -p /etc/udev/rules.d/

chmod 755 magic
sudo mv -v 99-magic-kbd.rules /etc/udev/rules.d/
sudo mv -v magic /usr/local/bin/

doas udevadm control --reload-rules
# sudo udevadm control -R
doas udevadm control --reload

# xinput | grep -i 'Mechanical Keyboard'
echo udevadm monitor --udev
echo "lsusb | grep 'Magic Keyboard'"

exit 0

# vim: set ft=sh:
