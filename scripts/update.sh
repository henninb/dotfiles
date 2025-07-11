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
  LOG="$HOME/tmp/update-$$.log"
  echo ">>> Starting Arch/ArcoLinux update…" | tee -a "$LOG"

  # show cache size (non-fatal)
  du -sh /var/cache/pacman/pkg | tee -a "$LOG" 2>&1 || echo ">>> Warning: could not read pacman cache size" >&2

  # refresh keyring (non-fatal)
  echo ">>> Refreshing keyring…" | tee -a "$LOG"
  if ! doas pacman --noconfirm --needed -S archlinux-keyring | tee -a "$LOG" 2>&1; then
    echo ">>> Warning: archlinux-keyring update failed; continuing…" >&2
  fi

  # first attempt at full system upgrade
  echo ">>> Upgrading system (initial attempt)..."  | tee -a "$LOG"
  if sudo pacman --noconfirm --needed -Syu | tee -a "$LOG" 2>&1; then
    echo ">>> System upgrade succeeded." | tee -a "$LOG"
  else
    echo ">>> pacman -Syu failed; forcing DB refresh and mirrorlist rebuild…" >&2

    # force database refresh
    echo ">>> Forcing DB refresh (pacman -Syy)..." | tee -a "$LOG"
    if ! sudo pacman -Syy --noconfirm | tee -a "$LOG" 2>&1; then
      echo ">>> Error: pacman -Syy failed; aborting." >&2
      exit 1
    fi

    # ensure reflector is installed
    if ! command -v reflector >/dev/null 2>&1; then
      echo ">>> Installing reflector…" | tee -a "$LOG"
      if ! sudo pacman --noconfirm --needed -S reflector | tee -a "$LOG" 2>&1; then
        echo ">>> Error: reflector install failed; aborting." >&2
        exit 1
      fi
    else
      echo ">>> reflector already present." | tee -a "$LOG"
    fi

    # rebuild mirrorlist
    echo ">>> Rebuilding mirrorlist with reflector…" | tee -a "$LOG"
    if ! sudo reflector --latest 10 --sort rate --save /etc/pacman.d/mirrorlist | tee -a "$LOG" 2>&1; then
      echo ">>> Error: mirrorlist rebuild failed; aborting." >&2
      exit 1
    fi

    # final retry
    echo ">>> Retrying system upgrade…" | tee -a "$LOG"
    if ! sudo pacman --noconfirm --needed -Syu | tee -a "$LOG" 2>&1; then
      echo ">>> Error: upgrade still failing after reflector; aborting." >&2
      exit 1
    fi

    echo ">>> System upgrade succeeded after mirrorlist rebuild." | tee -a "$LOG"
  fi

  # cache cleanup (non-fatal)
  for cmd in "paccache -r" "paccache -rk 1" "paccache -ruk0"; do
    echo ">>> Running $cmd…" | tee -a "$LOG"
    sudo $cmd >>"$LOG" 2>&1 || echo ">>> Warning: '$cmd' failed; skipping." >&2
  done

  # AUR update (non-fatal)
  echo ">>> Updating AUR packages via yay…" | tee -a "$LOG"
  if ! yay --noconfirm --needed -Syu | tee -a "$LOG" 2>&1; then
    echo ">>> Warning: AUR update failed; please update manually." >&2
  fi

  # post-update hints
  echo ">>> To install the latest kernel: sudo pacman --noconfirm -S linux" | tee -a "$LOG"
  echo ">>> To rebuild initramfs:   sudo mkinitcpio -p linux"  | tee -a "$LOG"

  # UEFI entries check (non-fatal)
  if ! efibootmgr | tee -a "$LOG" 2>&1; then
    echo ">>> Warning: efibootmgr failed; verify UEFI entries manually." >&2
  fi

  echo ">>> Arch/ArcoLinux update completed successfully." | tee -a "$LOG"




  # du -sh /var/cache/pacman/pkg
  # #sudo pacman -S archlinux-keyring #invalid or corrupted package (PGP signature)
  # doas pacman --noconfirm --needed -S archlinux-keyring
  # sudo pacman --noconfirm --needed -Syu 2>&1 | tee -a "$HOME/tmp/update-$$.log"
  # echo sudo pacman -Scc
  # sudo paccache -r 2>&1 | tee -a "$HOME/tmp/update-$$.log"
  # sudo paccache -rk 1 2>&1 | tee -a "$HOME/tmp/update-$$.log"
  # sudo paccache -ruk0 2>&1 | tee -a "$HOME/tmp/update-$$.log"
  # yay --noconfirm --needed -Syu 2>&1 | tee -a "$HOME/tmp/update-$$.log"
  # echo sudo pacman --noconfirm -S linux
  # echo sudo mkinitcpio -p linux
  # efibootmgr
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  # sudo zypper dist-upgrade
  # doas zypper --non-interactive dup
  doas zypper --non-interactive dist-upgrade --allow-vendor-change --auto-agree-with-licenses
  doas zypper --non-interactive refresh
  doas zypper --non-interactive --auto-agree-with-licenses update
elif [ "$OS" = "Gentoo" ]; then
  doas eselect news read

  # Sync Portage
  if ! sudo emerge --sync 2>&1 | tee -a "$HOME/tmp/update-$$.log"; then
    echo ">>> emerge --sync failed; trying emerge-webrsync…" >&2
    if ! sudo emerge-webrsync 2>&1 | tee -a "$HOME/tmp/update-$$.log"; then
      echo ">>> emerge-webrsync also failed; aborting." >&2
      exit 1
    fi
  fi

  sudo emerge -uN portage 2>&1 | tee -a "$HOME/tmp/update-$$.log" \
    || { echo ">>> portage update failed; aborting." >&2; exit 1; }

  sudo emerge -uDUNf --keep-going --with-bdeps=y @world 2>&1 | tee -a "$HOME/tmp/update-$$.log" \
    || { echo ">>> world update (new USE) failed; aborting." >&2; exit 1; }
  sudo emerge -uDUN --keep-going --with-bdeps=y @world 2>&1 | tee -a "$HOME/tmp/update-$$.log" \
    || { echo ">>> world update failed; aborting." >&2; exit 1; }

  sudo emerge --depclean 2>&1 | tee -a "$HOME/tmp/update-$$.log" || echo ">>> depclean warnings; continuing."
  doas revdep-rebuild      || echo ">>> revdep-rebuild issues; check manually."
  doas emerge @preserved-rebuild || echo ">>> preserved-rebuild issues; check manually."

  # —— Gentoo kernel detection & conditional compile ——
  echo ">>> Detecting installed kernels…" | tee -a "$HOME/tmp/update-$$.log"
  kernel_list=$(eselect kernel list 2>&1) || { echo ">>> Failed to list kernels; aborting." >&2; exit 1; }
  sorted_versions=$(printf "%s\n" "$kernel_list" | awk '{print $2}' | grep '^linux-' | sort -V) \
    || { echo ">>> Failed to sort kernel versions; aborting." >&2; exit 1; }

  newest_kernel=$(printf "%s\n" "$sorted_versions" | tail -n1)
  [ -n "$newest_kernel" ] || { echo ">>> No kernel versions found; aborting." >&2; exit 1; }

  echo ">>> Newest kernel available: $newest_kernel" | tee -a "$HOME/tmp/update-$$.log"
  doas eselect kernel set "$newest_kernel" \
    || { echo ">>> eselect kernel set failed; aborting." >&2; exit 1; }

  # what's actually running?
  current_uname=$(uname -r | cut -d- -f1)
  echo ">>> System running: $current_uname" | tee -a "$HOME/tmp/update-$$.log"

  version=${newest_kernel#linux-}
  vmlinuz="/boot/vmlinuz-${version}-x86_64"
  echo $vmlinuz

  if [ "$current_uname" = "$newest_kernel" ]; then
    echo ">>> Running kernel matches newest; no compile needed." | tee -a "$HOME/tmp/update-$$.log"
  else
    if [ -f "$vmlinuz" ]; then
      echo ">>> Kernel $newest_kernel already built but not in use." | tee -a "$HOME/tmp/update-$$.log"
      echo ">>> Please reboot to switch from $current_uname to $newest_kernel." | tee -a "$HOME/tmp/update-$$.log"
    else
      echo ">>> Compiling kernel $newest_kernel…" | tee -a "$HOME/tmp/update-$$.log"
      doas genkernel all 2>&1 | tee -a "$HOME/tmp/update-$$.log" \
        || { echo ">>> genkernel failed; aborting." >&2; exit 1; }

      echo ">>> Regenerating GRUB config…" | tee -a "$HOME/tmp/update-$$.log"
      doas grub-mkconfig -o /boot/grub/grub.cfg 2>&1 | tee -a "$HOME/tmp/update-$$.log" \
        || { echo ">>> grub-mkconfig failed; aborting." >&2; exit 1; }
    fi
  fi
  echo ">>> Gentoo section complete." | tee -a "$HOME/tmp/update-$$.log"














































  # blender=$(find /usr/bin -name "blender-*[0-9]")
  # if [ -z ${blender+x} ]; then echo "var is unset"; else sudo ln -sfn "${blender}" /usr/bin/blender; fi

  blender=$(find /usr/bin -name "blender-*[0-9]" | head -n 1)
  if [ -z "${blender}" ]; then
    echo "Blender executable not found."
  else
    sudo ln -sfn "${blender}" /usr/bin/blender
  fi

  librewolf=$(find /usr/bin -name "librewolf-bin")
  if [ -z "${librewolf}" ]; then echo "var is unset"; else sudo ln -sfn "${librewolf}" /usr/bin/librewolf; fi
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

if ! command -v go >/dev/null 2>&1; then
  echo "golang needs to be installed"
else
  if echo "$(go version)" | grep -q "$golang_ver"; then
    echo "golang is already up to date"
  else
    echo "updating golang"
  fi
  go version
fi

if ! command -v stack >/dev/null 2>&1; then
  echo "stack is being installed"
  curl -sSL 'https://get.haskellstack.org' | sh
  stack --version
else
  stack update
  stack upgrade
  echo "stack version"
  stack --version
fi

if ! command -v nvm >/dev/null 2>&1; then
  echo "nvm needs to be installed."
else
  nvm install --lts
  echo "npm version"
  npm --version
fi

if ! command -v rustup >/dev/null 2>&1; then
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

if ! command -v flatpak >/dev/null 2>&1; then
  echo "flatpak needs to be installed."
else
  flatpak update --user -y
fi


if ! command -v nix-env >/dev/null 2>&1; then
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

ln -sf "$HOME/.local/share/cargo/bin/alacritty" "$HOME/.local/bin/alacritty"

go install github.com/jesseduffield/lazygit@latest
# go env -w GO111MODULE=off
# go get github.com/gokcehan/lf
go install github.com/gokcehan/lf@latest
go install github.com/charmbracelet/glow@latest
go install github.com/gopasspw/gopass@latest
go install github.com/moncho/dry@latest
go install github.com/Bios-Marcel/cordless@latest
go install github.com/arduino/arduino-cli@latest
go install github.com/jaeles-project/gospider@latest
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

if ! npm update wrangler >/dev/null 2>&1; then
  npm install -g wrangler
fi

if ! npm update netlify-cli >/dev/null 2>&1; then
  npm install -g netlify-cli
fi

# if ! npm update heroku; then
  # npm install -g heroku
# fi

if ! npm update yarn >/dev/null 2>&1; then
  npm install -g yarn
fi

if ! npm update @bitwarden/cli >/dev/null 2>&1; then
  npm install -g @bitwarden/cli
fi

if ! npm update tree-sitter-cli >/dev/null 2>&1; then
  npm install -g tree-sitter-cli
fi

if ! npm update neovim >/dev/null 2>&1; then
  npm install -g neovim
fi

if ! npm update deepl-translator-cli >/dev/null 2>&1; then
  npm install -g deepl-translator-cli
fi

if ! npm update vercel >/dev/null 2>&1; then
  npm install -g vercel
fi

if ! npm update commitlint >/dev/null 2>&1; then
  npm install -g commitlint
fi

if ! npm update npm-check-updates >/dev/null 2>&1; then
  npm install -g npm-check-updates
fi

if ! npm update serve >/dev/null 2>&1; then
  npm install -g serve
fi

if ! npm update claude-code >/dev/null 2>&1; then
  npm install -g claude-code
fi



pip install -U pyserial --user
pip install -U youtube-dl --user
pip install -U yt-dlp --user
pip install -U holehe --user
pip install -U ansible --user
pip install -U platformio --user
pip install -U esptool --user
pip install -U pipx --user
pip install -U pynvim --user
pip install -U podman-compose --user
pip install -U leglight --user
pip install -U streamdeck --user
pip install -U awscli --user
pip install -U objection --user
pip install -U youbikey-manager --user
pip install -U certbot --user
pip install -U js-beautify --user
echo pip install streamdeck-linux-gui --user
echo pip install docker-compose --user

echo yt-dlp -x --audio-format mp3

exit 0

# vim: set ft=sh:
