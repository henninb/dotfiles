#!/usr/bin/env sh

curl -sSL https://get.haskellstack.org/ | sh
stack update

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  #sudo apt remove -y lightdm
  sudo apt remove -y gdm
  sudo apt remove -y lxdm
  sudo apt install -y libxss-dev
  sudo apt install -y xscreensaver
  sudo apt install -y feh
  sudo apt install -y w3m
  sudo apt install -y dzen2
  sudo apt install -y cmake
  sudo apt install -y libxpm-dev
  sudo apt install -y xdotool
  sudo apt install -y xdo
  sudo apt install -y sxhkd
  sudo apt install -y dunst
  sudo apt install -y wmname
  sudo apt install -y blueberry
  #sudo apt install -y icu-devtools libicu-dev
elif [ "$OS" = "Arch Linux" ]; then
  sudo pacman -Rsnc lightdm
  sudo pacman -Rsnc gdm
  sudo pacman -Rsnc lxdm
  sudo pacman --noconfirm --needed -S xscreensaver
  sudo pacman --noconfirm --needed -S feh
  sudo pacman --noconfirm --needed -S xdotool
  sudo pacman --noconfirm --needed -S cmake
  sudo pacman --noconfirm --needed -S w3m
  sudo pacman --noconfirm --needed -S dzen2
  sudo pacman --noconfirm --needed -S xdo
  sudo pacman --noconfirm --needed -S sxhkd
  sudo pacman --noconfirm --needed -S dunst
  sudo pacman --noconfirm --needed -S wmname
  sudo pacman --noconfirm --needed -S pulseaudio
  sudo pacman --noconfirm --needed -S alsa-utils
  # yay install yabar
  # yay install lemonbar
  # cd "$HOME/projects" || exit
  # git clone https://aur.archlinux.org/yabar-git.git yabar-aur
  # cd yabar-aur || exit
  # makepkg -si
  # cd "$HOME/projects" || exit
  # git clone https://aur.archlinux.org/lemonbar-git.git lemonbar-aur
  # cd lemonbar-aur || exit
  # makepkg -si
elif [ "$OS" = "Manjaro Linux" ]; then
  sudo pacman -Rsnc lightdm
  sudo pacman -Rsnc gdm
  sudo pacman -Rsnc lxdm
  sudo pacman --noconfirm --needed -S xscreensaver
  sudo pacman --noconfirm --needed -S feh
  sudo pacman --noconfirm --needed -S xdotool
  sudo pacman --noconfirm --needed -S cmake
  sudo pacman --noconfirm --needed -S w3m
  sudo pacman --noconfirm --needed -S dzen2
  sudo pacman --noconfirm --needed -S xdo
  sudo pacman --noconfirm --needed -S sxhkd
  sudo pacman --noconfirm --needed -S dunst
  sudo pacman --noconfirm --needed -S wmname
  sudo pacman --noconfirm --needed -S pulseaudio
  sudo pacman --noconfirm --needed -S alsa-utils
elif [ "$OS" = "FreeBSD" ]; then
  ln -sfn "$(find /usr/local/bin/ -type f -name "perl5*" | tail -1)" "$HOME/.local/bin/perl"
  sudo pkg install -y neofetch
  sudo pkg install -y w3m
  sudo pkg install -y xz
  sudo pkg install -y xscreensaver
  sudo pkg install -y feh
  sudo pkg install -y xdotool
  sudo pkg install -y xdo
  sudo pkg install -y perl5
  sudo pkg install -y wmname
elif [ "$OS" = "void" ]; then
  sudo ln -s /usr/lib/libncursesw.so.6 /usr/lib/libtinfo.so.6
  VOID_PKGS="xscreensaver feh xdotool w3m neofetch dzen2 xz make gcc gmp-devel dunst wmname libXScrnSaver-devel alsa-lib-devel emacs-gtk2 alsa-utils pulseaudio"
  FAILURES=""
  for i in $(echo $VOID_PKGS); do
    if ! sudo xbps-install -y "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo "Failures: $FAILURE"
elif [ "$OS" = "Solus" ]; then
  SOLUS_PKGS="feh xdotool w3m xz make gcc gmp-devel dunst alsa-lib-devel alsa-utils pulseaudio libxscrnsaver-devel libxrandr-devel libxft-devel xscreensaver wmname xdo polybar"
  FAILURES=""
  for i in $(echo $SOLUS_PKGS); do
    if ! sudo eopkg install -y "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo "Failures: $FAILURE"
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge --unmerge dzen
  GENTOO_PKGS="xscreensaver feh xdotool w3m dunst wmname xdo"
  FAILURES=""
  for i in $(echo $GENTOO_PKGS); do
    if ! sudo emerge --update --newuse "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo "Failures: $FAILURE"
elif [ "$OS" = "Fedora" ]; then
  sudo dnf remove -y lightdm
  sudo dnf remove -y gdm
  sudo dnf remove -y lxdm
  sudo dnf install -y alsa-lib-devel
  sudo dnf install -y libXScrnSaver-devel
  sudo dnf install -y feh
  sudo dnf install -y ranger
  sudo dnf install -y neofetch
  sudo dnf install -y w3m
  sudo dnf install -y xscreensaver
  sudo dnf install -y dzen2
  sudo dnf install -y dunst
  sudo dnf install -y wmname
  sudo dnf install -y dbus-x11
  echo iwlib missing
  cd "$HOME/projects" || exit
  git clone git@github.com:baskerville/xdo.git
  cd xdo || exit
  sudo make install
elif [ "$OS" = "CentOS Linux" ]; then
  if [ "$OS_VER" = "8" ]; then
    echo centos8
    sudo dnf remove -y lightdm
    sudo dnf remove -y gdm
    sudo dnf remove -y lxdm
    sudo dnf install -y alsa-lib-devel
    sudo dnf install -y libXScrnSaver-devel
    sudo dnf install -y feh
    sudo dnf install -y ranger
    sudo dnf install -y neofetch
    sudo dnf install -y w3m
    sudo dnf install -y xscreensaver
    sudo dnf install -y dzen2
  else
    echo centos7
    sudo yum remove -y lightdm
    sudo yum remove -y gdm
    sudo yum remove -y lxdm
    sudo yum install -y alsa-lib-devel
    sudo yum install -y libXScrnSaver-devel
    sudo yum install -y feh
    sudo yum install -y ranger
    sudo yum install -y neofetch
    sudo yum install -y w3m
    sudo yum install -y xscreensaver
    sudo yum install -y dzen2
  fi
else
  echo "$OS is not yet implemented."
  exit 1
fi

if ! stack install ghc ; then
  echo failed ghc.
  exit 1
fi

failures=""

if ! stack install hindent ; then
  echo failed hindent.
  failures="$failures hindent"
#   exit 1
fi

if ! stack install hlint. ; then
  echo failed hlint.
  failures="$failures hlint"
  #exit 1
fi

if ! stack install xmonad-contrib ; then
  echo failed xmonad-contrib.
  failures="$failures xmonad-contrib"
#  exit 1
fi

if ! stack install xmonad-extras ; then
  echo failed xmonad-extras.
  failures="$failures xmonad-extras"
 # exit 1
fi

if ! stack install dbus ; then
  echo failed dbus.
  failures="$failures dbus"
  #exit 1
fi

echo "seems to have the the flag with_xft. how to confirm?"
cd "$HOME/projects" || exit
git clone git@github.com:jaor/xmobar.git
cd xmobar || exit
git pull origin master
#stack build
stack build --flag xmobar:-with_xft --flag xmobar:-with_utf8 --flag xmobar:-with_threaded --flag xmobar:-with_dbus --flag xmobar:-with_mpd --flag xmobar:-with_mpris --flag xmobar:-with_inotify --flag xmobar:-with_alsa --flag xmobar:-with_datezone --flag xmobar:-with_xpm --flag xmobar:-with_uvmeter --flag xmobar:-with_weather
stack install
$HOME/.local/bin/xmonad --version

if [ "$OS" = "Gentoo" ] || [ "$OS" = "FreeBSD" ]; then
  cd "$HOME/projects" || exit
  git clone https://github.com/minos-org/dzen2.git
  cd dzen2 || exit
  sudo make clean install
  cd - || exit
fi

go get github.com/godbus/dbus
cd "$HOME/projects" || exit
git clone git@github.com:xintron/xmonad-log.git
cd xmonad-log
go build
mv xmonad-log "$HOME/.local/bin"
cd -

cd "$HOME/projects"
git clone git@github.com:troydm/xmonad-dbus.git
cd xmonad-dbus
stack build
stack install
cd -

stack exec ghc-pkg list
echo stack exec ghc-pkg unregister mypackage
echo stack exec ghc-pkg recache
echo stack exec ghc-pkg check

echo rofi
echo nitrogen
echo compton
echo lf
echo alacritty

echo "failures = $failures"

exit 0

# cd $HOME/projects
# git clone git@github.com:xmonad/xmonad.git
# cd xmonad
# git checkout tags/v0.13
# stack setup
# stack build
# stack install
# $HOME/.local/bin/xmonad --version

# cd $HOME/projects
# git clone git@github.com:jaor/xmobar.git
# cd xmobar
# git checkout tags/v0.31

# echo exec xmonad
# xmonad --recompile
# echo pid of systemd
# pidof systemd

# echo https://brianbuccola.com/how-to-install-xmonad-and-xmobar-via-stack/
# ghc-pkg list

# exit 0
