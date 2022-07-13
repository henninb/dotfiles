#!/bin/sh

cat > flatpak-overlay.conf << 'EOF'
[flatpak-overlay]
priority = 50
location = overlay/flatpak-overlay
sync-type = git
sync-uri = https://github.com/fosero/flatpak-overlay.git
auto-sync = Yes
EOF

# layman -o https://github.com/fosero/flatpak-overlay.git -f -a flatpak-overlay
# layman -o https://github.com/fosero/flatpak-overlay/blob/master/repositories.xml -f -a flatpak-overlay
# layman -o https://raw.githubusercontent.com/fosero/flatpak-overlay/master/repositories.xml -f -a flatpak-overlay


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
  echo "flatpak run com.valvesoftware.Steam"
  echo "flatpak run com.visualstudio.code"
  #flatpak install
  sudo apt install -y flatpak
elif [ "$OS" = "void" ]; then
  sudo xbps-install -y flatpak
elif [ "$OS" = "CentOS Linux" ]; then
  sudo yum install -y flatpak
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge --update --newuse app-eselect/eselect-repository
  #sudo eselect repository enable flatpak-overlay
  #sudo emaint sync -r flatpak-overlay
  #sudo emerge --update --newuse flatpak
  sudo emerge --update --newuse json-glib
  sudo emerge --update --newuse flatpak
  sudo usermod -a -G flatpak henninb
  # wget https://flathub.org/repo/appstream/com.valvesoftware.Steam.flatpakref
  # wget https://flathub.org/repo/appstream/com.visualstudio.code.flatpakref
  # sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  # flatpak install --user com.valvesoftware.Steam.flatpakref
  # flatpak install --user com.visualstudio.code.flatpakref
else
  echo "$OS is not yet implemented."
  exit 1
fi

flatpak update

exit 0

# vim: set ft=sh:
