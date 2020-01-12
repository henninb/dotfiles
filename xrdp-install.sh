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

cat > Xwrapper.config <<'EOF'
allowed_users=anybody
needs_root_rights=yes
EOF

sudo mkdir -p /etc/X11

chmod 755 startwm.sh
chmod 755 xrdp.rc

if [ "$OS" = "Arch Linux" ]; then
  mkdir -p $HOME/projects
  sudo pacman --noconfirm --needed -S patch autoconf automake pkg-config fakeroot lsof nasm net-tools libtool xorg-server-devel make terminator

  # cd $HOME/projects
  # git clone https://aur.archlinux.org/xrdp.git xrdp-aur
  # cd xrdp-aur
  # # makepkg -si

  # cd $HOME/projects
  # git clone https://aur.archlinux.org/xorgxrdp-git.git xorgxrdp-aur
  # cd xorgxrdp-aur
  # # makepkg -si

  echo xrdp v0.9.11 was release on 8-19-2019
  cd $HOME/projects
  git clone --recursive git@github.com:neutrinolabs/xrdp.git
  cd xrdp
  ./bootstrap
  ./configure
  make
  sudo make install

  cd $HOME/projects
  git clone git@github.com:neutrinolabs/xorgxrdp.git
  cd xorgxrdp
  ./bootstrap
  ./configure XRDP_CFLAGS=-I$HOME/projects/xrdp/common XRDP_LIBS=" "
  make
  sudo make install
  sudo cp startwm.sh /etc/xrdp/startwm.sh

  cd $HOME
  #chmod 755 startwm.sh
  #sudo cp -v Xwrapper.config /etc/xorg/Xwrapper.config
  sudo cp -v Xwrapper.config /etc/X11/Xwrapper.config
  sudo systemctl enable xrdp
  sudo systemctl start xrdp
  sudo systemctl status xrdp
  #chmod 755 $HOME/startwm.sh
  #sudo cp -v /etc/xrdp/startwm.sh /etc/xrdp/startwm.sh.bak.$$
  #sudo mv -v startwm.sh /etc/xrdp/startwm.sh
elif [ "$OS" = "Gentoo" ]; then
  sudo usermod -a -G tty $(id -un)
  cd $HOME/projects
  git clone --recursive https://github.com/neutrinolabs/xrdp
  cd xrdp
  ./bootstrap
  ./configure
  make
  sudo make install

  cd $HOME/projects
  git clone git@github.com:neutrinolabs/xorgxrdp.git
  cd xorgxrdp
  ./bootstrap
  ./configure XRDP_CFLAGS=-I$HOME/projects/xrdp/common XRDP_LIBS=" "
  make
  sudo make install

  #USE="server" sudo emerge  --update --newuse net-misc/tigervnc
  sudo mv -v startwm.sh /etc/xrdp/startwm.sh
  sudo mv -v xrdp.rc /etc/init.d/xrdp

  cd $HOME
  sudo cp -v Xwrapper.config /etc/X11/Xwrapper.config
  sudo rc-update add xrdp default
  sudo rc-service xrdp start
elif [ "$OS" = "Fedora" ]; then
    sudo dnf install -y libtool
    sudo dnf install -y openssl-devel
    sudo dnf install -y pam-devel
    sudo dnf install -y nasm
    sudo dnf install -y libX11-devel
    sudo dnf install -y libXfixes-devel
    sudo dnf install -y libXrandr-devel
    sudo dnf install -y xrdp
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

  cd $HOME/projects
  git clone --recursive https://github.com/neutrinolabs/xrdp
  cd xrdp
  ./bootstrap
  ./configure
  make
  sudo make install

  cd $HOME/projects
  git clone git@github.com:neutrinolabs/xorgxrdp.git
  cd xorgxrdp
  ./bootstrap
  ./configure XRDP_CFLAGS=-I$HOME/projects/xrdp/common XRDP_LIBS=" "
  make
  sudo make install
  sudo mv -v startwm.sh /etc/xrdp/startwm.sh

  sudo systemctl enable xrdp
  sudo systemctl start xrdp
  sudo systemctl status xrdp
elif [ \( "$OS" = "Linux Mint" \) -o \(  "$OS" = "Ubuntu" \) ]; then
  sudo usermod -a -G tty $(id -un)
  sudo apt install -y xrdp xorgxrdp rdesktop freerdp-x11 lsof
  #sudo cp -v Xwrapper.config /etc/xorg/Xwrapper.config
  sudo cp -v Xwrapper.config /etc/X11/Xwrapper.config
  sudo systemctl start xrdp
  sudo systemctl status xrdp
elif [ \(  "$OS" = "Raspbian GNU/Linux" \) ]; then
  #sudo apt purge -y xserver-xorg-legacy
  sudo apt install -y libpam0g-dev xserver-xorg-dev lsof
  sudo apt install -y xrdp xorgxrdp rdesktop freerdp2-x11

  sudo usermod -a -G dialout $(id -un)
  sudo systemctl start xrdp
  sudo systemctl status xrdp
  cd $HOME
  #sudo cp -v Xwrapper.config /etc/xorg/Xwrapper.config
  sudo cp -v Xwrapper.config /etc/X11/Xwrapper.config
else
  echo $OS is not yet implemented.
  exit 1
fi

xrdp --version

#vncserver -list
echo "xfreerdp /u:henninb /p:'changeit' /cert-ignore /v:127.0.0.1"
sudo lsof -Pi | grep LISTEN
echo ~/.xsession
echo setpriv --no-new-privs Xorg :10 -auth .Xauthority -config xrdp/xorg.conf -noreset -nolisten tcp -logfile $HOME/.xorgxrdp.%s.log
echo cat $HOME/.xorgxrdp.10.log
echo sudo apt-get install xserver-xorg-legacy
netstat -na | grep 3389 | grep LIST
netstat -na | grep 3350 | grep LIST
sudo fuser 3389/tcp
sudo fuser 3350/tcp

echo /etc/X11/xrdp/xorg.conf

exit 0
