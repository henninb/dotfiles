#!/bin/sh

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt install -y libev-dev
  sudo apt install -y libasound2-dev
  sudo apt install -y libxcb1-dev
  sudo apt install -y libxcb-keysyms1-dev
  sudo apt install -y libpango1.0-dev
  sudo apt install -y libxcb-util0-dev
  sudo apt install -y libxcb-icccm4-dev
  sudo apt install -y libyajl-dev
  sudo apt install -y libstartup-notification0-dev
  sudo apt install -y libxcb-randr0-dev
  sudo apt install -y libev-dev
  sudo apt install -y libxcb-cursor-dev
  sudo apt install -y libxcb-xinerama0-dev
  sudo apt install -y libxcb-xkb-dev
  sudo apt install -y libxkbcommon-dev
  sudo apt install -y libxkbcommon-x11-dev
  sudo apt install -y autoconf
  sudo apt install -y xutils-dev
  sudo apt install -y libtool
  sudo apt install -y libcurl4-openssl-dev
  sudo apt install -y python-xcbgen
  sudo apt install -y libxcb-xrm-dev
  sudo apt install -y libmpdclient-dev
  sudo apt install -y libiw-dev
  sudo apt install -y libpulse-dev
  sudo apt install -y libxcb-composite0-dev
  sudo apt install -y xcb-proto
  sudo apt install -y libxcb-ewmh-dev
  sudo apt install -y libssl-dev
  sudo apt install -y libjsoncpp-dev
  sudo apt install -y pulseaudio
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  sudo zypper install -y alsa
  sudo zypper install -y cairo-devel
  sudo zypper install -y libev-devel
  sudo zypper install -y libasound2-devel
  sudo zypper install -y libxcb1-devel
  sudo zypper install -y libxcb-keysyms1-devel
  sudo zypper install -y libpango1.0-devel
  sudo zypper install -y libxcb-util0-devel
  sudo zypper install -y libxcb-icccm4-devel
  sudo zypper install -y libyajl-devel
  sudo zypper install -y libstartup-notification0-devel
  sudo zypper install -y libxcb-randr0-devel
  sudo zypper install -y libev-devel
  sudo zypper install -y libxcb-cursor-devel
  sudo zypper install -y libxcb-xinerama0-devel
  sudo zypper install -y libxcb-xkb-devel
  sudo zypper install -y libxkbcommon-devel
  sudo zypper install -y libxkbcommon-x11-devel
  sudo zypper install -y autoconf
  sudo zypper install -y xutils-devel
  sudo zypper install -y libtool
  sudo zypper install -y libcurl4-openssl-devel
  sudo zypper install -y python-xcbgen
  sudo zypper install -y libxcb-xrm-devel
  sudo zypper install -y libmpdclient-devel
  sudo zypper install -y libiw-devel
  sudo zypper install -y libpulse-devel
  sudo zypper install -y libxcb-composite0-devel
  sudo zypper install -y xcb-proto
  sudo zypper install -y libxcb-ewmh-devel
  sudo zypper install -y libssl-devel
  sudo zypper install -y jsoncpp
  sudo zypper install -y libcurl-devel
  sudo zypper install -y xcb-proto-devel
  sudo zypper install -y libxcb-devel
  sudo zypper install -y xcb-util-devel
  sudo zypper install -y libxcb-ewmh2
  sudo zypper install -y xcb-util-wm-devel
  # sudo zypper install -y i3-gaps
  sudo zypper install -y i3
  # sudo zypper install -y libxcb-image0
  sudo zypper install -y xcb-util-image-devel
  sudo zypper install -y jsoncpp-devel
  sudo zypper install -y fontawesome-fonts
  sudo zypper install -y alsa-devel
elif [ "$OS" = "Arch Linux" ]; then
  sudo pacman --noconfirm --needed -S libmpdclient
  sudo pacman --noconfirm --needed -S jsoncpp
elif [ "$OS" = "Gentoo" ]; then
  GENTOO_PKGS="jsoncpp"
  FAILURES=""
  for i in $(echo "$GENTOO_PKGS"); do
    if ! sudo emerge --update --newuse "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo "Failures: $FAILURE"
else
  echo
fi


export USE_GCC="ON"
export ENABLE_I3="OFF"
# export ENABLE_ALSA="ON"
export ENABLE_ALSA="ON"
export ENABLE_PULSEAUDIO="ON"
export ENABLE_NETWORK="ON"
export ENABLE_MPD="ON"
export ENABLE_CURL="ON"
export ENABLE_IPC_MSG="ON"
export JOB_COUNT=$(nproc)

cd $HOME/projects/
git clone --recursive https://github.com/jaagr/polybar.git
cd polybar
./build.sh
cd $HOME

echo -- Font not found: unifont:fontformat=truetype
echo -- Font not found: siji:pixelsize=10
echo ** Execute 'sudo make install'? [Y/n] y
echo ** Install example configuration? [y/N]: n


exit 0
