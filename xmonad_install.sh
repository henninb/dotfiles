#!/usr/bin/env sh

# curl -sSL https://get.haskellstack.org/ | sh
# stack install hindent

# cd projects
# git clone https://github.com/jaagr/polybar.git
# cd polybar
# ./build.sh
# cd $HOME

if [ \( "$OS" = "Linux Mint" \) -o \(  "$OS" = "Ubuntu" \) -o \(  "$OS" = "Raspbian GNU/Linux" \) ]; then
  wget https://downloads.haskell.org/\~cabal/cabal-install-latest/cabal-install-3.0.0.0-x86_64-unknown-linux.tar.xz -O cabal-install-3.0.0.0-x86_64-unknown-linux.tar.xz
  tar xvf cabal-install-3.0.0.0-x86_64-unknown-linux.tar.xz
  mv cabal $HOME/bin
  sudo apt remove -y lightdm gdm lxdm
  sudo apt install -y xmonad xmobar libghc-xmonad-contrib-dev libghc-xmonad-contrib-doc libghc-xmonad-contrib-prof libghc-xmonad-dev  libghc-xmonad-doc libghc-xmonad-extras-dev libghc-xmonad-extras-prof libghc-xmonad-prof libghc-xmonad-wallpaper-dev libghc-xmonad-wallpaper-prof xscreensaver feh nitrogen w3m neofetch dzen2 conky nitrogen
elif [ "$OS" = "Arch Linux" ]; then
  wget https://downloads.haskell.org/\~cabal/cabal-install-latest/cabal-install-3.0.0.0-x86_64-unknown-linux.tar.xz -O cabal-install-3.0.0.0-x86_64-unknown-linux.tar.xz
  mv cabal $HOME/bin
  sudo pacman -Rsnc lightdm gdm lxdm
  sudo pacman --noconfirm --needed -S xmonad
  sudo pacman --noconfirm --needed -S xmobar
  sudo pacman --noconfirm --needed -S xmonad-contrib
  sudo pacman --noconfirm --needed -S xscreensaver
  sudo pacman --noconfirm --needed -S feh
  sudo pacman --noconfirm --needed -S nitrogen
  sudo pacman --noconfirm --needed -S xdotool
  sudo pacman --noconfirm --needed -S cmake
  sudo pacman --noconfirm --needed -S w3m
  sudo pacman --noconfirm --needed -S neofetch
  sudo pacman --noconfirm --needed -S extra/xorg-xfontsel
  sudo pacman --noconfirm --needed -S dzen2
  sudo pacman --noconfirm --needed -S conky
  sudo pacman --noconfirm --needed -S nitrogen
  cd $HOME/projects
  git clone https://aur.archlinux.org/yabar-git.git yabar-aur
  cd yabar-aur
  makepkg -si
  cd $HOME/projects
  git clone https://aur.archlinux.org/lemonbar-git.git lemonbar-aur
  cd lemonbar-aur
  makepkg -si
elif [ "$OS" = "Manjaro Linux" ]; then
  sudo pacman -Rsnc lightdm gdm gdm3 kdm lxdm
  sudo pacman --noconfirm --needed -S xmonad
  sudo pacman --noconfirm --needed -S xmobar
  sudo pacman --noconfirm --needed -S xmonad-contrib
  sudo pacman --noconfirm --needed -S xscreensaver
  sudo pacman --noconfirm --needed -S feh
  sudo pacman --noconfirm --needed -S nitrogen
  sudo pacman --noconfirm --needed -S xdotool
  sudo pacman --noconfirm --needed -S cmake
  sudo pacman --noconfirm --needed -S w3m
  sudo pacman --noconfirm --needed -S neofetch
  sudo pacman --noconfirm --needed -S extra/xorg-xfontsel
  sudo pacman --noconfirm --needed -S dzen2
  sudo pacman --noconfirm --needed -S conky
  sudo pacman --noconfirm --needed -S nitrogen
elif [ "$OS" = "Gentoo" ]; then
  GENTOO_PKGS="xmonad xmobar xmonad-contrib"
  FAILURES=""
  for i in $(echo $GENTOO_PKGS); do
    sudo emerge --update --newuse $i
    if [ 0 -ne $? ]; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo Failures: $FAILURE
elif [ "$OS" = "Fedora" ]; then
  wget https://downloads.haskell.org/\~cabal/cabal-install-latest/cabal-install-3.0.0.0-x86_64-unknown-linux.tar.xz -O cabal-install-3.0.0.0-x86_64-unknown-linux.tar.xz
  tar xvf cabal-install-3.0.0.0-x86_64-unknown-linux.tar.xz
  mv cabal $HOME/bin
  sudo dnf remove -y lightdm gdm lxdm
  sudo dnf install -y ghc
  sudo dnf install -y xmonad
  sudo dnf install -y xmobar
  sudo dnf install -y xmonad ghc-xmonad-contrib
  sudo dnf install -y feh
  sudo dnf install -y rofi
  sudo dnf install -y ranger
  sudo dnf install -y neofetch
  sudo dnf install -y w3m
  sudo dnf install -y xscreensaver
  sudo dnf install -y dzen2
  sudo dnf install -y conky
  sudo dnf install -y nitrogen
elif [ "$OS" = "CentOS Linux" ]; then
  wget https://downloads.haskell.org/\~cabal/cabal-install-latest/cabal-install-3.0.0.0-x86_64-unknown-linux.tar.xz -O cabal-install-3.0.0.0-x86_64-unknown-linux.tar.xz
  tar xvf cabal-install-3.0.0.0-x86_64-unknown-linux.tar.xz
  mv cabal $HOME/bin
  if [ "$OS_VER" = "8" ]; then
    echo centos8
    sudo dnf remove -y lightdm gdm lxdm
    sudo dnf install -y ghc
    sudo dnf install -y xmonad
    sudo dnf install -y xmonad ghc-xmonad-contrib
  else
    echo centos7
    sudo yum remove -y lightdm gdm lxdm
    #wget https://copr.fedorainfracloud.org/coprs/petersen/ghc-8.0.2/repo/epel-7/petersen-ghc-8.0.2-epel-7.repo
    #sudo mv -v petersen-ghc-8.0.2-epel-7.repo /etc/yum.repos.d/petersen-ghc-8.0.2-epel-7.repo
    sudo yum install ghc-8.0.2
    sudo yum install -y xmonad ghc-xmonad-contrib
  fi
else
  echo $OS is not yet implemented.
  exit 1
fi

cd $HOME/projects
git clone git@github.com:xmonad/xmonad.git
cd xmonad
git checkout tags/v0.13
stack setup
stack build
stack install
$HOME/.local/bin/xmonad --version

cd $HOME/projects
git clone git@github.com:jaor/xmobar.git
cd xmobar
git checkout tags/v0.24.5

echo exec xmonad
xmonad --recompile
echo pid of systemd
pidof systemd

echo https://brianbuccola.com/how-to-install-xmonad-and-xmobar-via-stack/
ghc-pkg list

exit 0

#Fields missing from config defaulted: additionalFonts,textOffset,iconOffset,overrideRedirect,pickBroadest,iconRoot,alpha
Mint - xmobar 0.24.5
Arch - xmobar 0.29.5

Mint - xmonad 0.13
Arch - xmonad 0.15
Mint - The Glorious Glasgow Haskell Compilation System, version 8.0.2
Arch - The Glorious Glasgow Haskell Compilation System, version 8.6.5
