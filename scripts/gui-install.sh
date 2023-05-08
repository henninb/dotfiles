#!/usr/bin/env sh

# DEBIAN_FRONTEND=noninteractive

ARCHLINUX_PKGS="meld blender pcmanfm dbeaver vscode discord wireshark-qt i3lock thunar meld xorg-server xlockmore vlc riot-desktop dbeaver handbrake feh dolphin-emu gqrx gitk audacity zathura sxiv mpv gimp inkscape brave fslint grub-customizer hardinfo ksystemlog keepassxc gufw libdvdcss kdenlive obs-studio celluloid libva-vdpau-driver libvdpau-va-gl vdpauinfo mesa-vdpau libva-utils openshot cantata notepadqq qalculate-gtk gparted steam gnome-disk-utility lutris xca thunar"

SUSE_PKGS="libreoffice qalculate blender wireshark audacity zathura inkscape hardinfo keepassxc gparted steam lutris xca kdeconnect-kde sxiv thunar"

MINT_PKGS="libreoffice qalculate thunar meld vlc riot-desktop handbrake dolphin-emu xterm rofi feh qt5ct gnome-boxes cockpit seahorse mplayer audacious gitk audacity gqrx-sdr gimp inkscape gnome-mpv openshot vulkan-utils basilisk hardinfo gparted sxiv blender gqrx-sdr thunar"

CENTOS_PKGS="lbbreoffice vlc firefox riot-desktop handbrake dolphin-emu gvim terminator feh dolphin suckless-tools qt5ct gnome-boxes cockpit seahorse mplayer audacious rxvt gimp inkscape"

UBUNTU_PKGS="libreoffice sxiv i3lock meld vlc handbrake feh gnome-boxes cockpit seahorse mplayer audacious gitk audacity gimp inkscape cpu-x kdenlive obs-studio mpv gnome-mpv lutris notepadqq xca gnome-disk-utility steam qalculate-gtk thunar hardinfo gparted blender zathura gqrx-sdr thunar"

FREEBSD_PKGS="sxiv i3lock qalculate keepassxc thunar meld vlc firefox handbrake dolphin-emu xterm audacity gimp inkscape mpv blender vscode libreoffice thunar"

GENTOO_PKGS="meld vlc blender handbrake thunar pcmanfm games-emulation/dolphin xterm audacity gimp inkscape kdenlive mpv media-video/obs-studio app-admin/keepassxc zathura net-im/zoom librewolf-bin wireshark libreoffice-bin slack vscodium sxiv qalculate-gtk hardinfo net-im/discord-bin media-video/celluloid kdeconnect gqrx steam gparted mysql mythtv gnome-disk-utility lutris xca nextcloud-client google-authenticator kcolorchooser thunar"

VOID_PKGS="libreoffice gimp incscape vlc handbrake audacity dolphin-emu zathura dbeaver mpv sxiv thunar"

SOLUS_PKGS="libreoffice meld gimp inkscape vlc handbrake audacity dolphin-emu zathura dbeaver gnome-mpv mpv openshot sxiv"

FEDORA_PKGS="lbireoffice meld blender pcmanfm vscode discord wireshark i3lock thunar meld vlc HandBrake-gui dbeaver feh dolphin-emu gqrx gitk audacity zathura sxiv mpv gimp inkscape fslint grub-customizer hardinfo ksystemlog keepassxc gufw libdvdcss kdenlive obs-studio celluloid libva-utils openshot cantata notepadqq qalculate-gtk gparted steam gnome-disk-utility lutris kde-connect xca thunar"

#MACOS_PKGS="alacritty iterm2"

if [ "$OS" = "Arch Linux" ]; then
  FAILURE=""
  for i in $ARCHLINUX_PKGS; do
    if ! sudo pacman --noconfirm --needed -S "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  # yay --noconfirm --needed -S cpu-x
  yay --noconfirm --needed -S stacer
  yay --noconfirm --needed -S nutty
  yay --noconfirm --needed -S peazip-qt-bin
  yay --noconfirm --needed -S hardinfo
  echo failures "$FAILURE"
elif [ "$OS" = "Darwin" ]; then
  brew cask install vlc
  brew cask install alacritty
  brew cask install iterm2
elif [ "$OS" = "Fedora Linux" ]; then
  FAILURE=""
  for i in $FEDORA_PKGS; do
    if ! sudo dnf install -y "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo failures "$FAILURE"
elif [ "$OS" = "Solus" ]; then
  FAILURE=""
  for i in $SOLUS_PKGS; do
    if ! sudo eopkg install -y "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo failures "$FAILURE"
elif [ "$OS" = "Gentoo" ]; then
  FAILURE=""
  # for i in $GENTOO_PKGS; do
  #   echo sudo emerge -uf "$i"
  #   sudo emerge -uf "$i"
  # done
  for i in $GENTOO_PKGS; do
    echo "sudo emerge --update --newuse $i"
    if ! sudo emerge --update --newuse "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo "Failures: $FAILURE"
  blender=$(find /usr/bin -name "blender-*[0-9]")
  if [ -z ${blender+x} ]; then echo "var is unset"; else sudo ln -sfn "${blender}" /usr/bin/blender; fi
  kdeconnect=$(find /usr/bin -name "kdeconnect-app")
  if [ -z ${kdeconnect+x} ]; then echo "var is unset"; else sudo ln -sfn "${kdeconnect}" /usr/bin/kdeconnect; fi
elif [ "$OS" = "Ubuntu" ]; then
  for i in $UBUNTU_PKGS; do
    if ! sudo apt install -y "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo "failures $FAILURE"
elif [ "$OS" = "CentOS Linux" ]; then
  FAILURE=""
  for i in $CENTOS_PKGS; do
    if ! sudo yum install -y "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo "failures $FAILURE"
elif [ "$OS" = "Void" ]; then
  FAILURE=""
  for i in $VOID_PKGS; do
    if ! sudo xbps-install -y "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo "failures $FAILURE"
elif [ "$OS" = "Linux Mint" ]; then
  FAILURE=""
  for i in $UBUNTU_PKGS; do
    if ! sudo apt install -y "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo "failures $FAILURE"
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  FAILURE=""
  for i in $SUSE_PKGS; do
    if ! sudo zypper install -y "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo "failures $FAILURE"
elif [ "$OS" = "FreeBSD" ]; then
  FAILURE=""
  for i in $FREEBSD_PKGS; do
    if ! sudo pkg install -y "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo "failures $FAILURE"
else
  echo "$OS not configured."
  exit 1
fi

echo "obs-studio - open broadcast software"
echo "kdenlive - video software"

#CPU-X
echo https://github.com/X0rg/CPU-X
#Hardinfo
echo https://github.com/lpereira/hardinfo
#Nutty
echo https://babluboy.github.io/nutty/
#Stacer
echo https://github.com/oguzhaninan/Stacer
#Ksystemlog
echo https://kde.org/applications/system/org.kde.ksystemlog
echo sudo snap install keepassxc

echo https://github.com/balena-io/etcher/releases/download/v1.5.83/balenaEtcher-1.5.83-x64.AppImage

echo Gnome MPV is now Celluloid

exit 0

# vim: set ft=sh:
