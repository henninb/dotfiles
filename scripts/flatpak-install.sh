#!/bin/sh

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  sudo pacman --noconfirm --needed -S flatpak
  flatpak install flathub com.valvesoftware.Steam
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  rm -rf com.valvesoftware.Steam.flatpakref com.visualstudio.code.flatpakref
  wget https://flathub.org/repo/appstream/com.valvesoftware.Steam.flatpakref
  wget https://flathub.org/repo/appstream/com.visualstudio.code.flatpakref
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  flatpak install --user com.valvesoftware.Steam.flatpakref
  flatpak install --user com.visualstudio.code.flatpakref
  sudo apt install -y flatpak
elif [ "$OS" = "Void" ]; then
  sudo xbps-install -y flatpak
elif [ "$OS" = "CentOS Linux" ]; then
  sudo yum install -y flatpak
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge --update --newuse app-eselect/eselect-repository
  sudo emerge --update --newuse json-glib
  sudo emerge --update --newuse flatpak
  sudo usermod -a -G flatpak "$(id -un)"
  flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
else
  echo "$OS is not yet implemented."
  exit 1
fi

echo flatpak update
echo flatpak list --app
echo flatpak uninstall io.dbeaver.DBeaverCommunity

exit 0

# vim: set ft=sh:
