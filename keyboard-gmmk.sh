#!/bin/sh

cat > 99-gmmk-kbd.rules <<EOF
ACTION=="add", ATTRS{idVendor}=="0c45", ATTRS{idProduct}=="652f", ENV{XKBLAYOUT}="us", ENV{XKBOPTIONS}="altwin:swap_alt_win"
ACTION=="add", ATTRS{idVendor}=="0C45", ATTRS{idProduct}=="652F", ENV{XKBLAYOUT}="us", ENV{XKBOPTIONS}="altwin:swap_alt_win"
EOF

cat > 98-gmmk-kbd.rules <<EOF
ACTION=="add", ATTRS{idVendor}=="0c45", ATTRS{idProduct}=="652f", ENV{DISPLAY}=":0", ENV{XAUTHORITY}="/home/henninb/.Xauthority", RUN+="/bin/sh /usr/local/bin/gmmk"
ACTION=="add", ATTRS{idVendor}=="0C45", ATTRS{idProduct}=="652F", ENV{DISPLAY}=":0", ENV{XAUTHORITY}="/home/henninb/.Xauthority", RUN+="/bin/sh /usr/local/bin/gmmk"
EOF

# , ENV{DISPLAY}=":0" \
# , ENV{XAUTHORITY}="/run/user/1000/gdm/Xauthority" \
# , RUN+="/usr/bin/xinput --disable 16"
# ENV{XAUTHORITY}="/var/run/gdm/auth-for-vazquez-OlbTje/database"
# ENV{XAUTHORITY}="/home/henninb/.Xauthority"
# b85mds3h /etc/udev/rules.d  💡 ls -l /var/run/sddm/\{c168d8f6-fd8a-4b72-9c7f-6fb3aff4b5a7\}

cat > gmmk << 'EOF'
export DISPLAY=:0

kbd_ids=$(xinput -list | grep "SONiX USB DEVICE" | grep -v pointer | awk -F'=' '{print $2}' | cut -c 1-2)
for kbd_id in $kbd_ids; do
  setxkbmap -device "${kbd_id}" -option altwin:swap_alt_win
done

# vim: set ft=sh:
EOF

sudo mkdir -p /etc/udev/rules.d/

chmod 755 gmmk
# xinput | grep -i 'Mechanical Keyboard'
sudo mv -v 99-gmmk-kbd.rules  /etc/udev/rules.d/
sudo mv -v 98-gmmk-kbd.rules  /etc/udev/rules.d/
sudo mv -v gmmk /usr/local/bin/

sudo udevadm control --reload-rules

export XAUTHORITY=/home/henninb/.Xauthority
export DISPLAY=:0

gmmk

echo udevadm monitor --udev
echo "lsusb | grep 'Microdia Backlit Gaming Keyboard'"

exit 0
