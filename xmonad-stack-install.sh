#!/usr/bin/env sh

curl -sSL https://get.haskellstack.org/ | sh
stack update

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt install -y libxss-dev
  sudo apt install -y xscreensaver
  sudo apt install -y feh
  sudo apt install -y w3m
  sudo apt install -y lxpolkit
  sudo apt install -y cmake
  sudo apt install -y libxpm-dev
  sudo apt install -y xdotool
  sudo apt install -y xclip
  sudo apt install -y redshift
  sudo apt install -y xdo
  sudo apt install -y sxhkd
  sudo apt install -y volumeicon-alsa
  sudo apt install -y clipmenu
  sudo apt install -y lxappearance
  sudo apt install -y dunst
  sudo apt install -y copyq
  sudo apt install -y mpc
  sudo apt install -y mpd
  sudo apt install -y vifm
  sudo apt install -y flameshot
  sudo apt install -y wmname
  sudo apt install -y blueberry
  sudo apt install -y libbsd-dev
  sudo apt install -y font-awesome-4
  #sudo apt install -y icu-devtools libicu-dev
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  sudo zypper install -y libxss-devel
  sudo zypper install -y xscreensaver
  sudo zypper install -y feh
  sudo zypper install -y w3m
  # sudo zypper install -y dzen2
  sudo zypper install -y cmake
  sudo zypper install -y libxpm-devel
  sudo zypper install -y xdotool
  sudo zypper install -y xclip
  sudo zypper install -y xdo
  sudo zypper install -y sxhkd
  sudo zypper install -y dunst
  sudo zypper install -y mpc
  sudo zypper install -y redshift
  sudo zypper install -y mpd
  sudo zypper install -y volumeicon
  sudo zypper install -y clipmenu
  sudo zypper install -y copyq
  sudo zypper install -y vifm
  sudo zypper install -y flameshot
  sudo zypper install -y wmname
  sudo zypper install -y lxappearance
  sudo zypper install -y blueberry
  sudo zypper install -y gmp-devel
  sudo zypper install -y alsa-lib-devel
  sudo zypper install -y libxrandr-devel
  sudo zypper install -y libxft-devel
  sudo zypper install -y libXss-devel
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ]; then
  sudo pacman --noconfirm --needed -S xscreensaver
  sudo pacman --noconfirm --needed -S feh
  sudo pacman --noconfirm --needed -S xdotool
  sudo pacman --noconfirm --needed -S cmake
  sudo pacman --noconfirm --needed -S w3m
  sudo pacman --noconfirm --needed -S lxappearance
  sudo pacman --noconfirm --needed -S xdo
  sudo pacman --noconfirm --needed -S xclip
  sudo pacman --noconfirm --needed -S sxhkd
  sudo pacman --noconfirm --needed -S dunst
  sudo pacman --noconfirm --needed -S jq
  sudo pacman --noconfirm --needed -S volumeicon
  sudo pacman --noconfirm --needed -S clipmenu
  sudo pacman --noconfirm --needed -S lxsession
  sudo pacman --noconfirm --needed -S copyq
  sudo pacman --noconfirm --needed -S mpc
  sudo pacman --noconfirm --needed -S mpd
  sudo pacman --noconfirm --needed -S font-awesome-4
  sudo pacman --noconfirm --needed -S dmenu
  sudo pacman --noconfirm --needed -S flameshot
  sudo pacman --noconfirm --needed -S redshift
  sudo pacman --noconfirm --needed -S wmname
  sudo pacman --noconfirm --needed -S vifm
  sudo pacman --noconfirm --needed -S pulseaudio
  sudo pacman --noconfirm --needed -S alsa-utils
  sudo systemctl disable mpd.socket
  sudo systemctl stop mpd.socket
elif [ "$OS" = "FreeBSD" ]; then
  ln -sfn "$(find /usr/local/bin/ -type f -name "perl5*" | tail -1)" "$HOME/.local/bin/perl"
  sudo pkg install -y neofetch
  sudo pkg install -y w3m
  sudo pkg install -y xz
  sudo pkg install -y xscreensaver
  sudo pkg install -y flameshot
  sudo pkg install -y feh
  sudo pkg install -y xdotool
  sudo pkg install -y xdo
  sudo pkg install -y jq
  sudo pkg install -y perl5
  sudo pkg install -y wmname
elif [ "$OS" = "void" ]; then
  sudo ln -s /usr/lib/libncursesw.so.6 /usr/lib/libtinfo.so.6
  VOID_PKGS="xscreensaver feh xdotool w3m neofetch lxappearance volumeicon clipmenu xz make gcc gmp-devel dunst wmname libXScrnSaver-devel alsa-lib-devel emacs-gtk2 alsa-utils pulseaudio flameshot volumeicon blueman mpc mpd jq redshift vifm"
  FAILURE=""
  for i in $VOID_PKGS; do
    if ! sudo xbps-install -y "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo "Failures: $FAILURE"
elif [ "$OS" = "Solus" ]; then
  if ! sudo ln -s /usr/lib/libncursesw.so.5.9 /usr/lib/libtinfo.so.5.9; then
    echo "failed to create the link, check the script"
    echo "to address: error while loading shared libraries: libtinfo.so.5: cannot open shared object file: No such file or directory"
    exit 1
  fi
  sudo eopkg install -y gettext-devel
  cd "$HOME/projects" || exit
  git clone git@github.com:Maato/volumeicon.git
  cd volumeicon || exit
  ./autogen.sh
  ./configure
  make
  sudo make install
  cd "$HOME" || exit
  SOLUS_PKGS="feh xdotool w3m xz make gcc gmp-devel dunst alsa-lib-devel alsa-utils pulseaudio libxscrnsaver-devel libxrandr-devel libxft-devel xscreensaver wmname xdo libxpm-devel flameshot xappearance volumeicon blueman copyq clipmenu mpd sudo eopkg install mpc-client neofetch jq redshift font-awesome-4 vifm"
  FAILURE=""
  sudo eopkg install -c system.devel
  for i in $SOLUS_PKGS; do
    if ! sudo eopkg install -y "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo "Failures: $FAILURE"
elif [ "$OS" = "Gentoo" ]; then
  sudo usermod -aG tty "$(id -un)"
  sudo usermod -aG video "$(id -un)"
  # sudo emerge --unmerge dzen
  GENTOO_PKGS="xscreensaver feh xdotool w3m dunst wmname w3m x11-misc/xclip xinit xorg-server dbus elogind flameshot xappearance volumeicon neofetch blueman copyq clipmenu media-sound/mpc mpd net-wireless/blueman redshift"
  FAILURE=""
  for i in $GENTOO_PKGS; do
    if ! sudo emerge --update --newuse "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  sudo rc-update add dbus default
  sudo rc-update add elogind default
  cd "$HOME/projects" || exit
  git clone git@github.com:baskerville/xdo.git
  cd xdo || exit
  make
  sudo make install
  echo "Failures: $FAILURE"
elif [ "$OS" = "Fedora" ]; then
  # sudo dnf remove -y lightdm
  # sudo dnf remove -y gdm
  # sudo dnf remove -y lxdm
  sudo dnf install -y alsa-lib-devel
  sudo dnf install -y libXScrnSaver-devel
  sudo dnf install -y feh
  sudo dnf install -y neofetch
  sudo dnf install -y w3m
  sudo dnf install -y xscreensaver
  sudo dnf install -y dunst
  sudo dnf install -y voluemeicon
  sudo dnf install -y wmname
  sudo dnf install -y mpc
  sudo dnf install -y mpd
  sudo dnf install -y lxsession
  sudo dnf install -y sxhkd
  sudo dnf install -y copyq
  # sudo dnf install -y clipmenu
  sudo dnf install -y flameshot
  sudo dnf install -y blueman
  sudo dnf install -y flameshot
  sudo dnf install -y dbus-x11
  echo iwlib missing
  cd "$HOME/projects" || exit
  git clone git@github.com:baskerville/xdo.git
  cd xdo || exit
  sudo make install
elif [ "$OS" = "CentOS Linux" ]; then
  if [ "$OS_VER" = "8" ]; then
    echo centos8
    # sudo dnf remove -y lightdm
    # sudo dnf remove -y gdm
    # sudo dnf remove -y lxdm
    sudo dnf install -y alsa-lib-devel
    sudo dnf install -y libXScrnSaver-devel
    sudo dnf install -y feh
    sudo dnf install -y ranger
    sudo dnf install -y neofetch
    sudo dnf install -y w3m
    sudo dnf install -y dunst
    sudo dnf install -y flameshot
    sudo dnf install -y xscreensaver
    # sudo dnf install -y dzen2
  else
    echo centos7
    sudo yum install -y alsa-lib-devel
    sudo yum install -y libXScrnSaver-devel
    sudo yum install -y feh
    sudo yum install -y neofetch
    sudo yum install -y w3m
    sudo yum install -y xscreensaver
    # sudo yum install -y dzen2
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
  if ! stack --resolver lts-14.22 install hindent; then
    failures="$failures hindent"
  fi
fi

if ! stack install hlint ; then
  echo failed hlint.
  failures="$failures hlint"
fi

if ! stack install xmonad-contrib ; then
  echo failed xmonad-contrib.
  failures="$failures xmonad-contrib"
fi

if ! stack install xmonad-extras ; then
  echo failed xmonad-extras.
  failures="$failures xmonad-extras"
fi

if ! stack install dbus ; then
  echo failed dbus.
  failures="$failures dbus"
fi

# echo "seems to have the the flag with_xft. how to confirm?"
# cd "$HOME/projects" || exit
# git clone git@github.com:jaor/xmobar.git
# cd xmobar || exit
# git pull origin master
# echo stack build
# stack build --flag xmobar:-with_xft --flag xmobar:-with_utf8 --flag xmobar:-with_threaded --flag xmobar:-with_dbus --flag xmobar:-with_mpd --flag xmobar:-with_mpris --flag xmobar:-with_inotify --flag xmobar:-with_alsa --flag xmobar:-with_datezone --flag xmobar:-with_xpm --flag xmobar:-with_uvmeter --flag xmobar:-with_weather
# stack install
#"$HOME/.local/bin/xmonad" --version

if [ "$OS" = "Gentoo" ] || [ "$OS" = "FreeBSD" ]; then
  cd "$HOME/projects" || exit
  git clone https://github.com/minos-org/dzen2.git
  cd dzen2 || exit
  sudo make clean install
  cd - || exit
fi

if ! go get github.com/godbus/dbus; then
  echo "failed to install go dbus."
  exit 1
fi
cd "$HOME/projects" || exit
git clone git@github.com:xintron/xmonad-log.git
cd xmonad-log || exit
go build
mv xmonad-log "$HOME/.local/bin"
cd - || exit

cd "$HOME/projects" || exit
git clone git@github.com:troydm/xmonad-dbus.git
cd xmonad-dbus || exit
stack build
stack install
cd - || exit

stack exec ghc-pkg list
echo stack exec ghc-pkg unregister mypackage
echo stack exec ghc-pkg recache
echo stack exec ghc-pkg check

echo "install failures = $failures"

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
