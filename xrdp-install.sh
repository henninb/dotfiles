#!/bin/sh

cat > xrdp.rc <<'EOF'
#!/sbin/openrc-run

#sudo cp xrdp.rc /etc/init.d/xrdp

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

cat > 45-allow.colord.pkla <<EOF
[Allow Colord all Users]
Identity=unix-user:*
Action=org.freedesktop.color-manager.create-device;org.freedesktop.color-manager.create-profile;org.freedesktop.color-manager.delete-device;org.freedesktop.color-manager.delete-profile;org.freedesktop.color-manager.modify-device;org.freedesktop.color-manager.modify-profile
ResultAny=no
ResultInactive=no
ResultActive=yes
EOF

# cat > xrdp.ini <<'EOF'
# [tightvnc]
# name=RDP_To_TightVNC
# lib=libvnc.so
# username=ask
# password=ask
# ip=127.0.0.1
# port=-1
# EOF

echo startwm.sh for archlinux gentoo fedora
cat > startwm.sh <<'EOF'
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

#xset +fp ~/.fonts
xrdb -merge ~/.Xresources

# for troubleshooting uncomment
#exec xterm
#exec urxvt

. ~/.xinitrc

exit 0
EOF

cat > Xwrapper.config <<EOF
allowed_users=anybody
needs_root_rights=yes
EOF

sudo mkdir -p /etc/X11

chmod 755 startwm.sh
chmod 755 xrdp.rc

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ]; then
  mkdir -p "$HOME/projects"
  sudo pacman --noconfirm --needed -S patch autoconf automake pkg-config fakeroot lsof nasm net-tools libtool xorg-server-devel make libxfont2
  sudo pacman --noconfirm --needed -S xorg-server
  sudo pacman --noconfirm --needed -S xorg-xinit

  # cd $HOME/projects
  # git clone https://aur.archlinux.org/xrdp.git xrdp-aur
  # cd xrdp-aur
  # # makepkg -si

  # cd $HOME/projects
  # git clone https://aur.archlinux.org/xorgxrdp-git.git xorgxrdp-aur
  # cd xorgxrdp-aur
  # # makepkg -si

  echo xrdp v0.9.11 was release on 8-19-2019
  cd "$HOME/projects" || exit
  git clone --recursive git@github.com:neutrinolabs/xrdp.git
  cd xrdp || exit
  git pull origin master
  ./bootstrap
  ./configure
  make clean
  if ! make; then
    echo build failed for xrdp.
    exit 1
  fi
  sudo make install

  cd "$HOME/projects" || exit
  git clone --recursive git@github.com:neutrinolabs/xorgxrdp.git
  cd xorgxrdp || exit
  git checkout master
  git pull origin master
  ./bootstrap
  ./configure XRDP_CFLAGS=-I"$HOME/projects/xrdp/common" XRDP_LIBS=" "
  make clean
  if ! make; then
    echo build failed for xrdp-xorgxrdp.
    exit 1
  fi
  sudo make install
  cd "$HOME" || exit
  sudo mv -v startwm.sh /etc/xrdp/startwm.sh
  sudo mv -v Xwrapper.config /etc/X11/Xwrapper.config
elif [ "$OS" = "Solus" ]; then
  echo
elif [ "$OS" = "void" ]; then
  sudo xbps-install -y nasm
  sudo xbps-install -y pam-devel
  sudo xbps-install -y libXrandr-devel
  sudo xbps-install -y xorg-server-devel
  cd /tmp
  curl -LO https://www.openssl.org/source/openssl-1.1.1.tar.gz
  tar xvf openssl-1.1.1.tar.gz
  cd openssl-1.1.1
  #./config --prefix=/opt/openssl/1.1.1
  ./config --prefix=/usr
  make
  sudo make install
  sudo usermod -a -G tty $(id -un)
  cd $HOME/projects
  git clone --recursive https://github.com/neutrinolabs/xrdp
  cd xrdp
  ./bootstrap
  #./configure OPENSSL_CFLAGS=-I/opt/openssl/1.1.1/include OPENSSL_LIBS="-L/opt/openssl/1.1.1/lib -lssl -lcrypto"
  ./configure
  make
  if [ $? -ne 0 ]; then
    echo build failed for xrdp.
    exit 1
  fi
  sudo make install

  cd $HOME/projects
  git clone git@github.com:neutrinolabs/xorgxrdp.git
  cd xorgxrdp
  ./bootstrap
  ./configure XRDP_CFLAGS=-I$HOME/projects/xrdp/common XRDP_LIBS=" "
  make
  if [ $? -ne 0 ]; then
    echo build failed for xorgxrdp.
    exit 1
  fi
  sudo make install
  cd "$HOME" || exit
  sudo mv -v Xwrapper.config /etc/X11/Xwrapper.config
  sudo mv -v startwm.sh /etc/xrdp/startwm.sh
elif [ "$OS" = "Gentoo" ]; then
  sudo usermod -a -G tty $(id -un)
  cd $HOME/projects
  git clone --recursive https://github.com/neutrinolabs/xrdp
  cd xrdp
  ./bootstrap
  ./configure
  make
  if [ $? -ne 0 ]; then
    echo build failed for xrdp.
    exit 1
  fi
  sudo make install

  cd $HOME/projects
  git clone git@github.com:neutrinolabs/xorgxrdp.git
  cd xorgxrdp
  ./bootstrap
  ./configure XRDP_CFLAGS=-I"$HOME/projects/xrdp/common" XRDP_LIBS=" "
  make
  if [ $? -ne 0 ]; then
    echo build failed for xorgxrdp.
    exit 1
  fi
  sudo make install

  #USE="server" sudo emerge  --update --newuse net-misc/tigervnc
  cd "$HOME"
  sudo mv -v startwm.sh /etc/xrdp/startwm.sh
  sudo mv -v xrdp.rc /etc/init.d/xrdp
  sudo mv -v Xwrapper.config /etc/X11/Xwrapper.config
elif [ "$OS" = "Fedora" ]; then
    sudo dnf install -y libtool
    sudo dnf install -y openssl-devel
    sudo dnf install -y pam-devel
    sudo dnf install -y nasm
    sudo dnf install -y libX11-devel
    sudo dnf install -y libXfixes-devel
    sudo dnf install -y libXrandr-devel
    sudo dnf install -y xorg-x11-server-devel
    #sudo dnf install -y xrdp
    #sudo dnf install -y xorgxrdp

    # echo xrdp v0.9.11 was release on 8-19-2019
    cd "$HOME/projects" || exit
    git clone --recursive git@github.com:neutrinolabs/xrdp.git
    cd xrdp || exit
    git pull origin master
    ./bootstrap
    ./configure
    make clean
    if ! make; then
      echo build failed for xrdp.
      exit 1
    fi
    sudo make install

    cd "$HOME/projects" || exit
    git clone --recursive git@github.com:neutrinolabs/xorgxrdp.git
    cd xorgxrdp || exit
    git checkout master
    git pull origin master
    ./bootstrap
    autoreconf --install
    ./configure XRDP_CFLAGS=-I$HOME/projects/xrdp/common XRDP_LIBS=" "
    make clean
    if ! make; then
      echo build failed for xrdp-xorgxrdp.
      exit 1
    fi
    sudo make install
    sudo mv -v startwm.sh /etc/xrdp/startwm.sh

    cd "$HOME" || exit
    sudo mv -v startwm.sh /etc/xrdp/startwm.sh
    sudo mv -v Xwrapper.config /etc/X11/Xwrapper.config
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
    # sudo zypper install -y xorg-x11-server-devel
    cd "$HOME/projects" || exit
    git clone --recursive git@github.com:neutrinolabs/xrdp.git
    cd xrdp || exit
    git pull origin master
    ./bootstrap
    ./configure
    make clean
    if ! make; then
      echo build failed for xrdp.
      exit 1
    fi
    sudo make install

  cd "$HOME/projects" || exit
  git clone git@github.com:neutrinolabs/xorgxrdp.git
  cd xorgxrdp || exit
  ./bootstrap
  ./configure XRDP_CFLAGS=-I"$HOME/projects/xrdp/common" XRDP_LIBS=" "
  if ! make ; then
    echo build failed for xorgxrdp.
    exit 1
  fi
  sudo make install
  cd "$HOME" || exit
  sudo mv -v startwm.sh /etc/xrdp/startwm.sh
  sudo mv -v Xwrapper.config /etc/X11/Xwrapper.config
  sudo systemctl stop firewalld
  sudo systemctl disable firewalld
elif [ "$OS" = "CentOS Linux" ]; then
  if [ "$OS_VER" = "8" ]; then
    echo centos8
    sudo dnf install -y libtool
    sudo dnf install -y openssl-devel
    sudo dnf install -y pam-devel
#    sudo dnf install -y xorg-x11-server-devel
    echo sudo dnf install -y nasm
    sudo dnf install -y libX11-devel
    sudo dnf install -y libXfixes-devel
    sudo dnf install -y libXrandr-devel
    sudo dnf install -y xrdp
  else
    echo centos7
    sudo yum install -y libtool openssl-devel pam-devel xorg-x11-server-devel nasm
  fi

  cd "$HOME/projects" || exit
  git clone --recursive https://github.com/neutrinolabs/xrdp
  cd xrdp || exit
  ./bootstrap
  ./configure
  if ! make ; then
    echo build failed for xrdp.
    exit 1
  fi
  sudo make install

  cd "$HOME/projects" || exit
  git clone git@github.com:neutrinolabs/xorgxrdp.git
  cd xorgxrdp || exit
  ./bootstrap
  ./configure XRDP_CFLAGS=-I"$HOME/projects/xrdp/common" XRDP_LIBS=" "
  if ! make ; then
    echo build failed for xorgxrdp.
    exit 1
  fi
  sudo make install
  cd "$HOME" || exit
  sudo mv -v startwm.sh /etc/xrdp/startwm.sh
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ]; then
  sudo usermod -a -G tty "$(id -un)"
  #echo sudo apt install -y xrdp xorgxrdp
  sudo apt install -y rdesktop freerdp-x11 lsof
  sudo apt install -y libpam0g-dev
  sudo apt install -y nasm
  sudo apt install -y xserver-xorg-dev
  cd "$HOME/projects" || exit
  git clone --recursive https://github.com/neutrinolabs/xrdp
  cd xrdp || exit
  ./bootstrap
  ./configure
  if ! make ; then
    echo build failed for xrdp.
    exit 1
  fi
  sudo make install

  cd "$HOME/projects" || exit
  git clone git@github.com:neutrinolabs/xorgxrdp.git
  cd xorgxrdp || exit
  ./bootstrap
  ./configure XRDP_CFLAGS=-I"$HOME/projects/xrdp/common" XRDP_LIBS=" "
  if ! make ; then
    echo build failed for xorgxrdp.
    exit 1
  fi
  sudo make install
  cd "$HOME" || exit
  sudo mv -v Xwrapper.config /etc/X11/Xwrapper.config
  sudo mv -v startwm.sh /etc/xrdp/startwm.sh
elif [ "$OS" = "Raspbian GNU/Linux" ]; then
  #sudo apt purge -y xserver-xorg-legacy
  sudo apt install -y libpam0g-dev
  sudo apt install -y xserver-xorg-dev
  sudo apt install -y lsof
  sudo apt install -y xrdp
  sudo apt install -y feh
  sudo apt install -y dmenu
  sudo apt install -y xorgxrdp
  sudo apt install -y rdesktop
  sudo apt install -y freerdp2-x11

  sudo usermod -a -G dialout "$(id -un)"
  cd "$HOME" || exit
  sudo mv -v Xwrapper.config /etc/X11/Xwrapper.config
  sudo mv -v startwm.sh /etc/xrdp/startwm.sh
else
  echo "$OS is not yet implemented."
  exit 1
fi

if [ "$OS" = "Gentoo" ]; then
  sudo rc-update add xrdp default
  sudo rc-service xrdp start
  sudo rc-service xrdp status
else
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
