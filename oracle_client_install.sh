#!/bin/sh

RASPI_IP=$(nmap -sP --host-timeout 10 192.168.100.0/24 | grep raspb | grep -o '[0-9.]\+[0-9]')

if [ \( "$OS" = "Linux Mint" \) -o \(  "$OS" = "Ubuntu" \) ]; then
  sudo apt install -y alien fakeroot
elif [ "$OS" = "Fedora" ]; then
  sudo dnf install -y libnsl
else
  echo $OS is not yet implemented.
  exit 1
fi

#export LD_LIBRARY_PATH=/opt/oracle/instantclient:$LD_LIBRARY_PATH

echo /usr/lib/oracle/19.3/client64/lib/libsqlplus.so
if [ ! -f "oracle-instantclient19.3-basic-19.3.0.0.0-1.x86_64.rpm" ]; then
  scp pi@$RASPI_IP:/home/pi/downloads/oracle-instantclient19.3-basic-19.3.0.0.0-1.x86_64.rpm .
  if [ $? -ne 0 ]; then
    wget https://download.oracle.com/otn_software/linux/instantclient/193000/oracle-instantclient19.3-basic-19.3.0.0.0-1.x86_64.rpm
    scp oracle-instantclient19.3-basic-19.3.0.0.0-1.x86_64.rpm pi@$RASPI_IP:/home/pi/downloads/
  fi
fi

if [ ! -f "oracle-instantclient19.3-devel-19.3.0.0.0-1.x86_64.rpm" ]; then
  scp pi@$RASPI_IP:/home/pi/downloads/oracle-instantclient19.3-devel-19.3.0.0.0-1.x86_64.rpm .
  if [ $? -ne 0 ]; then
    wget https://download.oracle.com/otn_software/linux/instantclient/193000/oracle-instantclient19.3-devel-19.3.0.0.0-1.x86_64.rpm
    scp oracle-instantclient19.3-devel-19.3.0.0.0-1.x86_64.rpm pi@$RASPI_IP:/home/pi/downloads/
  fi
fi

if [ ! -f "oracle-instantclient19.3-precomp-19.3.0.0.0-1.x86_64.rpm" ]; then
  scp pi@$RASPI_IP:/home/pi/downloads/oracle-instantclient19.3-precomp-19.3.0.0.0-1.x86_64.rpm .
  if [ $? -ne 0 ]; then
    echo wget https://www.oracle.com/database/technologies/instant-client/precompiler-112010-downloads.html
  fi
fi

if [ ! -f "oracle-instantclient19.3-sqlplus-19.3.0.0.0-1.x86_64.rpm" ]; then
  scp pi@$RASPI_IP:/home/pi/downloads/oracle-instantclient19.3-sqlplus-19.3.0.0.0-1.x86_64.rpm .
  if [ $? -ne 0 ]; then
    wget https://download.oracle.com/otn_software/linux/instantclient/193000/oracle-instantclient19.3-sqlplus-19.3.0.0.0-1.x86_64.rpm
     scp oracle-instantclient19.3-sqlplus-19.3.0.0.0-1.x86_64.rpm pi@$RASPI_IP:/home/pi/downloads/
  fi
fi

if [ \( "$OS" = "Linux Mint" \) -o \(  "$OS" = "Ubuntu" \) ]; then
  fakeroot alien oracle-instantclient19.3-basic-19.3.0.0.0-1.x86_64.rpm
  fakeroot alien oracle-instantclient19.3-devel-19.3.0.0.0-1.x86_64.rpm
  fakeroot alien oracle-instantclient19.3-precomp-19.3.0.0.0-1.x86_64.rpm
  fakeroot alien oracle-instantclient19.3-sqlplus-19.3.0.0.0-1.x86_64.rpm
  sudo dpkg -i oracle-instantclient19.3-basic_19.3.0.0.0-2_amd64.deb
  sudo dpkg -i oracle-instantclient19.3-devel_19.3.0.0.0-2_amd64.deb
  sudo dpkg -i oracle-instantclient19.3-precomp_19.3.0.0.0-2_amd64.deb
  sudo dpkg -i oracle-instantclient19.3-sqlplus_19.3.0.0.0-2_amd64.deb
elif [ "$OS" = "CentOS Linux" ]; then
  sudo yum localinstall -y oracle-instantclient19.3-basic-19.3.0.0.0-1.x86_64.rpm
  sudo yum localinstall -y oracle-instantclient19.3-devel-19.3.0.0.0-1.x86_64.rpm
  sudo yum localinstall -y oracle-instantclient19.3-precomp-19.3.0.0.0-1.x86_64.rpm
  sudo yum localinstall -y oracle-instantclient19.3-sqlplus-19.3.0.0.0-1.x86_64.rpm
elif [ "$OS" = "Fedora" ]; then
  sudo yum localinstall -y oracle-instantclient19.3-basic-19.3.0.0.0-1.x86_64.rpm
  sudo yum localinstall -y oracle-instantclient19.3-devel-19.3.0.0.0-1.x86_64.rpm
  sudo yum localinstall -y oracle-instantclient19.3-precomp-19.3.0.0.0-1.x86_64.rpm
  sudo yum localinstall -y oracle-instantclient19.3-sqlplus-19.3.0.0.0-1.x86_64.rpm
elif [ "$OS" = "Arch Linux" ]; then
  sudo pacman -S fakeroot
  if [ ! -f "instantclient-sqlplus-linux.x64-19.3.0.0.0dbru.zip" ]; then
    scp pi@$RASPI_IP:/home/pi/instantclient-sqlplus-linux.x64-19.3.0.0.0dbru.zip .
  fi

  if [ ! -f "instantclient-basic-linux.x64-19.3.0.0.0dbru.zip" ]; then
    scp pi@$RASPI_IP:/home/pi/instantclient-basic-linux.x64-19.3.0.0.0dbru.zip .
  fi
  cd $HOME/projects
  git clone https://aur.archlinux.org/oracle-instantclient-basic.git
  git clone https://aur.archlinux.org/oracle-instantclient-sqlplus.git
  mv -v $HOME/instantclient-sqlplus-linux.x64-19.3.0.0.0dbru.zip oracle-instantclient-sqlplus/
  mv -v $HOME/instantclient-basic-linux.x64-19.3.0.0.0dbru.zip oracle-instantclient-basic/
  cd oracle-instantclient-basic/
  makepkg -si
  cd ..
  cd oracle-instantclient-sqlplus/
  makepkg -si
  cd $HOME
elif [ "$OS" = "Gentoo" ]; then
  sudo rpm -i --nodeps oracle-instantclient19.3-basic-19.3.0.0.0-1.x86_64.rpm
  sudo rpm -i --nodeps oracle-instantclient19.3-devel-19.3.0.0.0-1.x86_64.rpm
  sudo rpm -i --nodeps oracle-instantclient19.3-precomp-19.3.0.0.0-1.x86_64.rpm
  sudo rpm -i --nodeps oracle-instantclient19.3-sqlplus-19.3.0.0.0-1.x86_64.rpm
else
  echo $OS is not yet implemented.
  exit 1
fi

#rm -rf oracle-instantclient19.3-*

exit 0
