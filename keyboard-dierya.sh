#!/bin/sh

cat > 99-usb-kbd.rules <<EOF
ACTION=="add", ATTRS{idVendor}=="258a", ATTRS{idProduct}=="0090", ENV{XKBLAYOUT}="us", ENV{XKBOPTIONS}="altwin:swap_alt_win"
EOF

cat > 98-usb-kbd.rules <<EOF
ACTION=="add", ATTRS{idVendor}=="258a", ATTRS{idProduct}=="0090", RUN+="/home/henninb/keyboard-dierya.sh"
EOF

sudo mkdir -p /etc/udev/rules.d/

sudo xbps-install setxkbmap
sudo xbps-install xinput

# xinput | grep -i 'Mechanical Keyboard'
sudo cp 99-usb-kbd.rules  /etc/udev/rules.d/
sudo cp 98-usb-kbd.rules  /etc/udev/rules.d/

sudo udevadm control --reload-rules
# [ "$remote_id" ] || exit
# echo setxkbmap -device 9 -option altwin:swap_alt_win
# echo setxkbmap -device 15 -option altwin:swap_alt_win
# echo setxkbmap -device 16 -option altwin:swap_alt_win


export XAUTHORITY=/home/henninb/.Xauthority
export DISPLAY=:0
export HOME=/home/henninb

echo "$(date) keyboard-setup-called" >> /tmp/keyboard.txt
ids=$(xinput -list | grep "SINO WEALTH Mechanical Keyboard" | grep -v pointer | awk -F'=' '{print $2}' | cut -c 1-2)
echo "ids '$ids'" >> /tmp/keyboard.txt
for ID in $ids; do
  setxkbmap -device "${ID}" -option altwin:swap_alt_win
  echo $ID >> /tmp/keyboard.txt
done

echo udevadm monitor --udev
echo "lsusb | grep 'Mechanical Keyboard'"

exit 0


echo setxkbmap -device 11 -layout "pc+us+inet(evdev)+custom"

#setxkbmap -device $remote_id -option altwin:swap_alt_win

xinput | cut -d '=' -f 2 | cut -f 1

xinput --list --name-only

cat /proc/bus/input/devices | grep -i keyboard

xinput list --id-only "DELL DELL USB Keyboard"

xinput --list --long | grep XIKeyClass | head -n 1 | egrep -o '[0-9]+'

xinput --list | grep -i keyboard | grep -iv "Virtual core" | grep -iv Button

xinput --list | grep -i keyboard | grep -iv "Virtual core" | grep -iv Button

xinput --list | grep -i keyboard | egrep -iv 'virtual|video|button|bus'

xinput list --id-only 'Logitech G700 Laser Mouse'
