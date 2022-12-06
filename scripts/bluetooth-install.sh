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
  sudo apt install -y bluez-tools pulseaudio-module-bluetooth expect
  sudo apt install -y blueberry
  sudo apt install -y blueman
elif [ "$OS" = "Fedora Linux" ]; then
  sudo dnf install -y bluez-tools
  sudo dnf install -y pulseaudio-module-bluetooth
  sudo dnf install -y expect
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  sudo pacman --noconfirm --needed -S bluez-tools expect bluez-utils pulseaudio-bluetooth blueman pulseaudio-alsa bluez-hid2hci bluedevil
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
  sudo usermod -a -G lp "$(id -un)"
else
  echo "$OS is not yet implemented."
  exit 1
fi

echo sudo hciconfig hci0 up
echo hciconfig -a hci0
yay --noconfirm --needed -S bluez-utils-compat
sudo btmgmt ssp off
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

sudo systemctl enable bluetooth
sudo systemctl start bluetooth
sudo systemctl status bluetooth

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
sudo rfkill list
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
sudo btmon
#sudo bluetoothctl -- power on
sudo bluetoothctl -- scan on
sudo bluetoothctl -- trust BC:F2:92:28:6D:45
sudo bluetoothctl -- pairable on
sudo bluetoothctl -- pair BC:F2:92:28:6D:45
sudo bluetoothctl -- trust BC:F2:92:28:6D:45
sudo bluetoothctl -- connect BC:F2:92:28:6D:45
echo sudo l2ping BC:F2:92:28:6D:45

#echo echo -e "<command1>\n<command2>\n" | bluetoothctl or bluetoothctl -- command
exit 0
sudo yum install -y bluez-hid2hci bluez-tools pulseaudio-module-bluetooth mgp123
sudo hciconfig hci0 up

sudo systemctl start bluetooth
sudo systemctl status bluetooth

wget https://media.grc.com/sn/sn-663.mp3
amixer -D pulse sset Master 5%+

hciconfig scan
sudo bt-device -l

hcitool scan

sudo l2ping F0:F0:F0:06:32:84

sudo bluetoothctl
pair F0:F0:F0:06:32:84

6F:8A:CC:29:DE:14

sudo bluetoothctl list
#need to start to connect
pulseaudio -k
pulseaudio --start
sudo pulseaudio --system

sudo pactl unload-module module-bluetooth-discover
sudo pactl load-module module-bluetooth-discover

# reset keyboard
sudo hciconfig hci0 reset
sudo hidd --search

sudo rm /var/lib/bluetooth/*
# then restart bluetooth


exit 0

# vim: set ft=sh:
