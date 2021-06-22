#.profile is not executed by zsh (.zprofile is executed)
# case $(tty) in /dev/tty[0-9]*)
#   setfont ter-powerline-v16b ;;
# esac

# [ -t 0 ] && echo "TTY available" || echo "No TTY available"
if [ -f /etc/os-release ]; then
  OS="$(grep '^NAME=' /etc/os-release | tr -d '"' | cut -d = -f2)"
  OS_VER="$(grep '^VERSION_ID=' /etc/os-release | tr -d '"' | cut -d = -f2)"
elif type lsb_release >/dev/null 2>&1; then
  OS=$(lsb_release -si)
  OS_VER=$(lsb_release -sr)
elif [ -f /etc/lsb-release ]; then
  echo /etc/lsb-release
  OS=$(grep '^DISTRIB_ID=' /etc/lsb-release | tr -d '"' | cut -d = -f2)
  OS_VER=$(grep '^DISTRIB_RELEASE=' /etc/lsb-release | tr -d '"' | cut -d = -f2)
elif [ -f /etc/debian_version ]; then
  OS=Debian
  OS_VER=$(cat /etc/debian_version)
elif [ -f /etc/SuSe-release ]; then
  echo "should not enter here v1"
  return
elif [ -f /etc/redhat-release ]; then
  echo "should not enter here v2"
  return
else
  #FreeBSD branches here.
  OS=$(uname -s)
  OS_VER=$(uname -r)
fi
export OS
export OS_VER

export SUDO_EDITOR=nvim
export VISUAL=nvim
export EDITOR=nvim
export PAGER=less
export OPENER=xdg-open
export READER=zathura
export TERMINAL=alacritty

if [ -x "$(command -v bat)" ]; then
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

### "vim" as manpager
# export MANPAGER='/bin/bash -c "vim -MRn -c \"set buftype=nofile showtabline=0 ft=man ts=8 nomod nolist norelativenumber nonu noma\" -c \"normal L\" -c \"nmap q :qa<CR>\"</dev/tty <(col -b)"'

### "nvim" as manpager
# export MANPAGER="nvim -c 'set ft=man' -"


if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  export BROWSER=elinks
else
  export BROWSER=browser
fi
export GIT_EDITOR=nvim

export PATH=$HOME/.local/bin:$PATH
export XDG_DATA_DIRS="$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:$XDG_DATA_DIRS"
export XDG_DATA_DIRS="/usr/share/ubuntu:/usr/share/gnome:/usr/local/share/:/usr/share:$XDG_DATA_DIRS"
export FONTCONFIG_PATH=/etc/fonts

# clipmenu settings
export CM_SELECTION="primary clipboard"
export CM_DEBUG=0
export CM_OUTPUT_CLIP=1
export CM_MAX_CLIPS=25

# TODO: required for monitor to work at desired resolution
xrandr --output HDMI-1 --mode 2560x1440 2> /dev/null
xrandr --output HDMI-0 --mode 2560x1440 2> /dev/null
xrandr --size 2560x1440 2> /dev/null
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init --path)"

#nix allow non-free packages
export NIXPKGS_ALLOW_UNFREE=1
export PASSWORD_STORE_DIR=~/.local/share/password-store

export GROOVYSH_PROMPT='groovy'

if [ "$OSTYPE" = "linux-gnu" ]; then
  if ! cat /sys/module/hid_apple/parameters/fnmode | grep -q 2; then
    echo 'echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode'
  fi
fi
