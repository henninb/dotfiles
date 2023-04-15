#!/usr/bin/env sh

if [ "${OS}" = "FreeBSD" ]; then
  sudo pkg install -y hs-stack
  cd /lib && sudo ln -sfn libncurses.so.9 libncursesw.so.8 && sudo ldconfig -R
  sudo pkg install -y misc/compat12x
else
  curl -sSL 'https://get.haskellstack.org' | sh
  stack update
fi

sudo mkdir /mnt/external

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  export DEBIAN_FRONTEND=noninteractive
  sudo apt remove -y landscape-common
  sudo apt install -y polybar
  sudo apt install -y locate
  sudo apt install -y autoconf
  sudo apt install -y bat
  sudo apt install -y blueman
  sudo apt install -y btop
  sudo apt install -y btop
  sudo apt install -y byobu
  sudo apt install -y cmake
  sudo apt install -y conky
  sudo apt install -y copyq
  sudo apt install -y copyq
  sudo apt install -y debootstrap
  sudo apt install -y debconf-utils
  sudo apt install -y desktop-file-utils
  sudo apt install -y dmenu
  sudo apt install -y dmg2img
  sudo apt install -y doas
  sudo apt install -y dmraid
  sudo apt install -y dzen2
  sudo apt install -y efibootmgr
  sudo apt install -y elinks
  sudo apt install -y feh
  sudo apt install -y fish
  sudo apt install -y flameshot
  sudo apt install -y gcc
  sudo apt install -y gtk-update-icon-cache
  sudo apt install -y hardinfo
  sudo apt install -y htop
  sudo apt install -y i3lock
  sudo apt install -y imagemagick
  sudo apt install -y jq
  sudo apt install -y kdeconnect
  sudo apt install -y keychain
  sudo apt install -y kitty
  sudo apt install -y kpcli
  sudo apt install -y libasound2-dev
  sudo apt install -y libbsd-dev
  sudo apt install -y libncurses5-dev
  sudo apt install -y libreoffice
  sudo apt install -y libxft-dev
  sudo apt install -y libxpm-dev
  sudo apt install -y libxrandr-dev
  sudo apt install -y libxss-dev
  sudo apt install -y lxappearance
  sudo apt install -y lxpolkit
  sudo apt install -y lxsession
  sudo apt install -y make
  sudo apt install -y mpc
  sudo apt install -y mpd
  sudo apt install -y mpdris2
  sudo apt install -y mdadm
  sudo apt install -y mpv
  sudo apt install -y ncdu
  sudo apt install -y neofetch
#  sudo apt install -y neovim
  sudo apt install -y newsboat
  sudo apt install -y nmap
  sudo apt install -y network-manager-gnome
  sudo apt install -y ntpdate
  sudo apt install -y numlockx
  sudo apt install -y os-prober
  sudo apt install -y pandoc
  sudo apt install -y partimage
  sudo apt install -y pass
  sudo apt install -y pavucontrol
  sudo apt install -y pkg-config
  sudo apt install -y playerctl
  sudo apt install -y powerline
  sudo apt install -y pulseaudio
  sudo apt install -y pwgen
  sudo apt install -y qalculate-gtk
  sudo apt install -y rofi
  sudo apt install -y rdfind
  sudo apt install -y redshift
  sudo apt install -y rsync
  sudo apt install -y slock
  sudo apt install -y sox
  sudo apt install -y speedtest-cli
  sudo apt install -y sxhkd
  sudo apt install -y sxiv
  sudo apt install -y thunar
  sudo apt install -y tmux
  sudo apt install -y trayer
  sudo apt install -y tree
  sudo apt install -y ufw
  sudo apt install -y vifm
  sudo apt install -y volumeicon-alsa
  sudo apt install -y w3m
  sudo apt install -y wget
  sudo apt install -y wmname
  sudo apt install -y xclip
  sudo apt install -y xdo
  sudo apt install -y xdotool
  sudo apt install -y xorg
  sudo apt install -y xscreensaver
  sudo apt install -y xterm
  sudo apt install -y yad
  sudo apt install -y yubikey-manager-qt
  sudo apt install -y zenity
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  sudo zypper addrepo --refresh https://download.nvidia.com/opensuse/tumbleweed NVIDIA
  sudo zypper addrepo https://download.opensuse.org/repositories/security/openSUSE_Tumbleweed/security.repo
  # sudo zypper addrepo https://download.opensuse.org/repositories/home:X0F:HSF/openSUSE_Tumbleweed/home:X0F:HSF.repo
  sudo zypper addrepo https://download.opensuse.org/repositories/X11:Utilities/openSUSE_Tumbleweed/X11:Utilities.repo
  # sudo zypper addrepo https://download.opensuse.org/repositories/home:AndnoVember:windowmanagers/openSUSE_Tumbleweed/home:AndnoVember:windowmanagers.repo
  sudo zypper refresh
  #sudo zypper install -y linux-tools
  sudo zypper install -y polybar
  sudo zypper install -y at-spi2-core
  sudo zypper install -y ca-certificates-cacert
  sudo zypper install -y pam_yubico
  sudo zypper install -y NetworkManager-applet
  sudo zypper install -y ncurses-devel
  sudo zypper install -y xorg-x11
  sudo zypper install -y xorg-x11-server
  sudo zypper install -y libnotify-tools
  sudo zypper install -y libncurses5
  sudo zypper install -y cmake
  sudo zypper install -y llvm
  sudo zypper install -y clang
  sudo zypper install -y gcc-c++
  sudo zypper install -y alacritty
  sudo zypper install -y alsa-lib-devel
  sudo zypper install -y bat
  sudo zypper install -y bind
  sudo zypper install -y blueman
  sudo zypper install -y bluez-utils
  sudo zypper install -y btop
  sudo zypper install -y byobu
  sudo zypper install -y cmake
  sudo zypper install -y conky
  # sudo zypper install -y copyq
  # sudo zypper install -y volumeicon
  sudo zypper install -y debootstrap
  sudo zypper install -y desktop-file-utils
  sudo zypper install -y dmenu
  sudo zypper install -y dunst
  sudo zypper install -y dzen2
  sudo zypper install -y efibootmgr
  sudo zypper install -y elinks
  sudo zypper install -y feh
  sudo zypper install -y fish
  sudo zypper install -y flameshot
  sudo zypper install -y gcc
  sudo zypper install -y gmp-devel
  sudo zypper install -y golang
  sudo zypper install -y htop
  sudo zypper install -y i3lock
  sudo zypper install -y jq
  sudo zypper install -y kdeconnect-kde
  sudo zypper install -y keychain
  sudo zypper install -y kitty
  sudo zypper install -y libXss-devel
  sudo zypper install -y libXft-devel
  sudo zypper install -y libXpm-devel
  sudo zypper install -y libXrandr-devel
  sudo zypper install -y lxappearance
  sudo zypper install -y lxsession
  sudo zypper install -y make
  sudo zypper install -y mpd
  sudo zypper install -y mpv
  sudo zypper install -y ncdu
  sudo zypper install -y neovim
  sudo zypper install -y newsboat
  sudo zypper install -y nmap
  sudo zypper install -y ntfs-3g
  sudo zypper install -y ntp
  sudo zypper install -y numlockx
  sudo zypper install -y os-prober
  sudo zypper install -y pandoc
  sudo zypper install -y pavucontrol
  sudo zypper install -y pkg-config
  sudo zypper install -y playerctl
  sudo zypper install -y polkit-gnome
  sudo zypper install -y powerline
  sudo zypper install -y powerline-fonts
  sudo zypper install -y pulseaudio
  sudo zypper install -y pwgen
  sudo zypper install -y qalculate-gtk
  sudo zypper install -y redshift
  sudo zypper install -y rsync
  sudo zypper install -y sox
  sudo zypper install -y speedtest-cli
  sudo zypper install -y starship
  sudo zypper install -y sxhkd
  sudo zypper install -y sxhkd
  sudo zypper install -y sxiv
  sudo zypper install -y thunar
  sudo zypper install -y tmux
  sudo zypper install -y trayer-srg
  sudo zypper install -y tree
  sudo zypper install -y vifm
  sudo zypper install -y vimb
  sudo zypper install -y w3m
  # sudo zypper install -y wmname
  sudo zypper install -y xclip
  sudo zypper install -y xdo
  sudo zypper install -y xdotool
  sudo zypper install -y xsetroot
  sudo zypper install -y xscreensaver
  sudo zypper install -y yubikey-manager-qt
  sudo zypper install -y zenity
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  # sudo pacman --noconfirm --needed -S playderctl
  #sudo pacman --noconfirm --needed -S pamac
  sudo pacman --noconfirm --needed -S xorg-apps
  sudo pacman --noconfirm --needed -S polybar
  sudo pacman --noconfirm --needed -S syncthing
  sudo pacman --noconfirm --needed -S xterm
  sudo pacman --noconfirm --needed -S xorg-xhost
  sudo pacman --noconfirm --needed -S gparted
  sudo pacman --noconfirm --needed -S ntfs-3g
  sudo pacman --noconfirm --needed -S man
  sudo pacman --noconfirm --needed -S dosfstools
  sudo pacman --noconfirm --needed -S xorg-xinit
  sudo pacman --noconfirm --needed -S mtools
  sudo pacman --noconfirm --needed -S mdadm
  sudo pacman --noconfirm --needed -S dmraid
  sudo pacman --noconfirm --needed -S alacritty
  sudo pacman --noconfirm --needed -S alsa-utils
  sudo pacman --noconfirm --needed -S arch-install-scripts
  sudo pacman --noconfirm --needed -S bat
  sudo pacman --noconfirm --needed -S bind
  sudo pacman --noconfirm --needed -S blueman
  sudo pacman --noconfirm --needed -S bluez-utils
  sudo pacman --noconfirm --needed -S btop
  sudo pacman --noconfirm --needed -S byobu
  sudo pacman --noconfirm --needed -S clipmenu
  sudo pacman --noconfirm --needed -S cmake
  sudo pacman --noconfirm --needed -S conky
  sudo pacman --noconfirm --needed -S copyq
  sudo pacman --noconfirm --needed -S debootstrap
  sudo pacman --noconfirm --needed -S desktop-file-utils
  sudo pacman --noconfirm --needed -S dmenu
  sudo pacman --noconfirm --needed -S dmg2img
  sudo pacman --noconfirm --needed -S doas
  sudo pacman --noconfirm --needed -S dunst
  sudo pacman --noconfirm --needed -S dzen2
  sudo pacman --noconfirm --needed -S efibootmgr
  sudo pacman --noconfirm --needed -S elinks
  sudo pacman --noconfirm --needed -S feh
  sudo pacman --noconfirm --needed -S fish
  sudo pacman --noconfirm --needed -S flameshot
  sudo pacman --noconfirm --needed -S gcc
  sudo pacman --noconfirm --needed -S gtk-update-icon-cache
  sudo pacman --noconfirm --needed -S htop
  sudo pacman --noconfirm --needed -S i3lock-color
  sudo pacman --noconfirm --needed -S imagemagick
  sudo pacman --noconfirm --needed -S inetutils
  sudo pacman --noconfirm --needed -S jq
  sudo pacman --noconfirm --needed -S kdeconnect
  sudo pacman --noconfirm --needed -S keychain
  sudo pacman --noconfirm --needed -S kitty
  sudo pacman --noconfirm --needed -S kpcli
  sudo pacman --noconfirm --needed -S lazygit
  sudo pacman --noconfirm --needed -S libreoffice
  sudo pacman --noconfirm --needed -S lxappearance
  sudo pacman --noconfirm --needed -S lxsession
  sudo pacman --noconfirm --needed -S make
  sudo pacman --noconfirm --needed -S mpc
  sudo pacman --noconfirm --needed -S mpd
  sudo pacman --noconfirm --needed -S mpv
  sudo pacman --noconfirm --needed -S ncdu
  sudo pacman --noconfirm --needed -S network-manager-applet
  sudo pacman --noconfirm --needed -S neovim
  sudo pacman --noconfirm --needed -S newsboat
  sudo pacman --noconfirm --needed -S nmap
  sudo pacman --noconfirm --needed -S ntp
  sudo pacman --noconfirm --needed -S numlockx
  sudo pacman --noconfirm --needed -S os-prober
  sudo pacman --noconfirm --needed -S pacman-contrib
  sudo pacman --noconfirm --needed -S pandoc
  sudo pacman --noconfirm --needed -S partimage
  sudo pacman --noconfirm --needed -S pass
  sudo pacman --noconfirm --needed -S pavucontrol
  sudo pacman --noconfirm --needed -S pkg-config
  sudo pacman --noconfirm --needed -S polkit-gnome
  sudo pacman --noconfirm --needed -S powerline
  sudo pacman --noconfirm --needed -S powerline-fonts
  sudo pacman --noconfirm --needed -S pulseaudio
  sudo pacman --noconfirm --needed -S pwgen
  sudo pacman --noconfirm --needed -S qalculate-gtk
  sudo pacman --noconfirm --needed -S rdfind
  sudo pacman --noconfirm --needed -S rofi
  sudo pacman --noconfirm --needed -S redshift
  sudo pacman --noconfirm --needed -S rsync
  sudo pacman --noconfirm --needed -S slock
  sudo pacman --noconfirm --needed -S sox
  sudo pacman --noconfirm --needed -S speedtest-cli
  sudo pacman --noconfirm --needed -S starship
  sudo pacman --noconfirm --needed -S sxhkd
  sudo pacman --noconfirm --needed -S sxiv
  sudo pacman --noconfirm --needed -S thunar
  sudo pacman --noconfirm --needed -S tmux
  sudo pacman --noconfirm --needed -S trayer
  sudo pacman --noconfirm --needed -S tree
  sudo pacman --noconfirm --needed -S tree
  sudo pacman --noconfirm --needed -S ttf-font-awesome
  sudo pacman --noconfirm --needed -S ufw
  sudo pacman --noconfirm --needed -S vifm
  sudo pacman --noconfirm --needed -S vimb
  sudo pacman --noconfirm --needed -S volumeicon
  sudo pacman --noconfirm --needed -S w3m
  sudo pacman --noconfirm --needed -S wmname
  sudo pacman --noconfirm --needed -S xclip
  sudo pacman --noconfirm --needed -S xdo
  sudo pacman --noconfirm --needed -S xdotool
  sudo pacman --noconfirm --needed -S xorg-server
  sudo pacman --noconfirm --needed -S xscreensaver
  sudo pacman --noconfirm --needed -S yad
  sudo pacman --noconfirm --needed -S yubikey-manager-qt
  sudo pacman --noconfirm --needed -S zenity
  # yay --noconfirm --needed -S hardinfo
  # yay --noconfirm --needed -S oblogout
  # yay --noconfirm --needed -S mpdris2
  sudo systemctl disable mpd.socket
  sudo systemctl stop mpd.socket
  sudo systemctl enable NetworkManager
elif [ "$OS" = "FreeBSD" ]; then
  ln -sfn "$(find /usr/local/bin/ -type f -name "perl5*" | tail -1)" "$HOME/.local/bin/perl"
  sudo pkg install -y alsa-lib
  sudo pkg install -y audio/alsa-utils
  sudo pkg install -y conky
  sudo pkg install -y btop
  sudo pkg install -y copyq
  sudo pkg install -y dmenu
  sudo pkg install -y doas
  sudo pkg install -y dunst
  sudo pkg install -y dzen2
  sudo pkg install -y feh
  sudo pkg install -y fish
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
  sudo pkg install -y polybar
  sudo pkg install -y pkgconf
  #sudo pkg install -y qalculate
  sudo pkg install -y rofi
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
  sudo pkg install -y vim
  sudo pkg install -y wget
  sudo pkg install -y yad
  sudo pkg install -y zenity
  # sudo pkg install -y libXft
  # sudo pkg install -y xz
  sudo sysrc dbus_enable="YES"
elif [ "$OS" = "Void" ]; then
  sudo xbps-install -y cabal-install
  sudo ln -sfn /usr/lib/libncursesw.so.6 /usr/lib/libtinfo.so.6
  sudo ln -sfn /usr/lib/libncursesw.so.6 /usr/lib/libtinfo.so
  VOID_PKGS="pkg-config autoconf xorg-minimal xscreensaver feh xdotool w3m neofetch lxappearance clipmenu xz make gcc gmp-devel dunst wmname alsa-lib-devel emacs-gtk3 alsa-utils pulseaudio flameshot volumeicon blueman mpc mpd jq redshift conky playerctl dunst libX11-devel libXinerama-devel libXrandr-devel libuuid libXft-devel libXScrnSaver-devel dzen2 trayer-srg CopyQ NetworkManager network-manager-applet numlockx hardinfo setxkbmap xinput xmodmap pandoc jq xrandr tmux yad bat htop i3lock keychain kdeconnect neovim ncdu rsync sox tree ntp xhost xdo starship btop wget go xclip dmg2img os-prober efibootmgr newsboat kitty xterm mesa-dri xtools glxinfo polkit hidapi-devel libgusb-devel xsetroot opendoas desktop-file-utils mdadm dmraid locate rofi hidapi-devel cmake fish polybar pavucontrol xorg-fonts xorg-apps"
  FAILURE=""
  for i in $VOID_PKGS; do
    if ! sudo xbps-install -y "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo "Failures: $FAILURE"
  sudo ln -sfn /etc/sv/polkitd /var/service/polkitd
  sudo ln -sfn /etc/sv/dbus /var/service/dbus
  sudo ln -sfn /etc/sv/NetworkManager /var/service/NetworkManager
  sudo sv status polkitd
  sudo sv status dbus
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
  SOLUS_PKGS="xmonad pkg-config feh xdotool w3m xz make gmp-devel libffi zlib dunst alsa-lib-devel alsa-utils pulseaudio libxscrnsaver-devel libxrandr-devel libxft-devel xdo libxpm-devel flameshot blueman copyq mpd mpc-client neofetch jq redshift font-awesome-4 conky playerctl picom dzen2 xappearance xscreensaver wmname clipmenu pandoc jq pavucontrol tmux rofi fish"
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
  GENTOO_PKGS="rust-bin neovim setxkbmap dzen i3lock x11-misc/xsensors qalculate-gtk hddtemp xscreensaver feh xdotool dunst wmname w3m x11-misc/xclip xinit xorg-server sys-apps/dbus flameshot volumeicon neofetch blueman dev-qt/qtwaylandscanner copyq clipmenu media-sound/mpc mpd net-wireless/blueman redshift playerctl conky net-misc/networkmanager numlockx nm-applet trayer-srg sxiv spacefm lxappearance xrandr hardinfo gentoolkit xmodmap app-misc/jq pavucontrol xinput neovim lsof sddm htop eix libreoffice-bin firefox-bin app-misc/screen pcmanfm rdfind zenity net-dns/bind-tools tmux bat whois starship traceroute kitty imagemagick colordiff media-fonts/terminus-font efibootmgr genfstab byobu dev-libs/tree-sitter luarocks alacritty ufw xdo pipewire pass pwgen tree keychain partimage ntfs3g dosfstools mtools ncdu speedtest-cli ntp nmap xhost btop dmg2img solaar elinks os-prober sys-fs/btrfs-progs sys-fs/udftools kpcli usbutils zbar xsetroot doas desktop-file-utils dmraid mdadm locate rofi gptfdisk wipe eselect-python dev-python/pip volctl usbimagewriter fish x11-themes/gtk-engines-murrine media-libs/libcanberra net-p2p/syncthing polybar"
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

  sudo mkdir -p /usr/share/backgrounds/images/

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
  sudo dnf groupinstall "Development Tools" "Development Libraries"
  # echo not sure if this works
  # echo sudo ln -sfn /usr/lib64/libncursesw.so.6 /usr/lib64/libtinfo.so.6

  # sudo dnf remove -y lightdm
  # sudo dnf remove -y gdm
  # sudo dnf remove -y lxdm
  # sudo dnf install -y clipmenu
  sudo dnf install -y xorg-x11-server-Xorg
  sudo dnf install -y polybar
  sudo dnf install -y syncthing
  sudo dnf install -y libtool
  sudo dnf install -y locate
  sudo dnf install -y dmraid
  sudo dnf install -y mdadm
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
  sudo dnf install -y desktop-file-utils
  sudo dnf install -y doas
  sudo dnf install -y dbus-x11
  sudo dnf install -y dunst
  sudo dnf install -y dmg2img
  sudo dnf install -y elinks
  # sudo dnf install -y dzen2
  sudo dnf install -y flameshot
  sudo dnf install -y feh
  sudo dnf install -y fish
  sudo dnf install -y g++
  sudo dnf install -y gtk2-devel
  sudo dnf install -y htop
  sudo dnf install -y i3lock
  sudo dnf install -y ImageMagick
  sudo dnf install -y jq
  sudo dnf install -y keychain
  sudo dnf install -y kitty
  sudo dnf install -y kpcli
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
  sudo dnf install -y network-manager-applet
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
  sudo dnf install -y rofi
  sudo dnf install -y rdfind
  sudo dnf install -y sxhkd
  sudo dnf install -y slock
  sudo dnf install -y sox
  sudo dnf install -y speedtest-cli
  sudo dnf install -y tree
  sudo dnf install -y thunar
  sudo dnf install -y trayer
  sudo dnf install -y volumeicon
  sudo dnf install -y w3m
  sudo dnf install -y wmname
  sudo dnf install -y xclip
  sudo dnf install -y xdotool
  sudo dnf install -y xsetroot
  sudo dnf install -y xscreensaver
  sudo dnf install -y yad
  sudo dnf install -y yubikey-manager-qt
  sudo dnf install -y clang-devel
  # sudo dnf install -y cmake-fedora
  sudo dnf install -y llvm-libs
  sudo dnf install -y llvm-devel
  sudo dnf install -y golang
  sudo dnf install -y luarocks
  sudo dnf install -y openssh-server
  sudo systemctl start sshd.service
  sudo systemctl enable sshd.service
  echo iwlib missing
  mkdir -p "$HOME/projects/github.com/baskerville"
  cd "$HOME/projects/github.com/baskerville" || exit
  git clone https://github.com/baskerville/xdo.git
  cd $HOME/projects/github.com/baskerville/xdo || exit
  sudo make install

  mkdir -p "$HOME/projects/github.com/sargon"
  cd "$HOME/projects/github.com/sargon" || exit
  git clone https://github.com/sargon/trayer-srg.git
  cd $HOME/projects/github.com/sargon/trayer-srg
  ./configure
  sudo make install
elif [ "$OS" = "Darwin" ]; then
  echo "macos"
elif [ "$OS" = "FreeBSD" ]; then
  echo "freebsd"
elif [ "$OS" = "OpenBSD" ]; then
  echo "openbsd"
elif [ "$OS" = "Clear Linux OS" ]; then
  echo "clearlinux"
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

cd "$HOME"
git branch --set-upstream-to=origin/main main

mkdir -p "$HOME/keepass-git"
cd "$HOME/keepass-git" || exit
git init .
git remote add origin pi:/home/pi/downloads/keepass-git
git branch --set-upstream-to=origin/main main
git fetch
git merge origin/main

systemctl enable syncthing.service --user

cd "$HOME/.config/xmonad" || exit
./build

exit 0

# vim: set ft=sh
