#!/bin/sh


if [ "$OS" = "Gentoo" ]; then
  echo
elif [ "$OS" = "Raspbian GNU/Linux" ]; then
  echo
elif [ "$OS" = "FreeBSD" ]; then
  echo
elif [ "$OS" = "Ubuntu" ]; then
  echo
elif [ "$OS" = "Fedora" ]; then
  echo
elif [ "$OS" = "Linux Mint" ]; then
  echo
elif [ "$OS" = "void" ]; then
  echo
elif [ "$OS" = "Solus" ]; then
  echo
elif [ "$OS" = "Arch Linux" ]; then
  echo
else
  echo "$OS is not yet implemented."
  exit 1
fi

cd "$HOME/projects" || exit
git clone https://git.suckless.org/st
cd st || exit
git pull origin master
if ! sudo make clean install ; then
  echo "make failed."
  exit 1
fi

tic -sx st.info
cd "$HOME" || exit

cd "$HOME/projects" || exit
git clone git@github.com:Tharre/st-transparency.git
cd st-transparency || exit
if ! make ; then
  echo "make failed."
  exit 1
fi
mv st "$HOME/.local/bin/st-transparency"
cd "$HOME" || exit

exit 0
