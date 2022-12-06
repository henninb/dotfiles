#!/bin/sh

if [ "$OS" = "Gentoo" ]; then
  echo gentoo
elif [ "$OS" = "Raspbian GNU/Linux" ]; then
  echo raspi
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  # export CFLAGS='-std=c99'
  # export CC='gcc -std=c99'
  # export CC=gcc
  echo "$CC"
elif [ "$OS" = "FreeBSD" ]; then
  echo freebsd
elif [ "$OS" = "Ubuntu" ]; then
  echo ubuntu
  sudo apt install -y libharfbuzz-dev
elif [ "$OS" = "Fedora Linux" ]; then
  echo fedora
elif [ "$OS" = "Linux Mint" ]; then
  echo mint
elif [ "$OS" = "void" ]; then
  sudo xbps-install -y libX11-devel
  sudo xbps-install -y libXft-devel
elif [ "$OS" = "Solus" ]; then
  echo solus
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  echo archlinux
else
  echo "$OS is not yet implemented."
  exit 1
fi

# mkdir -p "$HOME/projects/git.suckless.org"
# cd "$HOME/projects/git.suckless.org" || exit
# rm -rf st-original
# git clone https://git.suckless.org/st
# cd st || exit

# if ! make CC=gcc ; then
#   echo "make failed."
#   exit 1
# fi
# mv -v st "$HOME/.local/bin/st-original"

# tic -sx st.info
# cd "$HOME" || exit


# mkdir -p "$HOME/projects/github.com/Tharre"
# cd "$HOME/projects/github.com/Tharre" || exit
# rm -rf st-transparency
# git clone git@github.com:Tharre/st-transparency.git
# cd st-transparency || exit
# if ! make CC=gcc; then
#   echo "make failed."
#   exit 1
# fi
# mv -v st "$HOME/.local/bin/st-transparency"
# cd "$HOME" || exit

# mkdir -p "$HOME/projects/github.com/LukeSmithxyz"
# cd "$HOME/projects/github.com/LukeSmithxyz" || exit
# rm -rf st
# git clone git@github.com:LukeSmithxyz/st.git
# cd st || exit
# if ! make CC=gcc; then
#   echo "make failed."
#   exit 1
# fi
# cp -v st "$HOME/.local/bin/st"
# mv -v st "$HOME/.local/bin/st-luke"
# cd "$HOME" || exit

# mkdir -p "$HOME/projects/github.com/BrodieRobertson"
# cd "$HOME/projects/github.com/BrodieRobertson" || exit
# rm -rf st
# git clone git@github.com:BrodieRobertson/st.git
# cd st || exit
# if ! make CC=gcc; then
#   echo "make failed."
#   exit 1
# fi
# mv -v st "$HOME/.local/bin/st-brodie"
# cd "$HOME" || exit

# mkdir -p "$HOME/projects/gitlab.com/dwt1"
# cd "$HOME/projects/gitlab.com/dwt1" || exit
# rm -rf st-distrotube
# git clone git@gitlab.com:dwt1/st-distrotube.git
# cd st-distrotube || exit
# if ! make CC=gcc; then
#   echo "make failed."
#   exit 1
# fi
# mv -v st "$HOME/.local/bin/st-distrotube"
# cd "$HOME" || exit

mkdir -p "$HOME/projects/github.com/henninb"
cd "$HOME/projects/github.com/henninb" || exit
rm -rf st
git clone git@github.com:henninb/st.git
cd st || exit
if ! make CC=gcc; then
  echo "make failed."
  exit 1
fi
sudo mv -v st /usr/local/bin
cd "$HOME" || exit

exit 0

# vim: set ft=sh:
