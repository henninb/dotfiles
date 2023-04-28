#!/bin/sh

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  doas apt install -y cmake
  doas apt install -y g++
  doas apt install -y libev-dev
  doas apt install -y libasound2-dev
  doas apt install -y libxcb1-dev
  doas apt install -y libxcb-keysyms1-dev
  doas apt install -y libpango1.0-dev
  doas apt install -y libxcb-util0-dev
  doas apt install -y libxcb-icccm4-dev
  doas apt install -y libyajl-dev
  doas apt install -y libstartup-notification0-dev
  doas apt install -y libxcb-randr0-dev
  doas apt install -y libev-dev
  doas apt install -y libxcb-cursor-dev
  doas apt install -y libxcb-xinerama0-dev
  doas apt install -y libxcb-xkb-dev
  doas apt install -y libxkbcommon-dev
  doas apt install -y libxkbcommon-x11-dev
  doas apt install -y autoconf
  doas apt install -y xutils-dev
  doas apt install -y libtool
  doas apt install -y libcurl4-openssl-dev
  doas apt install -y python-xcbgen
  doas apt install -y libxcb-xrm-dev
  doas apt install -y libmpdclient-dev
  doas apt install -y libiw-dev
  doas apt install -y libpulse-dev
  doas apt install -y libxcb-composite0-dev
  doas apt install -y xcb-proto
  doas apt install -y libxcb-ewmh-dev
  doas apt install -y libssl-dev
  doas apt install -y libjsoncpp-dev
  doas apt install -y pulseaudio
  doas apt install -y i3
  doas apt install -y libcairo-dev
  doas apt install -y python3-xcbgen
elif [ "$OS" = "FreeBSD" ]; then
  doas pkg install -y cmake
  # sudo pkg install -y nproc
  doas pkg install -y polybar
  exit 0
elif [ "$OS" = "Solus" ]; then
  doas eopkg install -c system.devel
  doas eopkg install -y libcairo-devel
  doas eopkg install -y alsa-lib-devel
  doas eopkg install -y curl-devel
  doas eopkg install -y libmpdclient-devel
  doas eopkg install -y wireless-tools-devel
  doas eopkg install -y pulseaudio-devel
  doas eopkg install -y xcb-proto
  doas eopkg install -y xcb-util-wm-devel
  doas eopkg install -y xcb-util-image-devel
  doas eopkg install -y xcb-util-wm-devel
  doas eopkg install -y jsoncpp-devel
  doas eopkg install -y i3-devel
  doas eopkg install -y xcb-util-devel
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  doas zypper install -y alsa
  doas zypper install -y cairo-devel
  doas zypper install -y libev-devel
  doas zypper install -y libasound2-devel
  doas zypper install -y libxcb1-devel
  doas zypper install -y libxcb-keysyms1-devel
  doas zypper install -y libpango1.0-devel
  doas zypper install -y libxcb-util0-devel
  doas zypper install -y libxcb-icccm4-devel
  doas zypper install -y libyajl-devel
  doas zypper install -y libstartup-notification0-devel
  doas zypper install -y libxcb-randr0-devel
  doas zypper install -y libev-devel
  doas zypper install -y libxcb-cursor-devel
  doas zypper install -y libxcb-xinerama0-devel
  doas zypper install -y libxcb-xkb-devel
  doas zypper install -y libxkbcommon-devel
  doas zypper install -y libxkbcommon-x11-devel
  doas zypper install -y autoconf
  doas zypper install -y xutils-devel
  doas zypper install -y libtool
  doas zypper install -y libcurl4-openssl-devel
  doas zypper install -y python-xcbgen
  doas zypper install -y libxcb-xrm-devel
  doas zypper install -y libmpdclient-devel
  doas zypper install -y libiw-devel
  doas zypper install -y libpulse-devel
  doas zypper install -y libxcb-composite0-devel
  doas zypper install -y xcb-proto
  doas zypper install -y libxcb-ewmh-devel
  doas zypper install -y libssl-devel
  doas zypper install -y jsoncpp
  doas zypper install -y libcurl-devel
  doas zypper install -y xcb-proto-devel
  doas zypper install -y libxcb-devel
  doas zypper install -y xcb-util-devel
  doas zypper install -y libxcb-ewmh2
  doas zypper install -y xcb-util-wm-devel
  # sudo zypper install -y i3-gaps
  # sudo zypper install -y libxcb-image0
  doas zypper install -y xcb-util-image-devel
  doas zypper install -y jsoncpp-devel
  doas zypper install -y fontawesome-fonts
  doas zypper install -y alsa-devel
  doas zypper install -y gtk-doc
  doas zypper install -y autogen
  doas zypper install -y json-glib-devel
  doas zypper install -y gobject-introspection
  doas zypper install -y cmake
  doas zypper install -y gcc-c++
  doas zypper install -y i3-devel
elif [ "$OS" = "Void" ]; then
  doas xbps-install -y libcurl-devel
  doas xbps-install -y libmpdclient-devel
  doas xbps-install -y pulseaudio-devel
  doas xbps-install -y jsoncpp-devel
  doas xbps-install -y wireless_tools-devel
  doas xbps-install -y i3-devel
  doas xbps-install -y cairo-devel
  doas xbps-install -y alsa-lib-devel
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  doas pacman --noconfirm --needed -S libmpdclient
  doas pacman --noconfirm --needed -S jsoncpp
  doas pacman --noconfirm --needed -S python-sphinx
elif [ "$OS" = "Gentoo" ]; then
  GENTOO_PKGS="jsoncpp cmake x11-libs/cairo media-sound/alsa-utils libmpdclient wireless-tools pulseaudio i3"
  FAILURE=""
  for i in $($GENTOO_PKGS); do
    if ! sudo emerge --update --newuse "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo "Failures: $FAILURE"
else
  echo "OS='$OS' is not implemented or is not defined."
  exit 1
fi

export USE_GCC="ON"
export ENABLE_I3="OFF"
# [ "$OS" = "openSUSE Tumbleweed" ] && export ENABLE_I3="OFF"
export ENABLE_ALSA="ON"
export ENABLE_PULSEAUDIO="ON"
export ENABLE_NETWORK="ON"
# [ "$OS" = "void" ] && export ENABLE_NETWORK="OFF"
export ENABLE_MPD="ON"
export ENABLE_CURL="ON"
export ENABLE_IPC_MSG="ON"
JOB_COUNT="$(nproc)"
export JOB_COUNT
export INSTALL="ON"
export INSTALL_CONF="OFF"

cd "$HOME/projects/" || exit
git clone --recursive git@github.com:polybar/polybar.git
cd polybar || exit
git pull origin master
./build.sh
cd "$HOME" || exit

exit 0

# vim: set ft=sh
