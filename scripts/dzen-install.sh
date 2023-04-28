#!/bin/sh

cat > "$HOME/tmp/config.mk" <<'EOF'
VERSION = 0.9.5-svn

# DPKG build flags:
CPPFLAGS:=$(shell dpkg-buildflags --get CPPFLAGS)
CFLAGS:=$(shell dpkg-buildflags --get CFLAGS)
CXXFLAGS:=$(shell dpkg-buildflags --get CXXFLAGS)
LDFLAGS:=$(shell dpkg-buildflags --get LDFLAGS)
CFLAGS+=$(CPPFLAGS)

# paths
PREFIX = /usr
MANPREFIX = ${PREFIX}/share/man

X11INC = /usr/X11R6/include
X11LIB = /usr/X11R6/lib
INCS = -I. -I/usr/include -I${X11INC}

## Option 7: With Xinerama and XPM and XFT
LIBS += -L/usr/lib -lc -L${X11LIB} -lX11 -lXinerama -lXpm `pkg-config --libs xft`
CFLAGS += -Wall -Os ${INCS} -DVERSION=\"${VERSION}\" -DDZEN_XINERAMA -DDZEN_XPM -DDZEN_XFT `pkg-config --cflags xft`

LDFLAGS += ${LIBS}

CC = gcc
LD = ${CC}
EOF

# export DZEN_XINERAMA
# export DZEN_XPM
# export DZEN_XFT
#export CFLAGS="-DDZEN_XINERAMA -DDZEN_XPM -DDZEN_XFT"
#
pkg-config --cflags freetype2
pkg-config --cflags xft

# if command -v zypper; then
#   sudo zypper install -y libXinerama-devel
#   sudo zypper install -y libXpm-devel
#   sudo zypper install -y libXft-devel
#   sudo zypper install -y freetype-devel
# fi

mkdir -p "$HOME/projects/github.com/minos-org"
cd "$HOME/projects/github.com/minos-org" || exit
git clone https://github.com/minos-org/dzen2.git
cd "$HOME/projects/github.com/minos-org/dzen2" || exit
cp "$HOME/tmp/config.mk" .
make clean
# make CFLAGS='-Wall -Os -DVERSION=\"${VERSION}\" -DDZEN_XINERAMA -DDZEN_XPM -DDZEN_XFT -I/usr/include/freetype2'
make
./dzen2 -v
ls -l dzen2
# sudo make install

echo
echo
echo

mkdir -p "$HOME/projects/github.com/robm"
cd "$HOME/projects/github.com/robm" || exit
git clone https://github.com/robm/dzen.git
cd "$HOME/projects/github.com/robm/dzen" || exit
cp "$HOME/tmp/config.mk" .
# sudo make -DDZEN_XINERAMA -DDZEN_XPM -DDZEN_XFT clean install
make clean
# make CFLAGS='-DDZEN_XINERAMA -DDZEN_XPM -DDZEN_XFT'
make
./dzen2 -v
ls -l dzen2
# sudo make install

exit 0
# vim: set ft=sh:
