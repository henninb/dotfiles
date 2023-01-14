#!/usr/bin/env sh

if [ "${OS}" = "FreeBSD" ]; then
  sudo pkg install -y hs-stack
  cd /lib && sudo ln -sfn libncurses.so.9 libncursesw.so.8 && sudo ldconfig -R
  sudo pkg install -y misc/compat12x
else
  curl -sSL 'https://get.haskellstack.org' | sh
  stack update
fi

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt install -y clipmenu
  sudo apt install -y cmake
  sudo apt install -y conky
  sudo apt install -y copyq
  sudo apt install -y dunst
  sudo apt install -y feh
  sudo apt install -y flameshot
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
  sudo apt install -y rdfind
  sudo apt install -y sxhkd
  sudo apt install -y sxiv
  sudo apt install -y trayer
  sudo apt install -y volumeicon-alsa
  sudo apt install -y w3m
  sudo apt install -y wmname
  sudo apt install -y xclip
  sudo apt install -y xdo
  sudo apt install -y xdotool
  sudo apt install -y xscreensaver
  sudo apt install -y pandoc
  sudo apt install -y jq
  sudo apt install -y sxiv
  sudo apt install -y thunar
  sudo apt install -y qalculate
  sudo apt install -y libxrandr-dev
  sudo apt install -y libxft-dev
  sudo apt install -y autoconf
  sudo apt install -y libasound2-dev
  sudo apt install -y libncurses5-dev
  sudo apt install -y trayer
  sudo apt install -y dzen2
  sudo apt install -y blueman
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
  sudo zypper install -y pandoc
  sudo zypper install -y jq
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
  sudo pacman --noconfirm --needed -S alacritty
  sudo pacman --noconfirm --needed -S alsa-utils
  sudo pacman --noconfirm --needed -S arch-install-scripts
  sudo pacman --noconfirm --needed -S bat
  sudo pacman --noconfirm --needed -S bind
  sudo pacman --noconfirm --needed -S blueman
  sudo pacman --noconfirm --needed -S bluez-utils
  sudo pacman --noconfirm --needed -S byobu
  sudo pacman --noconfirm --needed -S clipmenu
  sudo pacman --noconfirm --needed -S cmake
  sudo pacman --noconfirm --needed -S conky
  sudo pacman --noconfirm --needed -S copyq
  sudo pacman --noconfirm --needed -S dmenu
  sudo pacman --noconfirm --needed -S debootstrap
  sudo pacman --noconfirm --needed -S dunst
  sudo pacman --noconfirm --needed -S dzen2
  sudo pacman --noconfirm --needed -S slock
  sudo pacman --noconfirm --needed -S feh
  sudo pacman --noconfirm --needed -S flameshot
  # sudo pacman --noconfirm --needed -S font-awesome-4
  sudo pacman --noconfirm --needed -S ttf-font-awesome
  sudo pacman --noconfirm --needed -S gtk-update-icon-cache
  sudo pacman --noconfirm --needed -S gcc
  sudo pacman --noconfirm --needed -S htop
  sudo pacman --noconfirm --needed -S inetutils
  sudo pacman --noconfirm --needed -S imagemagick
  sudo pacman --noconfirm --needed -S jq
  sudo pacman --noconfirm --needed -S keychain
  sudo pacman --noconfirm --needed -S kitty
  sudo pacman --noconfirm --needed -S i3lock-color
  sudo pacman --noconfirm --needed -S lxappearance
  sudo pacman --noconfirm --needed -S lazygit
  sudo pacman --noconfirm --needed -S libreoffice
  sudo pacman --noconfirm --needed -S lxsession
  sudo pacman --noconfirm --needed -S make
  sudo pacman --noconfirm --needed -S mpc
  sudo pacman --noconfirm --needed -S mpv
  sudo pacman --noconfirm --needed -S mpd
  sudo pacman --noconfirm --needed -S nmap
  sudo pacman --noconfirm --needed -S ntp
  sudo pacman --noconfirm --needed -S ncdu
  sudo pacman --noconfirm --needed -S numlockx
  sudo pacman --noconfirm --needed -S network-manager-applet
  sudo pacman --noconfirm --needed -S pavucontrol
  sudo pacman --noconfirm --needed -S partimage
  sudo pacman --noconfirm --needed -S pkg-config
  sudo pacman --noconfirm --needed -S polkit-gnome
  sudo pacman --noconfirm --needed -S powerline
  sudo pacman --noconfirm --needed -S powerline-fonts
  # sudo pacman --noconfirm --needed -S mpdris2
  # sudo pacman --noconfirm --needed -S playderctl
  sudo pacman --noconfirm --needed -S pulseaudio
  sudo pacman --noconfirm --needed -S redshift
  sudo pacman --noconfirm --needed -S rdfind
  sudo pacman --noconfirm --needed -S rsync
  sudo pacman --noconfirm --needed -S sox
  sudo pacman --noconfirm --needed -S sxhkd
  sudo pacman --noconfirm --needed -S starship
  sudo pacman --noconfirm --needed -S sxiv
  sudo pacman --noconfirm --needed -S speedtest-cli
  sudo pacman --noconfirm --needed -S pacman-contrib
  sudo pacman --noconfirm --needed -S pass
  sudo pacman --noconfirm --needed -S pwgen
  sudo pacman --noconfirm --needed -S tree
  sudo pacman --noconfirm --needed -S trayer
  sudo pacman --noconfirm --needed -S thunar
  sudo pacman --noconfirm --needed -S tmux
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
  sudo pacman --noconfirm --needed -S kdeconnect
  sudo pacman --noconfirm --needed -S pandoc
  sudo pacman --noconfirm --needed -S tree
  sudo pacman --noconfirm --needed -S xorg-xinit
  sudo pacman --noconfirm --needed -S xorg-server
  sudo pacman --noconfirm --needed -S ufw
  sudo pacman --noconfirm --needed -S zenity
  # yay --noconfirm --needed -S hardinfo
  # yay --noconfirm --needed -S oblogout
  # yay --noconfirm --needed -S mpdris2
  sudo systemctl disable mpd.socket
  sudo systemctl stop mpd.socket
elif [ "$OS" = "FreeBSD" ]; then
  ln -sfn "$(find /usr/local/bin/ -type f -name "perl5*" | tail -1)" "$HOME/.local/bin/perl"
  sudo pkg install -y alsa-lib
  sudo pkg install -y audio/alsa-utils
  sudo pkg install -y conky
  sudo pkg install -y btop
  sudo pkg install -y copyq
  sudo pkg install -y dmenu
  sudo pkg install -y dunst
  sudo pkg install -y dzen2
  sudo pkg install -y feh
  sudo pkg install -y flameshot
  #sudo pkg install -y hardinfo
  sudo pkg install -y htop
  sudo pkg install -y i3lock
  sudo pkg install -y jq
  sudo pkg install -y kitty
  sudo pkg install -y lxappearance
  sudo pkg install -y mpv
  sudo pkg install -y musicpc
  sudo pkg install -y musicpd
  sudo pkg install -y neofetch
  sudo pkg install -y neovim
  sudo pkg install -y newsboat
  sudo pkg install -y networkmgr
  sudo pkg install -y numlockx
  #sudo pkg install -y pandoc
  sudo pkg install -y pcmanfm
  sudo pkg install -y perl5
  sudo pkg install -y pkgconf
  #sudo pkg install -y qalculate
  sudo pkg install -y redshift
  #sudo pkg install -y rdfind
  sudo pkg install -y screen
  sudo pkg install -y sxhkd
  #sudo pkg install -y sxiv
  sudo pkg install -y sysutils/uhidd
  sudo pkg install -y terminus-font
  sudo pkg install -y thunar
  sudo pkg install -y trayer
  sudo pkg install -y tmux
  sudo pkg install -y volumeicon
  sudo pkg install -y w3m
  sudo pkg install -y wmname
  sudo pkg install -y xclip
  sudo pkg install -y xdo
  sudo pkg install -y xdotool
  sudo pkg install -y xorg
  sudo pkg install -y xscreensaver
  sudo pkg install -y yad
  sudo pkg install -y zenity
  # sudo pkg install -y libXft
  # sudo pkg install -y xz
  sudo sysrc dbus_enable="YES"
elif [ "$OS" = "Void" ]; then
  sudo xbps-install -y cabal-install
  sudo ln -sfn /usr/lib/libncursesw.so.6 /usr/lib/libtinfo.so.6
  sudo ln -sfn /usr/lib/libncursesw.so.6 /usr/lib/libtinfo.so
  VOID_PKGS="xmonad pkg-config autoconf xorg-minimal xscreensaver feh xdotool w3m neofetch lxappearance volumeicon clipmenu xz make gcc gmp-devel dunst wmname alsa-lib-devel emacs-gtk3 alsa-utils pulseaudio flameshot volumeicon blueman mpc mpd jq redshift conky playerctl dunst libX11-devel libXinerama-devel libXrandr-devel libuuid libXft-devel libXScrnSaver-devel dzen2 trayer-srg CopyQ NetworkManager network-manager-applet numlockx hardinfo setxkbmap xinput xmodmap pandoc jq xrandr tmux yad bat htop i3lock keychain kdeconnect neovim ncdu rsync sox tree ntp xhost xdo starship btop wget go"
  FAILURE=""
  for i in $VOID_PKGS; do
    if ! sudo xbps-install -y "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo "Failures: $FAILURE"
