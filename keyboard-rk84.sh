#!/bin/sh

#Bus 003 Device 002: ID 25a7:fa70 Areson Technology Corp 2.4G Wireless Receiver

cat > 99-rk84-kbd.rules <<EOF
ACTION=="add", ATTRS{idVendor}=="25a7", ATTRS{idProduct}=="fa70", ENV{XKBLAYOUT}="us", ENV{XKBOPTIONS}="altwin:swap_alt_win"
EOF

cat > 98-rk84-kbd.rules <<EOF
ACTION=="add", ATTRS{idVendor}=="258a", ATTRS{idProduct}=="0090", RUN+="/usr/local/bin/rk84"
EOF

cat > rk84 << 'EOF'
export DISPLAY=:0
kbd_ids=$(xinput -list | grep "Compx 2.4G Wireless Receiver" | awk -F'=' '{print $2}' | cut -c 1-2)
for kbd_id in $kbd_ids; do
  setxkbmap -device "${kbd_id}" -option altwin:swap_alt_win
done
EOF

sudo mkdir -p /etc/udev/rules.d/

chmod 755 rk84
# xinput | grep -i 'Mechanical Keyboard'
sudo mv -v 99-rk84-kbd.rules  /etc/udev/rules.d/
sudo mv -v 98-rk84-kbd.rules  /etc/udev/rules.d/
sudo mv -v rk84 /usr/local/bin/

sudo udevadm control --reload-rules

export XAUTHORITY=/home/henninb/.Xauthority
export DISPLAY=:0

# echo "$(date) keyboard-setup-called" >> /tmp/keyboard.txt
# kbd_ids=$(xinput -list | grep "SINO WEALTH Mechanical Keyboard" | grep -v pointer | awk -F'=' '{print $2}' | cut -c 1-2)
# for kbd_id in $kbd_ids; do
#   setxkbmap -device "${kbd_id}" -option altwin:swap_alt_win
# done

echo udevadm monitor --udev
echo "lsusb | grep '2.4G Wireless Receiver'"

exit 0
