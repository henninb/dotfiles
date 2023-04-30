#!/bin/sh

# cat > 99-dierya-kbd.rules <<EOF
# ACTION=="add", ATTRS{idVendor}=="258a", ATTRS{idProduct}=="0090", ENV{XKBLAYOUT}="us", ENV{XKBOPTIONS}="altwin:swap_alt_win"
# EOF

cat > 98-dierya-kbd.rules <<EOF
ACTION=="add", ATTRS{idVendor}=="258a", ATTRS{idProduct}=="0090", ENV{XAUTHORITY}="/home/henninb/.Xauthority", RUN+="/bin/sh /usr/local/bin/dierya"
EOF

cat > dierya << 'EOF'
export DISPLAY=:0
kbd_ids=$(xinput -list | grep "SINO WEALTH Mechanical Keyboard" | grep -v pointer | awk -F'=' '{print $2}' | cut -c 1-2)
for kbd_id in $kbd_ids; do
  setxkbmap -device "${kbd_id}" -option altwin:swap_alt_win
done

# vim: set ft=sh:
EOF

sudo mkdir -p /etc/udev/rules.d/

chmod 755 dierya
# xinput | grep -i 'Mechanical Keyboard'
# sudo mv -v 99-dierya-kbd.rules  /etc/udev/rules.d/
sudo mv -v 98-dierya-kbd.rules  /etc/udev/rules.d/
sudo mv -v dierya /usr/local/bin/

doas udevadm control --reload-rules

echo udevadm monitor --udev
echo "lsusb | grep 'Mechanical Keyboard'"

exit 0

# vim: set ft=sh:
