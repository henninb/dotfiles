#!/bin/sh

mkdir -p "$HOME/tmp"

if [ "$OS" = "Linux Mint" ]; then
  sudo apt update | tee -a "$HOME/tmp/update-$$.log"
  # sudo apt upgrade -y --with-new-pkgs | tee -a "$HOME/tmp/update-$$.log"
  sudo apt upgrade -y | tee -a "$HOME/tmp/update-$$.log"
  sudo apt autoremove -y | tee -a "$HOME/tmp/update-$$.log"
  doas apt install -y curl
elif [ "$OS" = "Debian GNU/Linux" ]; then
  sudo apt update | tee -a "$HOME/tmp/update-$$.log"
  # sudo apt upgrade -y --with-new-pkgs | tee -a "$HOME/tmp/update-$$.log"
  sudo apt upgrade -y | tee -a "$HOME/tmp/update-$$.log"
  sudo apt autoremove -y | tee -a "$HOME/tmp/update-$$.log"
  cat /etc/debian_version
elif [ "$OS" = "Ubuntu" ]; then
  export DEBIAN_FRONTEND=noninteractive
  sudo apt update | tee -a "$HOME/tmp/update-$$.log"
  # sudo apt upgrade -y --with-new-pkgs | tee -a "$HOME/tmp/update-$$.log"
  sudo apt upgrade -y | tee -a "$HOME/tmp/update-$$.log"
  sudo apt autoremove -y | tee -a "$HOME/tmp/update-$$.log"
  doas apt install -y curl
elif [ "$OS" = "Darwin" ]; then
  #/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall.sh)"
  xcode-select --install
  softwareupdate -l | tee -a "$HOME/tmp/update-$$.log"
  brew update
  brew upgrade
elif [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt update 2>&1 | tee -a "$HOME/tmp/update-$$.log"
  sudo apt upgrade -y 2>&1 | tee -a "$HOME/tmp/update-$$.log"
  sudo apt autoremove -y 2>&1 | tee -a "$HOME/tmp/update-$$.log"
elif [ "$OS" = "Solus" ]; then
  sudo eopkg upgrade -y | tee -a "$HOME/tmp/update-$$.log"
elif [ "$OS" = "Void" ]; then
  doas xbps-install -yu xbps
  sudo xbps-remove -yO | tee -a "$HOME/tmp/update-$$.log"
  sudo xbps-remove -yo | tee -a "$HOME/tmp/update-$$.log"
  sudo vkpurge rm all | tee -a "$HOME/tmp/update-$$.log"
  sudo xbps-install -u xbps | tee -a "$HOME/tmp/update-$$.log"
  sudo xbps-install -Suy | tee -a "$HOME/tmp/update-$$.log"
elif [ "$OS" = "Alpine Linux" ]; then
  sudo apk update | tee -a "$HOME/tmp/update-$$.log"
  sudo apk upgrade | tee -a "$HOME/tmp/update-$$.log"
elif [ "$OS" = "Manjaro Linux" ]; then
  sudo pacman --noconfirm --needed -Syu 2>&1 | tee -a "$HOME/tmp/update-$$.log"
  yay -Syu | tee -a "$HOME/tmp/update-$$.log"
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  du -sh /var/cache/pacman/pkg
  #sudo pacman -S archlinux-keyring #invalid or corrupted package (PGP signature)
  doas pacman --noconfirm --needed -S archlinux-keyring
  sudo pacman --noconfirm --needed -Syu 2>&1 | tee -a "$HOME/tmp/update-$$.log"
  echo sudo pacman -Scc
  sudo paccache -r 2>&1 | tee -a "$HOME/tmp/update-$$.log"
  sudo paccache -rk 1 2>&1 | tee -a "$HOME/tmp/update-$$.log"
  sudo paccache -ruk0 2>&1 | tee -a "$HOME/tmp/update-$$.log"
  yay --noconfirm --needed -Syu 2>&1 | tee -a "$HOME/tmp/update-$$.log"
  echo sudo pacman --noconfirm -S linux
  echo sudo mkinitcpio -p linux
  efibootmgr
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  # sudo zypper dist-upgrade
  # doas zypper --non-interactive dup
  doas zypper --non-interactive dist-upgrade --allow-vendor-change --auto-agree-with-licenses
  doas zypper --non-interactive refresh
  doas zypper --non-interactive --auto-agree-with-licenses update
elif [ "$OS" = "Gentoo" ]; then
  doas eselect news read
  if ! sudo emerge --sync 2>&1 | tee -a "$HOME/tmp/update-$$.log"; then
    sudo emerge-webrsync 2>&1 | tee -a "$HOME/tmp/update-$$.log"
  fi
  sudo emerge -uN portage 2>&1 | tee -a "$HOME/tmp/update-$$.log"
  sudo emerge -uDUNf --keep-going --with-bdeps=y @world 2>&1 | tee -a "$HOME/tmp/update-$$.log"
  sudo emerge -uDUN --keep-going --with-bdeps=y @world 2>&1 | tee -a "$HOME/tmp/update-$$.log"
  sudo emerge --depclean 2>&1 | tee -a "$HOME/tmp/update-$$.log"
  doas revdep-rebuild
  doas emerge @preserved-rebuild
  kernel_list=$(eselect kernel list)
  versions=$(echo "$kernel_list" | awk -F ' ' '{print $2}')
  sorted_versions=$(printf '%s\n' "${versions[@]}" | sort -r)
  # newest_kernel="${sorted_versions[0]}"
  newest_kernel=$(echo $sorted_versions  | head -1 | awk '{print $1}')
  doas eselect kernel set "$newest_kernel"
  uname=$(uname -srm | cut -d' ' -f2 | cut -d- -f1)
  eselect=$(eselect kernel list | tail -1 | cut -d- -f2)
  if [ ! "${eselect}" = "${uname}" ]; then
    if [ ! -f "/boot/vmlinuz-${eselect}-gentoo-x86_64" ]; then
      echo "complie the kernel '$eselect' as it is newer than '$uname'"
      doas genkernel all
      # doas genkernel --no-microcode --install all
      doas grub-mkconfig -o /boot/grub/grub.cfg
    fi
  fi

  # blender=$(find /usr/bin -name "blender-*[0-9]")
  # if [ -z ${blender+x} ]; then echo "var is unset"; else sudo ln -sfn "${blender}" /usr/bin/blender; fi

  blender=$(find /usr/bin -name "blender-*[0-9]" -print -quit)
  if [ -z "${blender}" ]; then
    echo "Blender executable not found."
  else
    sudo ln -sfn "${blender}" /usr/bin/blender
  fi


  librewolf=$(find /usr/bin -name "librewolf-bin")
  if [ -z ${librewolf+x} ]; then echo "var is unset"; else sudo ln -sfn "${librewolf}" /usr/bin/librewolf; fi
  echo eselect editor list
  echo eselect kernel list
  echo eselect python list
  echo eselect java list
  echo emerge --depclean -p
  echo sudo etc-update
  echo revdep-rebuild
  echo sudo emerge --update --newuse --deep --changed-use --keep-going @world
  efibootmgr
elif [ "$OS" = "CentOS Linux" ]; then
  if [ "$OS_VER" = "8" ]; then
    sudo dnf update -y | tee -a "$HOME/tmp/update-$$.log"
    sudo dnf upgrade -y | tee -a "$HOME/tmp/update-$$.log"
  else
    sudo yum update -y | tee -a "$HOME/tmp/update-$$.log"
    sudo yum upgrade -y | tee -a "$HOME/tmp/update-$$.log"
  fi
elif [ "$OS" = "Fedora Linux" ]; then
    sudo dnf update -y | tee -a "$HOME/tmp/update-$$.log"
    sudo dnf upgrade -y | tee -a "$HOME/tmp/update-$$.log"
    doas dnf distro-sync
    echo sudo dnf remove $(dnf repoquery --installonly --latest-limit 2 -q)
    doas dnf install kernel --best
    sudo grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
    efibootmgr
elif [ "$OS" = "FreeBSD" ]; then
  #sudo freebsd-update fetch
  #sudo freebsd-update install
  sudo freebsd-update fetch install 2>&1 | tee -a "$HOME/tmp/update-$$.log"
  sudo pkg upgrade 2>&1 | tee -a "$HOME/tmp/update-$$.log"
  echo sudo pkg clean
  echo sudo pkg update -f
  echo sudo pkg bootstrap
elif [ "$OS" = "OpenBSD" ]; then
  echo "openbsd"
elif [ "$OS" = "Slackware" ]; then
  echo "Slackware"
elif [ "$OS" = "Clear Linux OS" ]; then
  echo "clearlinux"
else
  echo "$OS is not yet implemented."
  exit 1
fi

#golang_ver=$(curl -s 'https://golang.org/VERSION?m=text')
golang_ver=$(curl -s 'https://go.dev/VERSION?m=text')

if ! command -v go; then
  echo "golang needs to be installed"
else
  if echo "$(go version)" | grep -q "$golang_ver"; then
  #if grep -q "$golang_ver" <<< "$(go version)"; then
    echo "golang is already up to date"
  else
    echo "updating golang"
  fi
  go version
fi

if ! command -v stack; then
  echo "stack is being installed"
  curl -sSL 'https://get.haskellstack.org' | sh
  stack --version
else
  stack update
  stack upgrade
  echo "stack version"
  stack --version
fi

if ! command -v nvm; then
  echo "nvm needs to be installed."
else
  nvm install --lts
  echo "npm version"
  npm --version
fi

if ! command -v rustup; then
  curl --proto '=https' --tlsv1.2 -sSf 'https://sh.rustup.rs' > "$HOME/tmp/rustup-init"
  chmod 755 "$HOME/tmp/rustup-init"
  cd "$HOME/tmp" || exit
  ./rustup-init -y --no-modify-path
  cd - || exit
else
  rustc --version
  rustup update
  rustc --version
fi

if ! command -v flatpak; then
  echo "flatpak needs to be installed."
else
  flatpak update --user -y
fi


if ! command -v nix-env; then
  echo "nix needs to be installed."
else
  # nix-env -u
  nix-env -u '.*'
fi

doas luarocks install lustache
doas luarocks install luasocket
doas luarocks install lua-resty-http
doas luarocks install luacheck
# curl -sSL https://github.com/bungle/lua-resty-nettle/archive/v1.5.tar.gz
doas luarocks install perimeterx-nginx-plugin

cargo install starship
cargo install alacritty
cargo install du-dust
cargo install bat
cargo install ripgrep
cargo install fd-find
cargo install broot
# cargo install wezterm

ln -sfn $HOME/.local/share/cargo/bin/alacritty $HOME/.local/bin/alacritty

go install github.com/jesseduffield/lazygit@latest
# go env -w GO111MODULE=off
# go get github.com/gokcehan/lf
go install github.com/gokcehan/lf@latest
go install github.com/charmbracelet/glow@latest
go install github.com/gopasspw/gopass@latest
go install github.com/moncho/dry@latest
go install github.com/Bios-Marcel/cordless@latest
go install github.com/arduino/arduino-cli@latest
# export GO111MODULE=on
# go get -u github.com/arduino/arduino-cli
# export GO111MODULE=off

# Download the latest release information from the nvm GitHub repository using the GitHub API
# latest_release=$(curl -s https://api.github.com/repos/nvm-sh/nvm/releases/latest)

# Extract the latest version tag from the release information using jq
# latest_version=$(echo "$latest_release" | jq -r '.tag_name')
# echo $latest_version

# nvm --version
# nvm install --lts --latest-npm

if ! npm update wrangler; then
  npm install -g wrangler
fi

if ! npm update netlify-cli; then
  npm install -g netlify-cli
fi

if ! npm update heroku; then
  npm install -g heroku
fi

if ! npm update yarn; then
  npm install -g yarn
fi

if ! npm update @bitwarden/cli; then
  npm install -g @bitwarden/cli
fi

if ! npm update tree-sitter-cli; then
  npm install -g tree-sitter-cli
fi

if ! npm update neovim; then
  npm install -g neovim
fi

if ! npm update deepl-translator-cli; then
  npm install -g deepl-translator-cli
fi

if ! npm update vercel; then
  npm install -g vercel
fi

if ! npm update npm-check-updates; then
  npm install -g npm-check-updates
fi

if ! npm update serve; then
  npm install -g serve
fi

pip install pyserial --user
pip install youtube-dl --user
pip install yt-dlp --user
pip install holehe --user
pip install ansible --user
pip install platformio --user
pip install esptool --user
pip install pipx --user
pip install pynvim --user
pip install podman-compose --user
pip install leglight --user
pip install streamdeck --user
echo pip install streamdeck-linux-gui --user
echo pip install docker-compose --user
echo pip install awscli --user

exit 0

# vim: set ft=sh:
