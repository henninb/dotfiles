#!/bin/sh

mkdir -p "$HOME/mp3"

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  echo mint
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  sudo pacman --noconfirm --needed -S alsa-utils
  sudo pacman --noconfirm --needed -S pulseaudio
elif [ "$OS" = "Void" ]; then
  sudo xbps-install -y pavucontrol
  # sudo xbps-install -y ConsoleKit2
  sudo xbps-install -y pulseaudio
  sudo xbps-install -y alsa-utils
  sudo xbps-install -y mpg123
  sudo xbps-install -y sox
  echo comment out
  echo .ifexists module-console-kit.so
  echo load-module module-console-kit
  echo .endif
  echo pulseaudio --daemonize=no --exit-idle-time=-1
  sudo usermod -a -G audio "$(id -un)"
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  echo "opensuse"
elif [ "$OS" = "Fedora Linux" ]; then
  sudo dnf install -y pavucontrol
elif [ "$OS" = "Solus" ]; then
  echo solus
elif [ "$OS" = "Gentoo" ]; then
  if ! command -v pavucontrol; then
    sudo emerge --update --newuse pavucontrol
  fi
else
  echo "$OS is not yet implemented."
  exit 1
fi

lspci | grep -i audio
cat /proc/asound/cards

# sudo ln -sfn /etc/sv/alsa /var/service/alsa
# sudo ln -sfn /etc/sv/dbus /var/service/dbus
# sudo ln -sfn /etc/sv/cgmanager /var/service/cgmanager
# sudo ln -sfn /etc/sv/consolekit /var/service/consolekit

sudo usermod -a -G pulse-access "$(id -un)"
sudo usermod -a -G audio "$(id -un)"

# manually start
if ! pgrep pulseaudio; then
  echo pulseaudio --start
fi

echo pactl list short sinks
pactl list short sinks
#echo pactl set-default-sink 'alsa_output.usb-Plantronics_Plantronics_BT600_2b33411b5e47614eae3d175f542553a4-00.analog-stereo'
#echo pactl set-default-sink 'alsa_output.usb-Blue_Microphones_Yeti_Stereo_Microphone_TS_2018_02_02_61506-00.analog-stereo'

if command -v pacmd; then
  pacmd list-sink-inputs | awk '/index/ {print $2}'
  echo pacmd list-sink-inputs
  pacmd list-sink-inputs
fi

echo if message pulseaudio sink always suspended
echo sudo vim /etc/pulse/default.pa
echo need to disable module-suspend-on-idle
echo #load-module module-suspend-on-idle

echo pavucontrol, amixer, alsamixer
if [ ! -f "$HOME/mp3/Yes_-_Roundabout.mp3" ]; then
  scp pi@raspi:/home/pi/downloads/mp3/Yes_-_Roundabout.mp3 "$HOME/mp3/"
fi
echo mpg123 "$HOME/mp3/Yes_-_Roundabout.mp3"
echo pacmd set-default-sink 1

echo pavucontrol --tab 5

# echo pulseaudio -k && sudo alsa force-reload && sleep 2 && pulseaudio -k && sudo alsa force-reload
echo systemctl --user status pulseaudio.socket
echo systemctl --user enable pulseaudio

echo pipewire
echo wpctl set-default 55
echo pwtop

echo pactl set-default-sink 'alsa_output.usb-Plantronics_Plantronics_BT600_2b33411b5e47614eae3d175f542553a4-00.analog-stereo'
pactl info

exit 0

# pactl set-default-sink bluez_sink.$DEV
# pactl set-card-profile bluez_card.$DEV a2dp
# pactl set-sink-volume  bluez_sink.$DEV 130%

# vim: set ft=sh