elif [ "$OS" = "Solus" ]; then
  sudo ln -sfn /usr/lib/libncursesw.so.5.9 /usr/lib/libtinfo.so
  if ! sudo ln -sfn /usr/lib/libncursesw.so.5.9 /usr/lib/libtinfo.so.5.9; then
    echo "Solution: error while loading shared libraries: libtinfo.so.5: cannot open shared object file: No such file or directory"
  fi
  sudo eopkg install -y gcc
  sudo eopkg install -y gettext-devel
  sudo eopkg install -y libgtk-3-devel

  nix-env -i dzen2
  nix-env -i volumeicon

  mkdir -p d "$HOME/projects/github.com/Maato"
  cd "$HOME/projects/github.com/Maato" || exit
  git clone git@github.com:Maato/volumeicon.git
  cd ./volumeicon || exit
  ./autogen.sh
  ./configure
  make
  sudo make install
  cd "$HOME" || exit
  SOLUS_PKGS="xmonad pkg-config feh xdotool w3m xz make gmp-devel libffi zlib dunst alsa-lib-devel alsa-utils pulseaudio libxscrnsaver-devel libxrandr-devel libxft-devel xdo libxpm-devel flameshot blueman copyq mpd mpc-client neofetch jq redshift font-awesome-4 conky playerctl picom dzen2 xappearance xscreensaver wmname clipmenu pandoc jq pavucontrol tmux"
  FAILURE=""
  sudo eopkg install -c system.devel
  for i in $SOLUS_PKGS; do
    if ! sudo eopkg install -y "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo "Failures: $FAILURE"
  echo "need dzen2"
elif [ "$OS" = "Gentoo" ]; then
  sudo usermod -aG tty "$(id -un)"
  sudo usermod -aG video "$(id -un)"
  # elogind
  GENTOO_PKGS="rust-bin neovim setxkbmap dzen i3lock x11-misc/xsensors qalculate-gtk hddtemp xscreensaver feh xdotool w3m dunst wmname w3m x11-misc/xclip xinit xorg-server sys-apps/dbus flameshot volumeicon neofetch blueman dev-qt/qtwaylandscanner copyq clipmenu media-sound/mpc mpd net-wireless/blueman redshift playerctl conky net-misc/networkmanager numlockx nm-applet trayer-srg newsboat sxiv spacefm lxappearance xrandr hardinfo gentoolkit xmodmap app-misc/jq pavucontrol xinput neovim lsof sddm htop eix libreoffice-bin firefox-bin app-misc/screen pcmanfm rdfind zenity net-dns/bind-tools tmux bat whois starship traceroute kitty imagemagick colordiff media-fonts/terminus-font efibootmgr genfstab byobu dev-libs/tree-sitter luarocks alacritty ufw xdo pipewire pass pwgen tree keychain partimage ntfs3g dosfstools mtools ncdu speedtest-cli ntp nmap xhost btop"
  FAILURE=""
  ls -d /var/db/pkg/*/*| cut -f5- -d/
  for i in $GENTOO_PKGS; do
    if ! command -v "$i"; then
      if ! sudo emerge --update --newuse "$i"; then
        FAILURE="$i $FAILURE"
      fi
    fi
  done
  sudo usermod -a -G audio "$(id -un)"
  sudo ln -sfn /usr/bin/trayer-srg /usr/bin/trayer
  if ! command -v systemctl; then
    sudo rc-update add dbus default
    sudo rc-update add elogind default
    sudo rc-update add bluetooth default
    sudo rc-update add NetworkManager default
    sudo rc-service NetworkManager start
  else
    sudo systemctl enable NetworkManager.service
    sudo systemctl start NetworkManager.service
    sudo systemctl enable bluetooth.service
    sudo systemctl start bluetooth.service
    sudo systemctl enable cronie
    sudo systemctl start cronie
  fi

  mkdir -p "$HOME/projects/github.com/baskerville"
  cd "$HOME/projects/github.com/baskerville" || exit
  git clone git@github.com:baskerville/xdo.git
  cd ./xdo || exit
  make
  sudo make install
  echo "Failures: $FAILURE"
elif [ "$OS" = "Fedora Linux" ]; then
  sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
  sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
  sudo dnf makecache
  # echo not sure if this works
  # echo sudo ln -sfn /usr/lib64/libncursesw.so.6 /usr/lib64/libtinfo.so.6

  # sudo dnf remove -y lightdm
  # sudo dnf remove -y gdm
  # sudo dnf remove -y lxdm
  # sudo dnf install -y clipmenu
  sudo dnf install -y alacritty
  sudo dnf install -y alsa-lib-devel
  sudo dnf install -y bat
  sudo dnf install -y btop
  sudo dnf install -y blueman
  sudo dnf install -y bluez
  sudo dnf install -y bridge-utils
  sudo dnf install -y conky
  sudo dnf install -y copyq
  sudo dnf install -y dmenu
  sudo dnf install -y dbus-x11
  sudo dnf install -y dunst
  # sudo dnf install -y dzen2
  sudo dnf install -y flameshot
  sudo dnf install -y feh
  sudo dnf install -y g++
  sudo dnf install -y gtk2-devel 
  sudo dnf install -y htop
  sudo dnf install -y i3lock
  sudo dnf install -y ImageMagick
  sudo dnf install -y jq
  sudo dnf install -y keychain
  sudo dnf install -y kitty
  sudo dnf install -y kdeconnect
  sudo dnf install -y libXScrnSaver-devel
  sudo dnf install -y lxsession
  sudo dnf install -y libXft-devel
  sudo dnf install -y libXpm-devel
  sudo dnf install -y libXinerama-devel
  sudo dnf install -y libX11-devel
  sudo dnf install -y libXrandr-devel
  sudo dnf install -y libreoffice
  sudo dnf install -y mpc
  sudo dnf install -y mpd
  sudo dnf install -y neovim
  sudo dnf install -y neofetch
  sudo dnf install -y nmap
  sudo dnf install -y numlockx
  sudo dnf install -y ncdu
  sudo dnf install -y ntpsec
  sudo dnf install -y pavucontrol
  sudo dnf install -y partimage
  sudo dnf install -y pandoc
  sudo dnf install -y powerline
  sudo dnf install -y powerline-fonts
  sudo dnf install -y openssl
  sudo dnf install -y rsync
  sudo dnf install -y sxhkd
  sudo dnf install -y slock
  sudo dnf install -y sox
  sudo dnf install -y speedtest-cli
  sudo dnf install -y tree
  sudo dnf install -y thunar
  sudo dnf install -y trayer
  sudo dnf install -y voluemeicon
  sudo dnf install -y w3m
  sudo dnf install -y wmname
  sudo dnf install -y xclip
  sudo dnf install -y xdotool
  sudo dnf install -y xscreensaver
  sudo dnf install -y yad
  sudo dnf groupinstall "Development Tools" "Development Libraries"
  sudo dnf install -y clang-devel
  # sudo dnf install -y cmake-fedora
  sudo dnf install -y llvm-libs
  sudo dnf install -y llvm-devel
  sudo dnf install -y golang
  sudo dnf install -y luarocks
  echo iwlib missing
  mkdir -p "$HOME/projects/github.com/baskerville"
  cd "$HOME/projects/github.com/baskerville" || exit
  git clone git@github.com:baskerville/xdo.git
  cd ./xdo || exit
  sudo make install

  mkidr -p "$HOME/projects/github.com/sargon"
  cd "$HOME/projects/github.com/sargon" || exit
  git clone git@github.com/sargon/trayer-srg.git
  cd trayer-srg
  ./configure
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
    echo 'nix-env -i dzen2'
    nix-env -i dzen2
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
stack ghc -- --version
# git clone --branch v0.17.0 git@github.com:xmonad/xmonad.git
git clone git@github.com:xmonad/xmonad.git
cd ./xmonad || exit
# git checkout v0.17.0
stack build
stack install
sudo mv -v "$HOME/.local/bin/xmonad" /usr/local/bin/
cd - || exit

mkdir -p "$HOME/projects/github.com/xmonad"
cd "$HOME/projects/github.com/xmonad" || exit
git clone git@github.com:xmonad/xmonad-contrib.git
# git clone --branch v0.17.0 git@github.com:xmonad/xmonad-contrib.git
cd ./xmonad-contrib || exit
# git checkout v0.17.0
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
# mkdir -p "$HOME/projects/github.com/jaor" || exit
# cd "$HOME/projects/github.com/jaor" || exit
# git clone git@github.com:jaor/xmobar.git
# cd xmobar || exit
# stack build
# stack install
# cd - || exit
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

# echo gsettings set org.freedesktop.Notifications allow-other-notification-handlers true
# echo gsettings set haskell-notification-daemon allow-other-notification-handlers true

cd "$HOME/.config/xmonad" || exit
./build

exit 0

# vim: set ft=sh
