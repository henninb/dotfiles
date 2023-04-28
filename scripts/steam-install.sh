#!/bin/sh

# cat > flatpak-overlay.conf << 'EOF'
# [flatpak-overlay]
# priority = 50
# location = <repo-location>/flatpak-overlay
# sync-type = git
# sync-uri = https://github.com/fosero/flatpak-overlay.git
# auto-sync = Yes
# EOF
#
# rm -rf com.valvesoftware.Steam.flatpakref*
# wget https://flathub.org/repo/appstream/com.valvesoftware.Steam.flatpakref

cat > "$HOME/tmp/pacman.conf" << 'EOF'
[multilib]
Include = /etc/pacman.d/mirrorlist
EOF

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  # sudo pacman --noconfirm --needed -S lib32-nvidia-utils
  sudo pacman --noconfirm --needed -S ttf-liberation
  echo enable multilib in /etc/pacman.conf
  cat "$HOME/tmp/pacman.conf" | sudo tee -a /etc/pacman.conf
  sudo pacman -Sy
  # sudo pacman --noconfirm --needed -S flatpak
  # flatpak install flathub com.valvesoftware.Steam
  sudo pacman --noconfirm --needed -S steam
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ]; then
  #wget https://steamcdn-a.akamaihd.net/client/installer/steam.deb
  # sudo dpkg --add-architecture i386
  sudo add-apt-repository -y multiverse
  sudo dpkg --add-architecture i386
  sudo apt-get update
  sudo apt install -y steam-installer
  # sudo apt install -y flatpak
  #flatpak install --user flathub org.freedesktop.Platform.openh264
  # flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  # flatpak install --user flathub org.freedesktop.Platform/x86_64/19.08
  # flatpak install --user com.valvesoftware.Steam.flatpakref
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge --update --newuse app-eselect/eselect-repository
  sudo eselect repository enable steam-overlay
  sudo emaint sync -r steam-overlay
  sudo emerge --update --newuse games-util/steam-launcher
  # sudo mv flatpak-overlay.conf /etc/portage/repos.conf/flatpak-overlay.conf
  # sudo emerge --sync
  #sudo emerge --update --newuse flatpak
  # flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  # flatpak install --user com.valvesoftware.Steam.flatpakref
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  sudo zypper addrepo https://download.opensuse.org/repositories/home:X0F:HSF/openSUSE_Tumbleweed/home:X0F:HSF.repo
  sudo zypper refresh
  sudo zypper install -y steam
elif [ "$OS" = "Solus" ]; then
  sudo eopkg install -y steam
elif [ "$OS" = "Void" ]; then
  echo Void
  sudo xbps-install -y void-repo-nonfree
  sudo xbps-install -y void-repo-multilib-nonfree
  sudo xbps-install -Syv void-repo-multilib{,-nonfree}
  # sudo xbps-install -S libgcc-32bit libstdc++-32bit libdrm-32bit libglvnd-32bit
  sudo xbps-install -y libgcc-32bit libstdc++-32bit libdrm-32bit libglvnd-32bit nvidia nvidia-libs-32bit
  sudo xbps-install -y mesa-dri-32bit
  sudo xbps-install -y steam

elif [ "$OS" = "Fedora Linux" ]; then
  #flatpak install --user com.valvesoftware.Steam.flatpakref
  echo Fedora
elif [ "$OS" = "Darwin" ]; then
  echo "Darwin"
elif [ "$OS" = "Clear Linux OS" ]; then
  echo "Clear Linux OS"
elif [ "$OS" = "OpenBSD" ]; then
  echo "OpenBSD"
elif [ "$OS" = "FreeBSD" ]; then
  echo "FreeBSD"
else
  echo "$OS is not yet implemented"
  exit 1
fi

# flatpak update
# flatpak remotes

exit 0

# vim: set ft=sh:
