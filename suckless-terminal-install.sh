#!/bin/sh

if [ "$OS" = "Gentoo" ]; then
  echo
elif [ "$OS" = "Raspbian GNU/Linux" ]; then
  echo
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  # export CFLAGS='-std=c99'
  # export CC='gcc -std=c99'
  # export CC=gcc
  echo "$CC"
elif [ "$OS" = "FreeBSD" ]; then
  echo
elif [ "$OS" = "Ubuntu" ]; then
  echo
elif [ "$OS" = "Fedora" ]; then
  echo
elif [ "$OS" = "Linux Mint" ]; then
  echo
elif [ "$OS" = "void" ]; then
  sudo xbps-install -y libX11-devel
  sudo xbps-install -y libXft-devel
elif [ "$OS" = "Solus" ]; then
  echo
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  echo
else
  echo "$OS is not yet implemented."
  exit 1
fi

mkdir "$HOME/projects/git.suckless.org"
cd "$HOME/projects/git.suckless.org" || exit
rm -rf st-original
git clone https://git.suckless.org/st st-original
cd st-original || exit

if ! make CC=gcc ; then
  echo "make failed."
  exit 1
fi
mv -v st "$HOME/.local/bin/st-original"

# tic -sx st.info
cd "$HOME" || exit


mkdir "$HOME/projects/github.com/Tharre"
cd "$HOME/projects/github.com/Tharre" || exit
rm -rf st-transparency
git clone git@github.com:Tharre/st-transparency.git
cd st-transparency || exit
if ! make CC=gcc; then
  echo "make failed."
  exit 1
fi
mv -v st "$HOME/.local/bin/st-transparency"
cd "$HOME" || exit

mkdir "$HOME/projects/github.com/LukeSmithxyz"
cd "$HOME/projects/github.com/LukeSmithxyz" || exit
rm -rf st-luke
git clone git@github.com:LukeSmithxyz/st.git st-luke
cd st-luke || exit
if ! make CC=gcc; then
  echo "make failed."
  exit 1
fi
mv -v st "$HOME/.local/bin/st-luke"
cd "$HOME" || exit

mkdir "$HOME/projects/github.com/BrodieRobertson"
cd "$HOME/projects/github.com/BrodieRobertson" || exit
rm -rf st-brodie
git clone git@github.com:BrodieRobertson/st.git st-brodie
cd st-brodie || exit
if ! make CC=gcc; then
  echo "make failed."
  exit 1
fi
mv -v st "$HOME/.local/bin/st-brodie"
cd "$HOME" || exit

mkdir "$HOME/projects/gitlab.com/dwt1"
cd "$HOME/projects/gitlab.com/dwt1" || exit
rm -rf st-distrotube
git clone git@gitlab.com:dwt1/st-distrotube.git st-distrotube
cd st-distrotube || exit
if ! make CC=gcc; then
  echo "make failed."
  exit 1
fi
mv -v st "$HOME/.local/bin/st-distrotube"
cd "$HOME" || exit

mkdir "$HOME/projects/github.com/BitExplorer"
cd "$HOME/projects/github.com/BitExplorer" || exit
rm -rf st
git clone git@github.com:BitExplorer/st.git
cd st || exit
if ! make CC=gcc; then
  echo "make failed."
  exit 1
fi
sudo mv -v st /usr/local/bin
cd "$HOME" || exit

exit 0
