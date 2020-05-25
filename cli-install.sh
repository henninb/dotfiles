#!/usr/bin/env sh

# DEBIAN_FRONTEND=noninteractive

CENTOS_PKGS="epel-release mpg123 gcc ncurses-devel screen figlet neovim vim rtorrent wget ranger fx zsh gpg fossil subversion git mutt neomutt irssi htop nmon nmap python-pip libnova ffmpeg yarn alsa-utils cmus rsync tmux emacs stunnel wine mcrypt fetchmail pass fish lastpass-cli neofetch zip unzip grip urlscan elinks task-spooler newsboat"

FEDORA_PKGS="mpg123 gcc ncurses-devel screen figlet neovim vim rtorrent wget ranger fx zsh gpg fossil subversion git mutt neomutt irssi htop nmon nmap python-pip libnova ffmpeg yarn alsa-utils cmus rsync tmux emacs stunnel wine mcrypt fetchmail pass fish lastpass-cli toilet strace rmlint w3m zsync neofetch vifm sxhkd zip unzip lnav festival tig mpd ncmpcpp jq tig trash-cli dash nnn fd ncdu grip urlscan elinks task-spooler newsboat"

ARCHLINUX_PKGS="pacman-contrib mpg123 screen figlet neovim vim rtorrent wget ranger fx zsh gnupg fossil subversion git mutt neomutt irssi htop nmon nmap python-pip libnova ffmpeg yarn alsa-utils cmus terminus-font netcat unzip zip zsync emacs tmux stunnel wine mcrypt dos2unix pass fish ctags astyle clang-format lynx sshfs toilet rmlint w3m scim rsync screenfetch scrot sxhkd vifm neofetch ripgrep dust sshpass calcuse lnav tmate most festival shellcheck ddgr tig mpd ncmpcpp mtr nnn trash-cli ncdu transmission-cli dash checkbashisms grip urlscan elinks urlview task-spooler newsboat lastpass-cli"

MINT_PKGS="jq stunnel postfix mailutils mpg123 screen figlet vim rtorrent wget zsh gpg fossil subversion git mutt neomutt irssi htop nmon nmap python-pip libnova ffmpeg alsa-utils cmus python-setuptools rsync tmux mcrypt wine64 yarn nodejs ssh-askpass iptables-persistent libguestfs-tools byobu fetchmail dos2unix pass fish ctags strace astyle clang-format rpm bastet mpv sshfs lynx etherwake cdrecord toilet zsync newsboat scrot sxhkd imagemagick vifm w3m-img groff zip unzip neofetch ripgrep sshpass calcurse lnav tmate most festival shellcheck ddgr tig mtr nnn trash-cli colordiff ncdu locate fd-find grip urlscan elinks urlview task-spooler"

CLEAR_PKGS="jq stunnel postfix mailutils mpg123 screen figlet vim rtorrent wget zsh gpg fossil subversion git mutt neomutt irssi htop nmon nmap python-pip libnova ffmpeg alsa-utils cmus python-setuptools rsync tmux mcrypt wine64 yarn nodejs ssh-askpass iptables-persistent libguestfs-tools byobu fetchmail dos2unix pass fish ctags strace astyle clang-format rpm bastet mpv sshfs lynx etherwake cdrecord toilet zsync newsboat scrot sxhkd imagemagick vifm w3m-img groff zip unzip neofetch ripgrep sshpass calcurse lnav tmate most festival shellcheck ddgr tig mtr nnn trash-cli colordiff ncdu locate fd-find grip urlscan elinks urlview task-spooler"

SUSE_PKGS="jq stunnel postfix mailutils mpg123 screen figlet vim rtorrent wget zsh gpg fossil subversion git mutt neomutt irssi htop nmon nmap python-pip libnova ffmpeg alsa-utils cmus python-setuptools rsync tmux mcrypt wine64 yarn nodejs ssh-askpass iptables-persistent libguestfs-tools byobu fetchmail dos2unix pass fish ctags strace astyle clang-format rpm bastet mpv sshfs lynx etherwake cdrecord toilet zsync newsboat scrot sxhkd imagemagick vifm w3m-img groff zip unzip neofetch ripgrep sshpass calcurse lnav tmate most festival shellcheck ddgr tig mtr nnn trash-cli colordiff fd grip urlscan urlview task-spooler"

UBUNTU_PKGS="jq stunnel postfix mailutils mpg123 screen figlet vim rtorrent wget ranger fx zsh gpg fossil subversion git mutt neomutt irssi htop nmon nmap python-pip ffmpeg alsa-utils cmus python-setuptools rsync tmux emacs mcrypt wine yarn ssh-askpass iptables-persistent libguestfs-tools fetchmail dos2unix pass fish clang-format clisp rpm nsnake bastet netcat strace astyle ctags mpv sshfs lynx etherwake cdrecord toilet zsync newsboat sxhkd vifm w3m-img neofetch zip unzip lnav most ddgr tig nnn colordiff locate fd-find dash grip elinks urlscan task-spooler"

GENTOO_PKGS="dev-lang/rust-bin postfix stunnel mpg123 app-misc/screen figlet vim rtorrent wget ranger zsh gnupg fossil subversion git mutt neomutt irssi htop nmon nmap tmux rsync libnova ffmpeg alsa-utils cmus dev-python/pip net-misc/netdate emacs mcrypt zip unzip dev-lang/smlnj dev-lisp/clisp layman dos2unix fish pass strace ctags astyle ntp mlton rpm eix bastet lsof sys-fs/fuse pulseaudio vifm sxhkd neofetch sshpass lnav nnn trash-cli colordiff ncdu ripgrep fd app-shells/dash app-text/grip elinks urlscan task-spooler newsboat"

FREEBSD_PKGS="coreutils zip unzip python py36-pip py36-powerline-status-2.7 stunnel mpg123 screen figlet neovim vim rtorrent wget ranger fx zsh gpg fossil subversion git mutt neomutt irssi htop nmon nmap python-pip libnova ffmpeg yarn alsa-utils cmus rsync tmux emacs fish sysutils/password-store bind-tools sxhkd ctags astyle toilet unix2dos fetchmail jq mcrypt mpv scrot vifm neofetch sshpass elinks urlscan task-spooler newsboat"

RASPI_PKGS="jq vim-nox vim wget zsh gpg git mutt htop figlet screen pass neovim stunnel postfix mpg321 ranger mutt irssi nmon nmap libnova clisp fakeroot fish zip unzip dos2unix ctags emacs rsync tmux mcrypt etherwake sshfs cmus ffmpeg mpg123 strace yarn toilet newsboat sxhkd neofetch sshpass calcurse shellcheck tig grip elinks elinks urlscan task-spooler"

MACOS_PKGS="ffmpeg figlet cmus imagemagick neofetch htop screen wget zsh fish zip unzip tmux dos2unix lynx azure-cli astyle emacs qemu ansible go nmap python2 python3 ripgrep exa sshpass reattach-to-user-namespace most shellcheck tig rsync elinks urlscan task-spooler"

VOID_PKGS="fontforge ffmpeg figlet cmus zip unzip ctags astyle toilet unix2dos fish jq neofetch tig most vimfm netcat htop ffmpeg emacs mcrypt tmux screen nmon mpd nnn nmap ntp ntfs-3g rsync elinks udisks2"

SOLUS_PKGS="fontforge ffmpeg figlet cmus zip unzip ctags dos2unix fish jq neofetch tig most vimfm netcat htop ffmpeg emacs mcrypt tmux screen nmon mpd nnn nmap ntp ntfs-3g elinks grip rsync"

mkdir -p .cli
echo "$CENTOS_PKGS" > .cli/centos
echo "$ARCHLINUX_PKGS" > .cli/archlinux
echo "$MINT_PKGS" > .cli/mintlinux
echo "$UBUNTU_PKGS" > .cli/ubuntu
echo "$GENTOO_PKGS" > .cli/gentoo
echo "$FREEBSD_PKGS" > .cli/freebsd
echo "$RASPI_PKGS" > .cli/raspi
echo "$FEDORA_PKGS" > .cli/fedora
echo "$MACOS_PKGS" > .cli/macos
echo "$VOID_PKGS" > .cli/macos

if [ "$OS" = "Linux Mint" ]; then
  FAILURE=""
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
  sudo apt update
  for i in $MINT_PKGS; do
    if ! sudo apt install --download-only -y "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  for i in $MINT_PKGS; do
    if ! sudo apt install -y "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  sudo yarn global add prettier --prefix /usr/local
  echo "Failures: $FAILURE"
elif [ "$OS" = "Clear Linux OS" ]; then
  FAILURE=""
  for i in $CLEAR_PKGS; do
    if ! sudo swupd bundle-add "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo Failures: "$FAILURE"
elif [ "$OS" = "Ubuntu" ]; then
  FAILURE=""
  for i in $UBUNTU_PKGS; do
    if ! sudo apt install -y "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo Failures: "$FAILURE"
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  FAILURE=""
  for i in $SUSE_PKGS; do
    if ! sudo zypper install -y "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo Failures: "$FAILURE"
elif [ "$OS" = "void" ]; then
  FAILURE=""
  for i in $VOID_PKGS; do
    if ! sudo xbps-install -y "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo Failures: "$FAILURE"
elif [ "$OS" = "Solus" ]; then
  FAILURE=""
  for i in $SOLUS_PKGS; do
    if ! sudo eopkg install -y "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo Failures: "$FAILURE"
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ]; then
  FAILURE=""
  yay install webmin
  for i in $ARCHLINUX_PKGS; do
    if ! sudo pacman --noconfirm --needed -S "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo Failures: "$FAILURE"
elif [ "$OS" = "Gentoo" ]; then
  FAILURE=""
  for i in $GENTOO_PKGS; do
    echo "sudo emerge -uf $i"
    sudo emerge -uf "$i"
  done
  for i in $GENTOO_PKGS; do
    if ! sudo emerge --update --newuse "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo "Failures: $FAILURE"
elif [ "$OS" = "FreeBSD" ]; then
  for i in $FREEBSD_PKGS; do
    if ! sudo pkg install -y "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo "Failures: $FAILURE"
elif [ "$OS" = "Raspbian GNU/Linux" ]; then
  for i in $RASPI_PKGS; do
    if ! sudo apt install -y "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo "Failures: $FAILURE"
elif [ "$OS" = "Fedora" ]; then
  sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
  sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
  sudo dnf install dnf-plugins-core
  sudo dnf copr enable flatcap/neomutt
  sudo dnf update -y
  FAILURE=""
  for i in $FEDORA_PKGS; do
    if ! sudo dnf install -y "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo "Failures: $FAILURE"
elif [ "$OS" = "Darwin" ]; then
  for i in $MACOS_PKGS; do
    if ! brew install "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo "Failures: $FAILURE"
  brew cask install alacritty
elif [ "$OS" = "CentOS Linux" ]; then
  if [ "$OS_VER" = "8" ]; then
    echo "centos8"
    sudo dnf update -y
    #sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
    sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
    FAILURE=""
    for i in $CENTOS_PKGS; do
      if ! sudo dnf install -y "$i"; then
        FAILURE="$i $FAILURE"
      fi
    done
    echo "Failures: $FAILURE"
  else
    echo "centos7"
    curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
    sudo rpm --import https://dl.yarnpkg.com/rpm/pubkey.gpg
    sudo cp -v neomutt-epel-7.repo /etc/yum.repos.d/
    sudo yum update -y
    FAILURE=""
    for i in $CENTOS_PKGS; do
      if ! sudo yum install -y "$i"; then
        FAILURE="$i $FAILURE"
      fi
    done
    echo "Failures: $FAILURE"
  fi
else
  echo "OS=$OS not setup yet."
  exit 1
fi

wget -O - https://raw.githubusercontent.com/laurent22/joplin/master/Joplin_install_and_update.sh | bash

wget https://raw.githubusercontent.com/mevdschee/2048.c/master/2048.c -O 2048.c
gcc -o 2048 2048.c
mv 2048 "$HOME/.local/bin"

# install shox
curl -s "https://raw.githubusercontent.com/liamg/shox/master/scripts/install.sh" | sudo bash
sudo rm -rf shox

exit 0
