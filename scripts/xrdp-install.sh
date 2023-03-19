#!/bin/sh

xrdp_build() {
  echo xrdp v0.9.14
  cd "$HOME/projects" || exit
  git clone --recursive git@github.com:neutrinolabs/xrdp.git
  cd xrdp || exit
  git fetch
  git checkout v0.9.14
  make clean
  if ! ./bootstrap; then
    echo bootstrap failed
    exit 2
  fi
  # ./configure
  ./configure --enable-fuse --enable-mp3lame --enable-pixman
  patch common/Makefile < "$HOME/xrdp-log-Makefile-patch"
  if ! make; then
    echo build failed for xrdp.
    exit 1
  fi
  sudo make install
}

xorgxrdp_build() {
  cd "$HOME/projects" || exit
  git clone --recursive git@github.com:neutrinolabs/xorgxrdp.git
  cd xorgxrdp || exit
  git fetch
  git checkout v0.2.14
  if ! ./bootstrap; then
    echo bootstrap failed
    exit 2
  fi
  ./configure XRDP_CFLAGS=-I"$HOME/projects/xrdp/common" XRDP_LIBS=" "
  if ! make; then
    echo build failed for xrdp-xorgxrdp.
    exit 1
  fi
  sudo make install
}

cat <<  EOF > "$HOME/tmp/xrdp.rc"
#!/sbin/openrc-run

#sudo cp -v xrdp.rc /etc/init.d/xrdp

start() {
  ebegin "Starting xrdp"
  start-stop-daemon --quiet --start -x /usr/local/sbin/xrdp
  eend $? "xrdp did not start, error code $?"
  start-stop-daemon --quiet --start -x /usr/local/sbin/xrdp-sesman
  eend $? "xrdp-sesman did not start, error code $?"
}

stop() {
  ebegin "Stopping xrdp"
  start-stop-daemon --quiet --stop -x /usr/local/sbin/xrdp
  eend $? "xrdp did not stop, error code $?"
  start-stop-daemon --quiet --stop -x /usr/local/sbin/xrdp-sesman
  eend $? "xrdp-sesman did not stop, error code $?"
  rm -rf /run/xrdp.pid
  rm -rf /var/log/xrdp.log
  rm -rf /run/xrdp-sesman.pid
  rm -rf /var/log/xrdp-sesman.log
}

depend() {
  need net
  before logger
}
EOF

cat <<  EOF > "$HOME/tmp/45-allow.colord.pkla"
[Allow Colord all Users]
Identity=unix-user:*
Action=org.freedesktop.color-manager.create-device;org.freedesktop.color-manager.create-profile;org.freedesktop.color-manager.delete-device;org.freedesktop.color-manager.delete-profile;org.freedesktop.color-manager.modify-device;org.freedesktop.color-manager.modify-profile
ResultAny=no
ResultInactive=no
ResultActive=yes
EOF

echo "$HOME/tmp/startwm.sh" for archlinux gentoo fedora

cat <<  EOF > "$HOME/tmp/startwm.sh"
#!/usr/bin/env sh

export TERM="xterm-256color"
#export LANG=en_US.UTF-8
#export LC_CTYPE="en_US.UTF-8"

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_NUMERIC=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export LC_COLLATE=C
export LC_MONETARY=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_PAPER=en_US.UTF-8
export LC_NAME=en_US.UTF-8
export LC_ADDRESS=en_US.UTF-8
export LC_TELEPHONE=en_US.UTF-8
export LC_MEASUREMENT=en_US.UTF-8
export LC_IDENTIFICATION=en_US.UTF-8

export FONTCONFIG_PATH=/etc/fonts
#xset +fp ~/.fonts
xrdb -merge ~/.Xresources
if [ $? -ne 0 ]; then
  echo "xrdb not found"
fi

# for troubleshooting uncomment
#exec xterm
#exec urxvt

. ~/.xinitrc

exit 0
EOF

cat <<  EOF > "$HOME/tmp/xrdp-sesman"
/etc/pam.d/xrdp-sesman
auth       required     pam_unix.so shadow
auth       required     pam_env.so
password    required    pam_unix.so
account     required    pam_unix.so
account     required    pam_nologin.so
session     required    pam_unix.so
EOF

cat <<  EOF > "$HOME/tmp/Xwrapper.config"
allowed_users=anybody
needs_root_rights=yes
EOF

sudo mkdir -p /etc/X11

chmod 755 "$HOME/tmp/startwm.sh"
chmod 755 "$HOME/tmp/xrdp.rc"

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  mkdir -p "$HOME/projects"
  sudo pacman --noconfirm --needed -S patch autoconf automake pkg-config fakeroot lsof nasm net-tools libtool xorg-server-devel make libxfont2
  sudo pacman --noconfirm --needed -S xorg-server
  sudo pacman --noconfirm --needed -S xorg-xinit

  xrdp_build
  xorgxrdp_build

  cd "$HOME" || exit
  sudo mv -v "$HOME/tmp/startwm.sh" /etc/xrdp/startwm.sh
  sudo mv -v "$HOME/tmp/Xwrapper.config" /etc/X11/Xwrapper.config
elif [ "$OS" = "Solus" ]; then
  sudo eopkg install -c system.devel
  sudo eopkg install -y nasm
  sudo eopkg install -y pam-devel
  sudo eopkg install -y libxrandr-devel
  sudo eopkg install -y xorg-server-devel
  sudo eopkg install -y libxfont2-devel
  sudo eopkg install -y fuse-devel
  sudo eopkg install -y lame-devel
  sudo eopkg install -y libxfixes-devel

  xrdp_build
  xorgxrdp_build

  cd "$HOME" || exit
  sudo mv -v "$HOME/tmp/Xwrapper.config" /etc/X11/Xwrapper.config
  sudo mv -v "$HOME/tmp/startwm.sh" /etc/xrdp/startwm.sh
elif [ "$OS" = "Clear Linux OS" ]; then
  echo "clearlinux"
elif [ "$OS" = "Darwin" ]; then
  echo "macos"
elif [ "$OS" = "FreeBSD" ]; then
  echo "freebsd"
elif [ "$OS" = "OpenBSD" ]; then
  echo "openbsd"
elif [ "$OS" = "Void" ]; then
  sudo xbps-install -y nasm
  sudo xbps-install -y pam-devel
  sudo xbps-install -y libXrandr-devel
  sudo xbps-install -y xorg-server-devel
  cd /tmp || exit
  curl -LO https://www.openssl.org/source/openssl-1.1.1.tar.gz
  tar xvf openssl-1.1.1.tar.gz
  cd openssl-1.1.1 || exit
  #./config --prefix=/opt/openssl/1.1.1
  ./config --prefix=/usr
  make
  sudo make install
  sudo usermod -a -G tty "$(id -un)"

  xrdp_build
  xorgxrdp_build

  sudo mv -v "$HOME/tmp/Xwrapper.config" /etc/X11/Xwrapper.config
  sudo mv -v "$HOME/tmp/startwm.sh" /etc/xrdp/startwm.sh
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge  --update --newuse x11-libs/libX11
  sudo emerge  --update --newuse nasm
  sudo emerge  --update --newuse lame
  #sudo emerge  --update --newuse x11-base/xorg-server
  sudo emerge  --update --newuse x11-base/xorg-x11
  sudo emerge  --update --newuse x11-libs/libXfixes
  sudo emerge  --update --newuse x11-libs/libXrandr
  #sudo emerge  --update --newuse x11-libs/libX11
  sudo usermod -a -G tty "$(id -un)"

  xrdp_build
  xorgxrdp_build

  #USE="server" sudo emerge  --update --newuse net-misc/tigervnc
  cd "$HOME" || exit
  sudo mv -v "$HOME/tmp/startwm.sh" /etc/xrdp/startwm.sh
  sudo mv -v xrdp.rc /etc/init.d/xrdp
  sudo mv -v "$HOME/tmp/Xwrapper.config" /etc/X11/Xwrapper.config
