#!/usr/bin/env sh

# https://askubuntu.com/questions/689281/pulseaudio-can-not-load-bluetooth-module-15-10-16-04-16-10
# https://ubuntuforums.org/showthread.php?t=2308489

cat <<  EOF > "$HOME/tmp/hcid.conf"
options {

    # Security Manager mode
    #   none - Security manager disabled
    #   auto - Use local PIN for incoming connections
    #   user - Always ask user for a PIN
    #
    security none;
}
EOF

sudo mv -v "$HOME/tmp/hcid.conf" /etc/bluetooth

if [ "$OS" = "Linux Mint" ] ||  [ "$OS" = "Ubuntu" ]; then
  doas apt install -y bluez-tools pulseaudio-module-bluetooth expect
  doas apt install -y blueberry
  doas apt install -y blueman
elif [ "$OS" = "Fedora Linux" ]; then
  doas dnf install -y bluez-tools
  doas dnf install -y pulseaudio-module-bluetooth
  doas dnf install -y expect
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  doas pacman --noconfirm --needed -S bluez-tools expect bluez-utils pulseaudio-bluetooth blueman pulseaudio-alsa bluez-hid2hci bluedevil
  cd "$HOME/projects" || exit
  # git clone https://aur.archlinux.org/asoundconf.git
  # git clone https://aur.archlinux.org/bluez-utils-compat.git
  yay --noconfirm --needed -S asoundconf
  yay --noconfirm --needed -S bluez-utils-compat
  echo /etc/pulse/default.pa
  echo /etc/pulse/system.pa
  echo load-module module-bluetooth-policy
  echo load-module module-bluetooth-discover
  echo Change to privacy = off but set Controller = le in /etc/bluetooth/main.conf
  doas usermod -a -G lp "$(id -un)"
else
  echo "$OS is not yet implemented."
  exit 1
fi

echo sudo hciconfig hci0 up
echo hciconfig -a hci0
yay --noconfirm --needed -S bluez-utils-compat
doas btmgmt ssp off
rfkill list
bluedevil # kde

# /etc/bluetooth/main.conf
# AutoConnect=true
# vi /etc/bluetooth/input.conf
# UserspaceHID=true
# vi /etc/bluetooth/hcid.conf
# device 00:1E:52:FB:68:55 {
#     name "Apple Wireless Keyboard";
#     auth enable;
#     encrypt enable;
# }

doas systemctl enable bluetooth
doas systemctl start bluetooth
doas systemctl status bluetooth

# [ ! -f sn-725.mp3 ] && wget https://media.grc.com/sn/sn-725.mp3 -O sn-725.mp3

amixer -D pulse sset Master 5%+
echo alsamixer -c 1
echo hciconfig scan
echo sudo bt-device -l
echo BC:F2:92:28:6D:45	PLT Focus
echo pulseaudio -k # to restart pulseaudio

echo sudo journalctl --unit=bluetooth -f
echo dconf reset -f /
echo sudo rfkill list # to see if audio device is blocked
doas rfkill list
echo sudo rfkill unblock bluetooth
echo sudo systemctl status bluetooth
echo pacmd ls
echo pactl load-module module-bluetooth-discover
echo pactl list short

#/etc/bluetooth/main.conf
#[Policy]
#AutoEnable=true

echo hcitool scan

# monitor bluetooth connection
doas btmon
#sudo bluetoothctl -- power on
doas bluetoothctl -- scan on
doas bluetoothctl -- trust BC:F2:92:28:6D:45
doas bluetoothctl -- pairable on
doas bluetoothctl -- pair BC:F2:92:28:6D:45
doas bluetoothctl -- trust BC:F2:92:28:6D:45
doas bluetoothctl -- connect BC:F2:92:28:6D:45
echo sudo l2ping BC:F2:92:28:6D:45

#echo echo -e "<command1>\n<command2>\n" | bluetoothctl or bluetoothctl -- command
exit 0
doas yum install -y bluez-hid2hci bluez-tools pulseaudio-module-bluetooth mgp123
doas hciconfig hci0 up

doas systemctl start bluetooth
doas systemctl status bluetooth

wget https://media.grc.com/sn/sn-663.mp3
amixer -D pulse sset Master 5%+

hciconfig scan
doas bt-device -l

hcitool scan

doas l2ping F0:F0:F0:06:32:84

doas bluetoothctl
pair F0:F0:F0:06:32:84

6F:8A:CC:29:DE:14

doas bluetoothctl list
#need to start to connect
pulseaudio -k
pulseaudio --start
doas pulseaudio --system

doas pactl unload-module module-bluetooth-discover
doas pactl load-module module-bluetooth-discover

# reset keyboard
doas hciconfig hci0 reset
doas hidd --search

sudo rm /var/lib/bluetooth/*
# then restart bluetooth


exit 0

# vim: set ft=sh:
