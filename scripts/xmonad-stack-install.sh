#!/usr/bin/env sh

if [ "${OS}" = "FreeBSD" ]; then
  doas pkg install -y hs-stack
  cd /lib && sudo ln -sfn libncurses.so.9 libncursesw.so.8 && sudo ldconfig -R
  sudo pkg install -y misc/compat12x
else
  curl -sSL 'https://get.haskellstack.org' | sh
  stack update
fi

sudo mkdir /mnt/external

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  export DEBIAN_FRONTEND=noninteractive
  doas apt remove -y landscape-common
  doas apt install -y polybar
  doas apt install -y locate
  doas apt install -y autoconf
  doas apt install -y bat
  doas apt install -y blueman
  doas apt install -y btop
  doas apt install -y btop
  doas apt install -y byobu
  doas apt install -y cmake
  doas apt install -y conky
  doas apt install -y copyq
  doas apt install -y copyq
  doas apt install -y debootstrap
  doas apt install -y debconf-utils
  doas apt install -y desktop-file-utils
  doas apt install -y dmenu
  doas apt install -y dmg2img
  doas apt install -y doas
  doas apt install -y dmraid
  doas apt install -y dzen2
  doas apt install -y efibootmgr
  doas apt install -y elinks
  doas apt install -y feh
  doas apt install -y fish
  doas apt install -y flameshot
  doas apt install -y gcc
  doas apt install -y gtk-update-icon-cache
  doas apt install -y hardinfo
  doas apt install -y htop
  doas apt install -y i3lock
  doas apt install -y imagemagick
  doas apt install -y jq
  doas apt install -y kdeconnect
  doas apt install -y keychain
  doas apt install -y kitty
  doas apt install -y kpcli
  doas apt install -y libasound2-dev
  doas apt install -y libbsd-dev
  doas apt install -y libncurses5-dev
  doas apt install -y libreoffice
  doas apt install -y libxft-dev
  doas apt install -y libxpm-dev
  doas apt install -y libxrandr-dev
  doas apt install -y libxss-dev
  doas apt install -y lxappearance
  doas apt install -y lxpolkit
  doas apt install -y lxsession
  doas apt install -y make
  doas apt install -y mpc
  doas apt install -y mpd
  doas apt install -y mpdris2
  doas apt install -y mdadm
  doas apt install -y mpv
  doas apt install -y ncdu
  doas apt install -y neofetch
#  sudo apt install -y neovim
  doas apt install -y newsboat
  doas apt install -y nmap
  doas apt install -y network-manager-gnome
  doas apt install -y ntpdate
  doas apt install -y numlockx
  doas apt install -y os-prober
  doas apt install -y pandoc
  doas apt install -y partimage
  doas apt install -y pass
  doas apt install -y pavucontrol
  doas apt install -y pkg-config
  doas apt install -y playerctl
  doas apt install -y powerline
  doas apt install -y pulseaudio
  doas apt install -y pwgen
  doas apt install -y qalculate-gtk
  doas apt install -y rofi
  doas apt install -y rdfind
  doas apt install -y redshift
  doas apt install -y rsync
  doas apt install -y slock
  doas apt install -y sox
  doas apt install -y speedtest-cli
  doas apt install -y sxhkd
  doas apt install -y sxiv
  doas apt install -y thunar
  doas apt install -y tmux
  doas apt install -y trayer
  doas apt install -y tree
  doas apt install -y ufw
  doas apt install -y vifm
  doas apt install -y volumeicon-alsa
  doas apt install -y w3m
  doas apt install -y wget
  doas apt install -y wmname
  doas apt install -y xclip
  doas apt install -y xdo
  doas apt install -y xdotool
  doas apt install -y xorg
  doas apt install -y xscreensaver
  doas apt install -y xterm
  doas apt install -y yad
  doas apt install -y yubikey-manager-qt
  doas apt install -y zenity
  curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sudo sh
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  sudo zypper addrepo --refresh https://download.nvidia.com/opensuse/tumbleweed NVIDIA
  sudo zypper addrepo https://download.opensuse.org/repositories/security/openSUSE_Tumbleweed/security.repo
  # sudo zypper addrepo https://download.opensuse.org/repositories/devel:/languages:/lua/openSUSE_Tumbleweed/devel:languages:lua.repo
  # sudo zypper addrepo https://download.opensuse.org/repositories/home:X0F:HSF/openSUSE_Tumbleweed/home:X0F:HSF.repo
  sudo zypper addrepo https://download.opensuse.org/repositories/X11:Utilities/openSUSE_Tumbleweed/X11:Utilities.repo
  # sudo zypper addrepo https://download.opensuse.org/repositories/home:AndnoVember:windowmanagers/openSUSE_Tumbleweed/home:AndnoVember:windowmanagers.repo
  doas zypper refresh
  #sudo zypper install -y linux-tools
  doas zypper install -y lua54-luarocks
  doas zypper install -y polybar
  doas zypper install -y at-spi2-core
  doas zypper install -y ca-certificates-cacert
  doas zypper install -y pam_yubico
  doas zypper install -y NetworkManager-applet
  doas zypper install -y ncurses-devel
  doas zypper install -y xorg-x11
  doas zypper install -y xorg-x11-server
  doas zypper install -y libnotify-tools
  doas zypper install -y libncurses5
  doas zypper install -y cmake
  doas zypper install -y llvm
  doas zypper install -y clang
  doas zypper install -y gcc-c++
  doas zypper install -y alacritty
  doas zypper install -y alsa-lib-devel
  doas zypper install -y bat
  doas zypper install -y bind
  doas zypper install -y blueman
  doas zypper install -y bluez-utils
  doas zypper install -y btop
  doas zypper install -y byobu
  doas zypper install -y cmake
  doas zypper install -y conky
  # sudo zypper install -y copyq
  # sudo zypper install -y volumeicon
  doas zypper install -y debootstrap
  doas zypper install -y desktop-file-utils
  doas zypper install -y dmenu
  doas zypper install -y dunst
  doas zypper install -y dzen2
  doas zypper install -y efibootmgr
  doas zypper install -y elinks
  doas zypper install -y feh
  doas zypper install -y fish
  doas zypper install -y flameshot
  doas zypper install -y gcc
  doas zypper install -y gmp-devel
  doas zypper install -y golang
  doas zypper install -y htop
  doas zypper install -y i3lock
  doas zypper install -y jq
  doas zypper install -y kdeconnect-kde
  doas zypper install -y keychain
  doas zypper install -y kitty
  doas zypper install -y libXss-devel
  doas zypper install -y libXft-devel
  doas zypper install -y libXpm-devel
  doas zypper install -y libXrandr-devel
  doas zypper install -y lxappearance
  doas zypper install -y lxsession
  doas zypper install -y make
  doas zypper install -y mpd
  doas zypper install -y mpv
  doas zypper install -y ncdu
  doas zypper install -y neovim
  doas zypper install -y newsboat
  doas zypper install -y nmap
  doas zypper install -y ntfs-3g
  doas zypper install -y ntp
  doas zypper install -y numlockx
  doas zypper install -y os-prober
  doas zypper install -y pandoc
  doas zypper install -y pavucontrol
  doas zypper install -y pkg-config
  doas zypper install -y playerctl
  doas zypper install -y polkit-gnome
  doas zypper install -y powerline
  doas zypper install -y powerline-fonts
  doas zypper install -y pulseaudio
  doas zypper install -y pwgen
  doas zypper install -y qalculate-gtk
  doas zypper install -y redshift
  doas zypper install -y rsync
  doas zypper install -y sox
  doas zypper install -y speedtest-cli
  doas zypper install -y starship
  doas zypper install -y sxhkd
  doas zypper install -y sxhkd
  doas zypper install -y sxiv
  doas zypper install -y thunar
  doas zypper install -y tmux
  doas zypper install -y trayer-srg
  doas zypper install -y tree
  doas zypper install -y vifm
  doas zypper install -y vimb
  doas zypper install -y w3m
  # sudo zypper install -y wmname
  doas zypper install -y xclip
  doas zypper install -y xdo
  doas zypper install -y xdotool
  doas zypper install -y xsetroot
  doas zypper install -y xscreensaver
  doas zypper install -y yubikey-manager-qt
  doas zypper install -y zenity
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  # sudo pacman --noconfirm --needed -S playderctl
  #sudo pacman --noconfirm --needed -S pamac
  doas pacman --noconfirm --needed -S openvpn
  doas pacman --noconfirm --needed -S xorg-apps
  doas pacman --noconfirm --needed -S polybar
  doas pacman --noconfirm --needed -S syncthing
  doas pacman --noconfirm --needed -S xterm
  doas pacman --noconfirm --needed -S xorg-xhost
  doas pacman --noconfirm --needed -S gparted
  doas pacman --noconfirm --needed -S ntfs-3g
  doas pacman --noconfirm --needed -S man
  doas pacman --noconfirm --needed -S dosfstools
  doas pacman --noconfirm --needed -S xorg-xinit
  doas pacman --noconfirm --needed -S mtools
  doas pacman --noconfirm --needed -S mdadm
  doas pacman --noconfirm --needed -S dmraid
  doas pacman --noconfirm --needed -S alacritty
  doas pacman --noconfirm --needed -S alsa-utils
  doas pacman --noconfirm --needed -S arch-install-scripts
  doas pacman --noconfirm --needed -S bat
  doas pacman --noconfirm --needed -S bind
  doas pacman --noconfirm --needed -S blueman
  doas pacman --noconfirm --needed -S bluez-utils
  doas pacman --noconfirm --needed -S btop
  doas pacman --noconfirm --needed -S byobu
  doas pacman --noconfirm --needed -S clipmenu
  doas pacman --noconfirm --needed -S cmake
  doas pacman --noconfirm --needed -S conky
  doas pacman --noconfirm --needed -S copyq
  doas pacman --noconfirm --needed -S debootstrap
  doas pacman --noconfirm --needed -S desktop-file-utils
  doas pacman --noconfirm --needed -S dmenu
  doas pacman --noconfirm --needed -S dmg2img
  doas pacman --noconfirm --needed -S doas
  doas pacman --noconfirm --needed -S dunst
  doas pacman --noconfirm --needed -S dzen2
  doas pacman --noconfirm --needed -S efibootmgr
  doas pacman --noconfirm --needed -S elinks
  doas pacman --noconfirm --needed -S feh
  doas pacman --noconfirm --needed -S fish
  doas pacman --noconfirm --needed -S flameshot
  doas pacman --noconfirm --needed -S gcc
  doas pacman --noconfirm --needed -S gtk-update-icon-cache
  doas pacman --noconfirm --needed -S htop
  doas pacman --noconfirm --needed -S i3lock-color
  doas pacman --noconfirm --needed -S imagemagick
  doas pacman --noconfirm --needed -S inetutils
  doas pacman --noconfirm --needed -S jq
  doas pacman --noconfirm --needed -S kdeconnect
  doas pacman --noconfirm --needed -S keychain
  doas pacman --noconfirm --needed -S kitty
  doas pacman --noconfirm --needed -S kpcli
  doas pacman --noconfirm --needed -S lazygit
  doas pacman --noconfirm --needed -S libreoffice
  doas pacman --noconfirm --needed -S lxappearance
  doas pacman --noconfirm --needed -S lxsession
  doas pacman --noconfirm --needed -S make
  doas pacman --noconfirm --needed -S mpc
  doas pacman --noconfirm --needed -S mpd
  doas pacman --noconfirm --needed -S mpv
  doas pacman --noconfirm --needed -S ncdu
  doas pacman --noconfirm --needed -S network-manager-applet
  doas pacman --noconfirm --needed -S neovim
  doas pacman --noconfirm --needed -S newsboat
  doas pacman --noconfirm --needed -S nmap
  doas pacman --noconfirm --needed -S ntp
  doas pacman --noconfirm --needed -S numlockx
  doas pacman --noconfirm --needed -S os-prober
  doas pacman --noconfirm --needed -S pacman-contrib
  doas pacman --noconfirm --needed -S pandoc
  doas pacman --noconfirm --needed -S partimage
  doas pacman --noconfirm --needed -S pass
  doas pacman --noconfirm --needed -S pavucontrol
  doas pacman --noconfirm --needed -S pkg-config
  doas pacman --noconfirm --needed -S polkit-gnome
  doas pacman --noconfirm --needed -S powerline
  doas pacman --noconfirm --needed -S powerline-fonts
  doas pacman --noconfirm --needed -S pulseaudio
  doas pacman --noconfirm --needed -S pwgen
  doas pacman --noconfirm --needed -S qalculate-gtk
  doas pacman --noconfirm --needed -S rdfind
  doas pacman --noconfirm --needed -S rofi
  doas pacman --noconfirm --needed -S redshift
  doas pacman --noconfirm --needed -S rsync
  doas pacman --noconfirm --needed -S slock
  doas pacman --noconfirm --needed -S sox
  doas pacman --noconfirm --needed -S speedtest-cli
  doas pacman --noconfirm --needed -S starship
  doas pacman --noconfirm --needed -S sxhkd
  doas pacman --noconfirm --needed -S sxiv
  doas pacman --noconfirm --needed -S thunar
  doas pacman --noconfirm --needed -S tmux
  doas pacman --noconfirm --needed -S trayer
  doas pacman --noconfirm --needed -S tree
  doas pacman --noconfirm --needed -S tree
  doas pacman --noconfirm --needed -S ttf-font-awesome
  doas pacman --noconfirm --needed -S ufw
  doas pacman --noconfirm --needed -S vifm
  doas pacman --noconfirm --needed -S vimb
  doas pacman --noconfirm --needed -S volumeicon
  doas pacman --noconfirm --needed -S w3m
  doas pacman --noconfirm --needed -S wmname
  doas pacman --noconfirm --needed -S xclip
  doas pacman --noconfirm --needed -S xdo
  doas pacman --noconfirm --needed -S xdotool
  doas pacman --noconfirm --needed -S xorg-server
  doas pacman --noconfirm --needed -S xscreensaver
  doas pacman --noconfirm --needed -S yad
  doas pacman --noconfirm --needed -S yubikey-manager-qt
  doas pacman --noconfirm --needed -S zenity
  # yay --noconfirm --needed -S hardinfo
  # yay --noconfirm --needed -S oblogout
  # yay --noconfirm --needed -S mpdris2
  doas systemctl disable mpd.socket
  doas systemctl stop mpd.socket
  doas systemctl enable NetworkManager
elif [ "$OS" = "FreeBSD" ]; then
  ln -sfn "$(find /usr/local/bin/ -type f -name "perl5*" | tail -1)" "$HOME/.local/bin/perl"
  doas pkg install -y fusefs-ntfs
  doas pkg install -y weget
  doas pkg install -y syncthing
  doas pkg install -y openvpn
  doas pkg install -y alsa-lib
  sudo pkg install -y audio/alsa-utils
  doas pkg install -y conky
  doas pkg install -y btop
  # sudo pkg install -y copyq
  doas pkg install -y copyq-qt6
  doas pkg install -y dmenu
  doas pkg install -y doas
  doas pkg install -y dunst
  doas pkg install -y dzen2
  doas pkg install -y feh
  doas pkg install -y fish
  doas pkg install -y flameshot
  #sudo pkg install -y hardinfo
  doas pkg install -y htop
  doas pkg install -y i3lock
  doas pkg install -y jq
  doas pkg install -y kitty
  doas pkg install -y lxappearance
  doas pkg install -y mpv
  doas pkg install -y musicpc
  doas pkg install -y musicpd
  doas pkg install -y neofetch
  doas pkg install -y neovim
  doas pkg install -y newsboat
  doas pkg install -y networkmgr
  doas pkg install -y numlockx
  #sudo pkg install -y pandoc
  doas pkg install -y pcmanfm
  doas pkg install -y perl5
  doas pkg install -y polybar
  doas pkg install -y pkgconf
  #sudo pkg install -y qalculate
  doas pkg install -y rofi
  doas pkg install -y redshift
  #sudo pkg install -y rdfind
  doas pkg install -y screen
  doas pkg install -y sxhkd
  #sudo pkg install -y sxiv
  sudo pkg install -y sysutils/uhidd
  doas pkg install -y terminus-font
  doas pkg install -y thunar
  doas pkg install -y trayer
  doas pkg install -y tmux
  doas pkg install -y volumeicon
  doas pkg install -y w3m
  doas pkg install -y wmname
  doas pkg install -y xclip
  doas pkg install -y xdo
  doas pkg install -y xdotool
  doas pkg install -y xorg
  doas pkg install -y xscreensaver
  doas pkg install -y vim
  doas pkg install -y wget
  doas pkg install -y yad
  doas pkg install -y zenity
  # sudo pkg install -y libXft
  # sudo pkg install -y xz
  doas sysrc dbus_enable="YES"
elif [ "$OS" = "Void" ]; then
  doas xbps-install -y cabal-install
  sudo ln -sfn /usr/lib/libncursesw.so.6 /usr/lib/libtinfo.so.6
  sudo ln -sfn /usr/lib/libncursesw.so.6 /usr/lib/libtinfo.so
  VOID_PKGS="pkg-config autoconf xorg-minimal xscreensaver feh xdotool w3m neofetch lxappearance clipmenu xz make gcc gmp-devel dunst wmname alsa-lib-devel emacs-gtk3 alsa-utils pulseaudio flameshot volumeicon blueman mpc mpd jq redshift conky playerctl dunst libX11-devel libXinerama-devel libXrandr-devel libuuid libXft-devel libXScrnSaver-devel dzen2 trayer-srg CopyQ NetworkManager network-manager-applet numlockx hardinfo setxkbmap xinput xmodmap pandoc jq xrandr tmux yad bat htop i3lock keychain kdeconnect neovim ncdu rsync sox tree ntp xhost xdo starship btop wget go xclip dmg2img os-prober efibootmgr newsboat kitty xterm mesa-dri xtools glxinfo polkit hidapi-devel libgusb-devel xsetroot opendoas desktop-file-utils mdadm dmraid locate rofi hidapi-devel cmake fish polybar pavucontrol xorg-fonts xorg-apps openvpn luarocks lua-devel"
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
  doas sv status polkitd
  doas sv status dbus
elif [ "$OS" = "Solus" ]; then
  sudo ln -sfn /usr/lib/libncursesw.so.5.9 /usr/lib/libtinfo.so
  if ! sudo ln -sfn /usr/lib/libncursesw.so.5.9 /usr/lib/libtinfo.so.5.9; then
    echo "Solution: error while loading shared libraries: libtinfo.so.5: cannot open shared object file: No such file or directory"
  fi
  doas eopkg install -y gcc
  doas eopkg install -y gettext-devel
  doas eopkg install -y libgtk-3-devel

  nix-env -i dzen2
  nix-env -i volumeicon

  mkdir -p d "$HOME/projects/github.com/Maato"
  cd "$HOME/projects/github.com/Maato" || exit
  git clone git@github.com:Maato/volumeicon.git
  cd ./volumeicon || exit
  ./autogen.sh
  ./configure
  make
  doas make install
  cd "$HOME" || exit
  SOLUS_PKGS="xmonad pkg-config feh xdotool w3m xz make gmp-devel libffi zlib dunst alsa-lib-devel alsa-utils pulseaudio libxscrnsaver-devel libxrandr-devel libxft-devel xdo libxpm-devel flameshot blueman copyq mpd mpc-client neofetch jq redshift font-awesome-4 conky playerctl picom dzen2 xappearance xscreensaver wmname clipmenu pandoc jq pavucontrol tmux rofi fish"
  FAILURE=""
  doas eopkg install -c system.devel
  for i in $SOLUS_PKGS; do
    if ! sudo eopkg install -y "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo "Failures: $FAILURE"
  echo "need dzen2"
elif [ "$OS" = "Gentoo" ]; then
  doas usermod -aG tty "$(id -un)"
  doas usermod -aG video "$(id -un)"
  # elogind
  GENTOO_PKGS="rust-bin neovim setxkbmap dzen i3lock x11-misc/xsensors qalculate-gtk hddtemp xscreensaver feh xdotool dunst wmname w3m x11-misc/xclip xinit xorg-server sys-apps/dbus flameshot volumeicon neofetch blueman dev-qt/qtwaylandscanner copyq clipmenu media-sound/mpc mpd net-wireless/blueman redshift playerctl conky net-misc/networkmanager numlockx nm-applet trayer-srg sxiv spacefm lxappearance xrandr hardinfo gentoolkit xmodmap app-misc/jq pavucontrol xinput neovim lsof sddm htop eix libreoffice-bin firefox-bin app-misc/screen pcmanfm rdfind zenity net-dns/bind-tools tmux bat whois starship traceroute kitty imagemagick colordiff media-fonts/terminus-font efibootmgr genfstab byobu dev-libs/tree-sitter luarocks alacritty ufw xdo pipewire pass pwgen tree keychain partimage ntfs3g dosfstools mtools ncdu speedtest-cli ntp nmap xhost btop dmg2img solaar elinks os-prober sys-fs/btrfs-progs sys-fs/udftools kpcli usbutils zbar xsetroot doas desktop-file-utils dmraid mdadm locate rofi gptfdisk wipe eselect-python dev-python/pip volctl usbimagewriter fish x11-themes/gtk-engines-murrine media-libs/libcanberra net-p2p/syncthing polybar openvpn hwinfo distrobox"
  FAILURE=""
  ls -d /var/db/pkg/*/*| cut -f5- -d/
  for i in $GENTOO_PKGS; do
    if ! command -v "$i"; then
      if ! sudo emerge --update --newuse "$i"; then
        FAILURE="$i $FAILURE"
      fi
    fi
  done
  doas usermod -a -G audio "$(id -un)"
  sudo ln -sfn /usr/bin/trayer-srg /usr/bin/trayer
  if ! command -v systemctl; then
    doas rc-update add dbus default
    doas rc-update add elogind default
    doas rc-update add bluetooth default
    doas rc-update add NetworkManager default
    doas rc-service NetworkManager start
  else
    doas systemctl enable NetworkManager.service
    doas systemctl start NetworkManager.service
    doas systemctl enable bluetooth.service
    doas systemctl start bluetooth.service
    doas systemctl enable cronie
    doas systemctl start cronie
  fi

  sudo mkdir -p /usr/share/backgrounds/images/

  mkdir -p "$HOME/projects/github.com/baskerville"
  cd "$HOME/projects/github.com/baskerville" || exit
  git clone git@github.com:baskerville/xdo.git
  cd ./xdo || exit
  make
  doas make install
  echo "Failures: $FAILURE"
elif [ "$OS" = "Fedora Linux" ]; then
  sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
  sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
  doas dnf makecache
  doas dnf groupinstall "Development Tools" "Development Libraries"
  # echo not sure if this works
  # echo sudo ln -sfn /usr/lib64/libncursesw.so.6 /usr/lib64/libtinfo.so.6

  # sudo dnf remove -y lightdm
  # sudo dnf remove -y gdm
  # sudo dnf remove -y lxdm
  # sudo dnf install -y clipmenu
  doas dnf install -y xorg-x11-server-Xorg
  doas dnf install -y polybar
  doas dnf install -y syncthing
  doas dnf install -y libtool
  doas dnf install -y locate
  doas dnf install -y dmraid
  doas dnf install -y mdadm
  doas dnf install -y alacritty
  doas dnf install -y alsa-lib-devel
  doas dnf install -y bat
  doas dnf install -y btop
  doas dnf install -y blueman
  doas dnf install -y bluez
  doas dnf install -y bridge-utils
  doas dnf install -y conky
  doas dnf install -y copyq
  doas dnf install -y dmenu
  doas dnf install -y desktop-file-utils
  doas dnf install -y doas
  doas dnf install -y dbus-x11
  doas dnf install -y dunst
  doas dnf install -y dmg2img
  doas dnf install -y elinks
  # sudo dnf install -y dzen2
  doas dnf install -y flameshot
  doas dnf install -y feh
  doas dnf install -y fish
  doas dnf install -y g++
  doas dnf install -y gtk2-devel
  doas dnf install -y htop
  doas dnf install -y i3lock
  doas dnf install -y ImageMagick
  doas dnf install -y jq
  doas dnf install -y keychain
  doas dnf install -y kitty
  doas dnf install -y kpcli
  doas dnf install -y kdeconnect
  doas dnf install -y libXScrnSaver-devel
  doas dnf install -y lxsession
  doas dnf install -y libXft-devel
  doas dnf install -y libXpm-devel
  doas dnf install -y libXinerama-devel
  doas dnf install -y libX11-devel
  doas dnf install -y libXrandr-devel
  doas dnf install -y libreoffice
  doas dnf install -y mpc
  doas dnf install -y mpd
  doas dnf install -y neovim
  doas dnf install -y neofetch
  doas dnf install -y network-manager-applet
  doas dnf install -y nmap
  doas dnf install -y numlockx
  doas dnf install -y ncdu
  doas dnf install -y ntpsec
  doas dnf install -y pavucontrol
  doas dnf install -y partimage
  doas dnf install -y pandoc
  doas dnf install -y powerline
  doas dnf install -y powerline-fonts
  doas dnf install -y openssl
  doas dnf install -y rsync
  doas dnf install -y rofi
  doas dnf install -y rdfind
  doas dnf install -y sxhkd
  doas dnf install -y slock
  doas dnf install -y sox
  doas dnf install -y speedtest-cli
  doas dnf install -y tree
  doas dnf install -y thunar
  doas dnf install -y trayer
  doas dnf install -y volumeicon
  doas dnf install -y w3m
  doas dnf install -y wmname
  doas dnf install -y xclip
  doas dnf install -y xdotool
  doas dnf install -y xsetroot
  doas dnf install -y xscreensaver
  doas dnf install -y yad
  doas dnf install -y yubikey-manager-qt
  doas dnf install -y clang-devel
  # sudo dnf install -y cmake-fedora
  doas dnf install -y llvm-libs
  doas dnf install -y llvm-devel
  doas dnf install -y golang
  doas dnf install -y luarocks
  doas dnf install -y openssh-server
  doas systemctl start sshd.service
  doas systemctl enable sshd.service
  echo iwlib missing
  mkdir -p "$HOME/projects/github.com/baskerville"
  cd "$HOME/projects/github.com/baskerville" || exit
  git clone https://github.com/baskerville/xdo.git
  cd $HOME/projects/github.com/baskerville/xdo || exit
  doas make install

  mkdir -p "$HOME/projects/github.com/sargon"
  cd "$HOME/projects/github.com/sargon" || exit
  git clone https://github.com/sargon/trayer-srg.git
  cd $HOME/projects/github.com/sargon/trayer-srg
  ./configure
  doas make install
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

# vim: set ft=sh:
