#!/bin/sh

VER=$(curl -s https://irssi.org/download/ | grep -o 'irssi-[0-9.]\+[0-9].tar.gz' | head -1 | sed 's/.tar.gz//' | sed 's/irssi-//')
echo gpg --keyserver pgp.mit.edu --recv-keys '7EE6 5E30 82A5 FB06 AC7C 368D 00CC B587 DDBE F0E1'
echo gpg --verify "irssi-${VER}.tar.gz.asc"

ACTUAL_VER=$(irssi --version | grep -o 'irssi [0-9.]\+[0-9]' | sed 's/irssi //')

if [ "$ACTUAL_VER" = "$VER" ]; then
  echo "already at the latest version $VER."
  exit 0
fi

if [ "$OS" = "FreeBSD" ]; then
  doas pkg install gtk3 gmake intltool pkgconf automake pcre2 libtool gtk-doc
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  doas zypper install -y ncurses-devel
elif [ "$OS" = "Void" ]; then
  doas xbps-install -Sy ncurses-devel
elif [ "$OS" = "Solus" ]; then
  doas eopkg install -y ncurses-devel
elif [ "$OS" = "Darwin" ]; then
  brew install wget
elif [ "$OS" = "CentOS Linux" ]; then
  if [ "$OS_VER" = "8" ]; then
    echo centos8
    doas dnf install -y glib2-devel
    doas dnf install -y libperl-devel
    doas dnf install -y automake
    doas dnf install -y gtk3
    doas dnf install -y openssl-devel
  else
    echo centos7
    doas yum install -y glib2-devel
    doas yum install -y libperl-devel
    doas yum install -y automake
    doas yum install -y gtk3
    doas yum install -y openssl-devel
  fi
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  doas apt install -y libgtk-3-dev pkg-config autoconf libglib2.0-dev gtk-doc-tools libpcre2-dev libgirepository1.0-dev gperf libvte-2.91-dev libvte-dev valac unzip intltool
  doas apt install -y libperl-dev libssl-dev libncurses-dev
else
  echo "$OS is not yet implemented."
  exit 1
fi

SERVERNAME=freenodelinux
echo openssl req -x509 -new -newkey rsa:4096 -sha256 -days 1000 -nodes -out freenode.pem -keyout freenode.pem
openssl req -x509 -new -newkey rsa:4096 -sha256 -days 1000 -nodes -out freenode.pem -keyout freenode.pem -subj "/C=US/ST=Texas/L=Denton/O=Brian LLC/OU=$SERVERNAME/CN=$SERVERNAME"

echo list cert hash
openssl x509 -in freenode.pem -outform der | sha1sum -b | cut -d' ' -f1

mkdir -p ~/.irssi/certs
mv -v freenode.pem ~/.irssi/certs
sudo mkdir -p /usr/local/lib/irssi/modules/

mkdir -p "$HOME/projects/github.com/irssi"
cd "$HOME/projects/github.com/irssi" || exit

if [ ! -f "irssi-${VER}.tar.gz" ]; then
  rm -rf irssi-*.tar.gz
  wget "https://github.com/irssi/irssi/releases/download/${VER}/irssi-${VER}.tar.gz"
fi
tar xvzf "irssi-${VER}.tar.gz"


git clone git@github.com:irssi/irssi
cd "irssi-${VER}" || exit
#sh autogen.sh
./configure
make
make install_local
doas make install

exit 0

# vim: set ft=sh:
