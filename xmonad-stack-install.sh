#!/usr/bin/env sh

# if [ ! -x "$(command -v go)" ]; then
#   echo "golang needs to be installed"
#   exit 1
# fi

if [ "${OS}" = "FreeBSD" ]; then
  sudo pkg install -y hs-stack
  cd /lib && sudo ln -s libncurses.so.9 libncursesw.so.8 && sudo ldconfig -R
  sudo pkg install -y misc/compat12x
else
  curl -sSL 'https://get.haskellstack.org' | sh
  stack update
fi

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt install -y blueberry
  sudo apt install -y clipmenu
  sudo apt install -y cmake
  sudo apt install -y conky
  sudo apt install -y copyq
  sudo apt install -y dunst
  sudo apt install -y feh
  sudo apt install -y flameshot
  sudo apt install -y font-awesome-4
  sudo apt install -y libbsd-dev
  sudo apt install -y libxpm-dev
  sudo apt install -y libxss-dev
  sudo apt install -y lxappearance
  sudo apt install -y lxpolkit
  sudo apt install -y mpc
  sudo apt install -y mpd
  sudo apt install -y mpv
  sudo apt install -y mpdris2
  sudo apt install -y numlockx
  sudo apt install -y playerctl
  sudo apt install -y redshift
  sudo apt install -y sxhkd
  sudo apt install -y sxiv
  sudo apt install -y trayer
  sudo apt install -y vifm
  sudo apt install -y vimb
  sudo apt install -y volumeicon-alsa
  sudo apt install -y w3m
  sudo apt install -y wmname
  sudo apt install -y xclip
  sudo apt install -y xdo
  sudo apt install -y xdotool
  sudo apt install -y xscreensaver
  sudo apt install -y thunar
  sudo apt install -y sxiv
  sudo apt install -y qalculate
  #sudo apt install -y icu-devtools libicu-dev
  # sudo pkg install hs-cabal-install
  sudo pkg install hs-xmonad
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  # sudo zypper install -y dzen2
  sudo zypper install -y alsa-lib-devel
  sudo zypper install -y blueberry
  sudo zypper install -y clipmenu
  sudo zypper install -y cmake
  sudo zypper install -y conky
  sudo zypper install -y copyq
  sudo zypper install -y dunst
  sudo zypper install -y feh
  sudo zypper install -y flameshot
  sudo zypper install -y gmp-devel
  sudo zypper install -y libXss-devel
  sudo zypper install -y libxft-devel
  sudo zypper install -y libxpm-devel
  sudo zypper install -y libxrandr-devel
  sudo zypper install -y libxss-devel
  sudo zypper install -y lxappearance
  sudo zypper install -y mpc
  sudo zypper install -y mpd
  sudo zypper install -y mpdris2
  sudo zypper install -y playerctl
  sudo zypper install -y redshift
  sudo zypper install -y sxhkd
  sudo zypper install -y vifm
  sudo zypper install -y volumeicon
  sudo zypper install -y w3m
  sudo zypper install -y wmname
  sudo zypper install -y xclip
  sudo zypper install -y xdo
  sudo zypper install -y xdotool
  sudo zypper install -y xscreensaver
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  sudo pacman --noconfirm --needed -S alsa-utils
  sudo pacman --noconfirm --needed -S clipmenu
  sudo pacman --noconfirm --needed -S cmake
  sudo pacman --noconfirm --needed -S conky
  sudo pacman --noconfirm --needed -S copyq
  sudo pacman --noconfirm --needed -S dmenu
  sudo pacman --noconfirm --needed -S dunst
  sudo pacman --noconfirm --needed -S dzen2
  sudo pacman --noconfirm --needed -S feh
  sudo pacman --noconfirm --needed -S flameshot
  # sudo pacman --noconfirm --needed -S font-awesome-4
  sudo pacman --noconfirm --needed -S ttf-font-awesome
  sudo pacman --noconfirm --needed -S gtk-update-icon-cache
  sudo pacman --noconfirm --needed -S jq
  sudo pacman --noconfirm --needed -S i3lock-color
  sudo pacman --noconfirm --needed -S lxappearance
  sudo pacman --noconfirm --needed -S lxsession
  sudo pacman --noconfirm --needed -S mpc
  sudo pacman --noconfirm --needed -S mpv
  sudo pacman --noconfirm --needed -S mpd
  # sudo pacman --noconfirm --needed -S mpdris2
  # sudo pacman --noconfirm --needed -S playderctl
  sudo pacman --noconfirm --needed -S pulseaudio
  sudo pacman --noconfirm --needed -S redshift
  sudo pacman --noconfirm --needed -S sxhkd
  sudo pacman --noconfirm --needed -S sxiv
  sudo pacman --noconfirm --needed -S trayer
  sudo pacman --noconfirm --needed -S thunar
  sudo pacman --noconfirm --needed -S vifm
  sudo pacman --noconfirm --needed -S vimb
  sudo pacman --noconfirm --needed -S volumeicon
  sudo pacman --noconfirm --needed -S w3m
  sudo pacman --noconfirm --needed -S wmname
  sudo pacman --noconfirm --needed -S xclip
  sudo pacman --noconfirm --needed -S xdo
  sudo pacman --noconfirm --needed -S xdotool
  sudo pacman --noconfirm --needed -S qalculate-gtk
  sudo pacman --noconfirm --needed -S xscreensaver
  sudo pacman --noconfirm --needed -S yad
  yay -S mpdris2
  sudo systemctl disable mpd.socket
  sudo systemctl stop mpd.socket
elif [ "$OS" = "FreeBSD" ]; then
  ln -sfn "$(find /usr/local/bin/ -type f -name "perl5*" | tail -1)" "$HOME/.local/bin/perl"
  sudo pkg install -y alsa-lib
  sudo pkg install -y audio/alsa-utils
  sudo pkg install -y i3lock
  sudo pkg install -y sysutils/uhidd
  sudo pkg install -y conky
  sudo pkg install -y copyq
  sudo pkg install -y dmenu
  sudo pkg install -y dunst
  sudo pkg install -y dzen2
  sudo pkg install -y feh
  sudo pkg install -y sxiv
  sudo pkg install -y flameshot
  sudo pkg install -y thunar
  sudo pkg install -y jq
  sudo pkg install -y neofetch
  sudo pkg install -y perl5
  sudo pkg install -y redshift
  sudo pkg install -y volumeicon
  sudo pkg install -y w3m
  sudo pkg install -y wmname
  sudo pkg install -y xdo
  sudo pkg install -y xdotool
  sudo pkg install -y xscreensaver
  sudo pkg install -y xorg
  sudo pkg install -y pkgconf
  sudo pkg install -y mpv
  sudo pkg install -y networkmgr
  sudo pkg install -y sxhkd
  sudo pkg install -y trayer
  sudo pkg install -y terminus-font
  sudo pkg install -y xclip
  sudo pkg install -y numlockx
  sudo pkg install -y lxappearance
  sudo pkg install -y qalculate
  sudo pkg install -y musicpd
  sudo pkg install -y musicpc
  # sudo pkg install -y libXft
  # sudo pkg install -y xz
elif [ "$OS" = "void" ]; then
  sudo ln -s /usr/lib/libncursesw.so.6 /usr/lib/libtinfo.so.6
  VOID_PKGS="xscreensaver feh xdotool w3m neofetch lxappearance volumeicon clipmenu xz make gcc gmp-devel dunst wmname libXScrnSaver-devel alsa-lib-devel emacs-gtk2 alsa-utils pulseaudio flameshot volumeicon blueman mpc mpd jq redshift conky playerctl dunst libXrandr-devel"
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

  mkdir -p d "$HOME/projects/github.com/Maato"
  cd "$HOME/projects/github.com/Maato" || exit
  git clone git@github.com:Maato/volumeicon.git
  cd volumeicon || exit
  ./autogen.sh
  ./configure
  make
  sudo make install
  cd "$HOME" || exit
  SOLUS_PKGS="feh xdotool w3m xz make gcc gmp-devel dunst alsa-lib-devel alsa-utils pulseaudio libxscrnsaver-devel libxrandr-devel libxft-devel xscreensaver wmname xdo libxpm-devel flameshot xappearance volumeicon blueman copyq clipmenu mpd sudo eopkg install mpc-client neofetch jq redshift font-awesome-4 vifm conky playerctl"
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
  GENTOO_PKGS="dzen i3lock x11-misc/xsensors qalculate-gtk hddtemp xscreensaver feh xdotool w3m dunst wmname w3m x11-misc/xclip xinit xorg-server dbus elogind flameshot xappearance volumeicon neofetch blueman copyq clipmenu media-sound/mpc mpd net-wireless/blueman redshift playerctl conky"
  FAILURE=""
  for i in $GENTOO_PKGS; do
    if ! sudo emerge --update --newuse "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  sudo rc-update add dbus default
  sudo rc-update add elogind default
  mkdir -p "$HOME/projects/github.com/baskerville"
  cd "$HOME/projects/github.com/baskerville" || exit
  git clone git@github.com:baskerville/xdo.git
  cd xdo || exit
  make
  sudo make install
  echo "Failures: $FAILURE"
elif [ "$OS" = "Fedora" ]; then
  # sudo dnf remove -y lightdm
  # sudo dnf remove -y gdm
  # sudo dnf remove -y lxdm
  # sudo dnf install -y clipmenu
  sudo dnf install -y alsa-lib-devel
  sudo dnf install -y blueman
  sudo dnf install -y conky
  sudo dnf install -y copyq
  sudo dnf install -y dbus-x11
  sudo dnf install -y dunst
  sudo dnf install -y feh
  sudo dnf install -y flameshot
  sudo dnf install -y flameshot
  sudo dnf install -y libXScrnSaver-devel
  sudo dnf install -y lxsession
  sudo dnf install -y mpc
  sudo dnf install -y mpd
  sudo dnf install -y neofetch
  sudo dnf install -y playerctl
  sudo dnf install -y sxhkd
  sudo dnf install -y voluemeicon
  sudo dnf install -y w3m
  sudo dnf install -y wmname
  sudo dnf install -y xscreensaver
  echo iwlib missing
  mkdir -p "$HOME/projects/github.com/baskerville"
  cd "$HOME/projects/github.com/baskerville" || exit
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

if ! stack install ghc; then
  echo failed ghc.
  exit 1
fi

failures=""

if ! stack install hindent; then
  if ! stack --resolver lts-14.22 install hindent; then
    failures="$failures hindent"
  fi
fi

if ! stack install hlint; then
  echo failed hlint.
  failures="$failures hlint"
fi

mkdir -p "$HOME/projects/github.com/xmonad"
cd "$HOME/projects/github.com/xmonad" || exit
git clone git@github.com:xmonad/xmonad.git
cd xmonad || exit
stack build
stack install
sudo mv .local/bin/xmonad /usr/local/bin/
cd - || exit

mkdir -p "$HOME/projects/github.com/xmonad"
cd "$HOME/projects/github.com/xmonad" || exit
git clone git@github.com:xmonad/xmonad-contrib.git
cd xmonad-contrib || exit
stack build
stack install
cd - || exit

# if ! stack install xmonad-contrib; then
#   echo failed xmonad-contrib.
#   failures="$failures xmonad-contrib"
# fi

if ! stack install xmonad-extras; then
  echo failed xmonad-extras.
  failures="$failures xmonad-extras"
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

sudo cp -v "$HOME/.local/bin/xmonad-start" /usr/local/bin/xmonad-start

mkdir -p "$HOME/projects/github.com/sei40kr"
cd "$HOME/projects/github.com/sei40kr" || exit
git clone https://github.com/sei40kr/tmux-airline-dracula.git
cd - || exit

stack exec ghc-pkg list
echo stack exec ghc-pkg unregister mypackage
echo stack exec ghc-pkg recache
echo stack exec ghc-pkg check

echo "install failures = $failures"

exit 0
