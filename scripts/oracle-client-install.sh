#!/bin/sh

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  doas apt install -y alien fakeroot
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  doas pacman --noconfirm --needed -S libnsl
  doas pacman --noconfirm --needed -S rpm
elif [ "$OS" = "Gentoo" ]; then
  doas emerge --update --newuse rpm
elif [ "$OS" = "Void" ]; then
  doas xbps-install -y rpm
elif [ "$OS" = "Darwin" ]; then
  echo noop
elif [ "$OS" = "Fedora Linux" ]; then
  doas dnf install -y libnsl
else
  echo "$OS is not yet implemented."
  exit 1
fi

#export LD_LIBRARY_PATH=/opt/oracle/instantclient:$LD_LIBRARY_PATH
#echo /usr/lib/oracle/19.3/client64/lib/libsqlplus.so

if [ ! "$OS" = "Darwin" ]; then
  if [ ! -f "/$HOME/tmp/oracle-instantclient19.3-basic-19.3.0.0.0-1.x86_64.rpm" ]; then
    scp pi@pi:/home/pi/downloads/oracle-instantclient19.3-basic-19.3.0.0.0-1.x86_64.rpm "$HOME/tmp"
    if ! scp "pi@pi:/home/pi/downloads/oracle-instantclient19.3-basic-19.3.0.0.0-1.x86_64.rpm" "$HOME/tmp"; then
      curl -s https://download.oracle.com/otn_software/linux/instantclient/193000/oracle-instantclient19.3-basic-19.3.0.0.0-1.x86_64.rpm --output "$HOME/tmp/oracle-instantclient19.3-basic-19.3.0.0.0-1.x86_64.rpm"
      # scp oracle-instantclient19.3-basic-19.3.0.0.0-1.x86_64.rpm pi@pi:/home/pi/downloads/
    fi
  fi

  if [ ! -f "/$HOME/tmp/oracle-instantclient19.3-devel-19.3.0.0.0-1.x86_64.rpm" ]; then
    if ! scp pi@pi:/home/pi/downloads/oracle-instantclient19.3-devel-19.3.0.0.0-1.x86_64.rpm "$HOME/tmp"; then
      curl -s https://download.oracle.com/otn_software/linux/instantclient/193000/oracle-instantclient19.3-devel-19.3.0.0.0-1.x86_64.rpm --output "$HOME/tmp/oracle-instantclient19.3-devel-19.3.0.0.0-1.x86_64.rpm"
      # scp oracle-instantclient19.3-devel-19.3.0.0.0-1.x86_64.rpm pi@pi:/home/pi/downloads/
    fi
  fi

  if [ ! -f "/$HOME/tmp/oracle-instantclient19.3-precomp-19.3.0.0.0-1.x86_64.rpm" ]; then
    if ! scp pi@pi:/home/pi/downloads/oracle-instantclient19.3-precomp-19.3.0.0.0-1.x86_64.rpm "$HOME/tmp"; then
      echo "curl -s 'https://www.oracle.com/database/technologies/instant-client/precompiler-112010-downloads.html'"
    fi
  fi

  if [ ! -f "/$HOME/tmp/oracle-instantclient19.3-sqlplus-19.3.0.0.0-1.x86_64.rpm" ]; then
    if ! scp pi@pi:/home/pi/downloads/oracle-instantclient19.3-sqlplus-19.3.0.0.0-1.x86_64.rpm "$HOME/tmp"; then
      curl -s https://download.oracle.com/otn_software/linux/instantclient/193000/oracle-instantclient19.3-sqlplus-19.3.0.0.0-1.x86_64.rpm --output "$HOME/tmp/oracle-instantclient19.3-sqlplus-19.3.0.0.0-1.x86_64.rpm"
       # scp oracle-instantclient19.3-sqlplus-19.3.0.0.0-1.x86_64.rpm pi@pi:/home/pi/downloads/
    fi
  fi
fi

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ]; then
  fakeroot alien oracle-instantclient19.3-basic-19.3.0.0.0-1.x86_64.rpm
  fakeroot alien oracle-instantclient19.3-devel-19.3.0.0.0-1.x86_64.rpm
  fakeroot alien oracle-instantclient19.3-precomp-19.3.0.0.0-1.x86_64.rpm
  fakeroot alien oracle-instantclient19.3-sqlplus-19.3.0.0.0-1.x86_64.rpm
  doas dpkg -i oracle-instantclient19.3-basic_19.3.0.0.0-2_amd64.deb
  doas dpkg -i oracle-instantclient19.3-devel_19.3.0.0.0-2_amd64.deb
  doas dpkg -i oracle-instantclient19.3-precomp_19.3.0.0.0-2_amd64.deb
  doas dpkg -i oracle-instantclient19.3-sqlplus_19.3.0.0.0-2_amd64.deb
