#!/bin/sh

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  echo
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  sudo pacman --noconfirm --needed -S alsa-utils
  sudo pacman --noconfirm --needed -S pulseaudio
elif [ "$OS" = "void" ]; then
  sudo xbps-install -S ConsoleKit2 pulseaudio alsa-utils
elif [ "$OS" = "Fedora" ]; then
  echo
elif [ "$OS" = "Solus" ]; then
  echo
elif [ "$OS" = "Gentoo" ]; then
  echo
else
  echo "$OS is not yet implemented."
  exit 1
fi

cat /proc/asound/cards

# sudo ln -s /etc/sv/alsa /var/service/
# sudo ln -s /etc/sv/dbus /var/service/
# sudo ln -s /etc/sv/cgmanager /var/service/
# sudo ln -s /etc/sv/consolekit /var/service/

sudo usermod -a -G pulse-access "$(id -un)"
sudo usermod -a -G audio "$(id -un)"

# manually start
if ! pgrep pulseaudio; then
  pulseaudio --start
fi

pactl list short sinks
echo pactl set-default-sink 'alsa_output.usb-Plantronics_Plantronics_BT600_2b33411b5e47614eae3d175f542553a4-00.analog-stereo'


echo pulseaudio sink always suspended
echo sudo vim /etc/pulse/default.pa
echo disable module-suspend-on-idle
echo #load-module module-suspend-on-idle

echo pavucontrol

exit 0