elif [ "$OS" = "Fedora Linux" ]; then
    sudo dnf install -y libtool
    sudo dnf install -y openssl-devel
    sudo dnf install -y pam-devel
    sudo dnf install -y nasm
    sudo dnf install -y libX11-devel
    sudo dnf install -y libXfixes-devel
    sudo dnf install -y libXrandr-devel
    sudo dnf install -y xorg-x11-server-devel

    xrdp_build
    xorgxrdp_build

    cd "$HOME" || exit
    sudo mv -v "$HOME/tmp/startwm.sh" /etc/xrdp/startwm.sh
    sudo mv -v "$HOME/tmp/Xwrapper.config" /etc/X11/Xwrapper.config
    sudo mv -v 45-allow.colord.pkla /etc/polkit-1/localauthority/50-local.d/
    sudo systemctl disable firewalld
    sudo systemctl stop firewalld
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
    sudo zypper install -y libtool
    sudo zypper install -y openssl-devel
    sudo zypper install -y pam-devel
    sudo zypper install -y nasm
    sudo zypper install -y libX11-devel
    sudo zypper install -y libXfixes-devel
    sudo zypper install -y libXrandr-devel
    sudo zypper install -y xorg-x11-server
    sudo zypper install -y xorg-x11-server-sdk
    sudo zypper install -y libXfont2-devel
    sudo zypper install -y xorg-x11
    sudo zypper install -y make
    sudo zypper install -y gcc
    sudo zypper install -y xorg-x11-server-sdk
    # sudo zypper install -y xorg-x11-server-devel

    xrdp_build
    xorgxrdp_build

    cd "$HOME" || exit
    sudo mv -v "$HOME/tmp/startwm.sh" /etc/xrdp/startwm.sh
    sudo mv -v "$HOME/tmp/Xwrapper.config" /etc/X11/Xwrapper.config
    sudo systemctl stop firewalld
    sudo systemctl disable firewalld
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo usermod -a -G tty "$(id -un)"
  #echo sudo apt install -y xrdp xorgxrdp
  sudo apt install -y rdesktop freerdp-x11 lsof
  sudo apt install -y libpam0g-dev
  sudo apt install -y nasm
  sudo apt install -y libssl-dev
  sudo apt install -y xserver-xorg-dev
  sudo apt install -y libxfixes-dev
  sudo apt install -y libxrandr-dev
  sudo apt install -y autoconf
  sudo apt install -y libtool
  sudo apt install -y pkg-config
  sudo apt install -y make

  xrdp_build
  xorgxrdp_build

  cd "$HOME" || exit
  sudo mv -v "$HOME/tmp/Xwrapper.config" /etc/X11/Xwrapper.config
  sudo mv -v "$HOME/tmp/startwm.sh" /etc/xrdp/startwm.sh
else
  echo "$OS is not yet implemented."
  exit 1
fi

if command -v systemctl; then
  sudo systemctl enable xrdp
  sudo systemctl enable xrdp-sesman
  sudo systemctl start xrdp
  sudo systemctl start xrdp-sesman
  sudo systemctl status xrdp
  sudo systemctl status xrdp-sesman
  echo systemctl unmask xrdp
fi

#vncserver -list
netstat -na | grep 3389 | grep LIST
netstat -na | grep 3350 | grep LIST
sudo fuser 3389/tcp
sudo fuser 3350/tcp

#sudo lsof -Pi | grep LISTEN
#/etc/X11/xrdp/xorg.conf
#cat $HOME/.xorgxrdp.10.log
#$HOME/.xsession
#setpriv --no-new-privs Xorg :10 -auth .Xauthority -config xrdp/xorg.conf -noreset -nolisten tcp -logfile $HOME/.xorgxrdp.%s.log

xrdp --version

exit 0

# vim: set ft=sh