elif [ "$OS" = "Darwin" ]; then
  if [ ! -f "instantclient-basic-macos.x64-19.3.0.0.0dbru.zip" ]; then
    wget https://download.oracle.com/otn_software/mac/instantclient/193000/instantclient-basic-macos.x64-19.3.0.0.0dbru.zip
  fi

  if [ ! -f "instantclient-sqlplus-macos.x64-19.3.0.0.0dbru.zip" ]; then
    wget https://download.oracle.com/otn_software/mac/instantclient/193000/instantclient-sqlplus-macos.x64-19.3.0.0.0dbru.zip
  fi

  cd /opt || exit
  sudo unzip -o "$HOME/instantclient-sqlplus-macos.x64-19.3.0.0.0dbru.zip"
  sudo unzip -o "$HOME/instantclient-basic-macos.x64-19.3.0.0.0dbru.zip"
   doas rm -rf instantclient_19_3 oracle-instantclient
  doas mv -v instantclient_19_3 oracle-instantclient
elif [ "$OS" = "CentOS Linux" ]; then
  doas yum localinstall -y oracle-instantclient19.3-basic-19.3.0.0.0-1.x86_64.rpm
  doas yum localinstall -y oracle-instantclient19.3-devel-19.3.0.0.0-1.x86_64.rpm
  doas yum localinstall -y oracle-instantclient19.3-precomp-19.3.0.0.0-1.x86_64.rpm
  doas yum localinstall -y oracle-instantclient19.3-sqlplus-19.3.0.0.0-1.x86_64.rpm
elif [ "$OS" = "Fedora Linux" ]; then
  doas yum localinstall -y oracle-instantclient19.3-basic-19.3.0.0.0-1.x86_64.rpm
  doas yum localinstall -y oracle-instantclient19.3-devel-19.3.0.0.0-1.x86_64.rpm
  doas yum localinstall -y oracle-instantclient19.3-precomp-19.3.0.0.0-1.x86_64.rpm
  doas yum localinstall -y oracle-instantclient19.3-sqlplus-19.3.0.0.0-1.x86_64.rpm
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  doas pacman --noconfirm --needed -S fakeroot
  doas pacman --noconfirm --needed -S rpm
  sudo rpm -i --nodeps "$HOME/tmp/oracle-instantclient19.3-basic-19.3.0.0.0-1.x86_64.rpm"
  sudo rpm -i --nodeps "$HOME/tmp/oracle-instantclient19.3-devel-19.3.0.0.0-1.x86_64.rpm"
  sudo rpm -i --nodeps "$HOME/tmp/oracle-instantclient19.3-precomp-19.3.0.0.0-1.x86_64.rpm"
  sudo rpm -i --nodeps "$HOME/tmp/oracle-instantclient19.3-sqlplus-19.3.0.0.0-1.x86_64.rpm"
  # if [ ! -f "instantclient-sqlplus-linux.x64-19.3.0.0.0dbru.zip" ]; then
  #   scp pi@pi:/home/pi/instantclient-sqlplus-linux.x64-19.3.0.0.0dbru.zip .
  # fi

  # if [ ! -f "instantclient-basic-linux.x64-19.3.0.0.0dbru.zip" ]; then
  #   scp pi@pi:/home/pi/instantclient-basic-linux.x64-19.3.0.0.0dbru.zip .
  # fi
  # cd $HOME/projects
  # git clone https://aur.archlinux.org/oracle-instantclient-basic.git
  # git clone https://aur.archlinux.org/oracle-instantclient-sqlplus.git
  # mv -v $HOME/instantclient-sqlplus-linux.x64-19.3.0.0.0dbru.zip oracle-instantclient-sqlplus/
  # mv -v $HOME/instantclient-basic-linux.x64-19.3.0.0.0dbru.zip oracle-instantclient-basic/
  # cd oracle-instantclient-basic/
  # makepkg -si
  # cd ..
  # cd oracle-instantclient-sqlplus/
  # makepkg -si
  # cd $HOME
elif [ "$OS" = "Gentoo" ]; then
  sudo rpm -i --nodeps "$HOME/tmp/oracle-instantclient19.3-basic-19.3.0.0.0-1.x86_64.rpm"
  sudo rpm -i --nodeps "$HOME/tmp/oracle-instantclient19.3-devel-19.3.0.0.0-1.x86_64.rpm"
  sudo rpm -i --nodeps "$HOME/tmp/oracle-instantclient19.3-precomp-19.3.0.0.0-1.x86_64.rpm"
  sudo rpm -i --nodeps "$HOME/tmp/oracle-instantclient19.3-sqlplus-19.3.0.0.0-1.x86_64.rpm"
else
  echo "$OS is not yet implemented."
  exit 1
fi

if ! command -v sqlplus; then
  echo "sqlplus did not install."
fi

exit 0

# vim: set ft=sh:
