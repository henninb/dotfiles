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

if command -v nvim >/dev/null; then
  export SUDO_EDITOR=nvim
  export VISUAL=nvim
  export EDITOR=nvim
else
  export SUDO_EDITOR=vim
  export VISUAL=vim
  export EDITOR=vim
fi
export PAGER=less
export OPENER=xdg-open
export READER=zathura
export TERMINAL=alacritty


# XMONAD_CONFIG_DIR
# XMONAD_DATA_DIR
# XMONAD_CACHE_DIR

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
  export BROWSER=browser-start
fi
export GIT_EDITOR=nvim
export SUDO_EDITOR=vim

export PATH=$HOME/.local/bin:$PATH
export XDG_DATA_DIRS="$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:$XDG_DATA_DIRS"
export XDG_DATA_DIRS="/usr/share/ubuntu:/usr/share/gnome:/usr/local/share/:/usr/share:$XDG_DATA_DIRS"
export FONTCONFIG_PATH=/etc/fonts

# clipmenu settings
export CM_SELECTION="primary clipboard"
export CM_DEBUG=0
export CM_OUTPUT_CLIP=1
export CM_MAX_CLIPS=25

# if tty -s; then
#     echo "I am in a tty" | tee -a "$HOME/tmp/xrandr.log"
# fi

# if command -v xrandr; then
# if [ "$OS" = "ArcoLinux" ] || [ "$OS" = "Arch Linux" ] || [ "$OS" = "Gentoo" ] || [ "$OS" = "void" ]; then
#   echo "Comes from .profile, this logic must be updated in the future." | tee -a "$HOME/tmp/profile.log"
#   # 4k monitor
#   device=$(xrandr | grep " connected " | awk '{ print $1 }' | head -1)
#   # xrandr | tee -a "$HOME/tmp/xrandr.log"
#   date | tee -a "$HOME/tmp/xrandr.log"
#   xrandr >> "$HOME/tmp/xrandr.log" 2>&1
#   date | tee -a "$HOME/tmp/profile.log"
#   echo "$device" | tee -a "$HOME/tmp/profile.log"
#   if xrandr --output "$device" --mode 3840x2160 2> /dev/null; then
#     echo "xrandr --output $device --mode 3840x2160 failed." | tee -a "$HOME/tmp/profile.log"
#   fi
#   xrandr --size 3840x2160 2> /dev/null
# else
#   date | tee -a "$HOME/tmp/xrandr.log"
#   xrandr >> "$HOME/tmp/xrandr.log" 2>&1
#   date | tee -a "$HOME/tmp/profile.log"
#   echo "$device" | tee -a "$HOME/tmp/profile.log"
#   echo "Undesired logic - Comes from .profile, this logic must be updated in the future." | tee -a "$HOME/tmp/profile.log"
#   # TODO: required for 1440p monitor to work at desired resolution
#   device=$(xrandr | grep " connected " | awk '{ print $1 }' | head -1)
#   date | tee -a "$HOME/tmp/profile.log"
#   echo "$device" | tee -a "$HOME/tmp/profile.log"
#   xrandr --output "$device" --mode 2560x1440 2> /dev/null
#   # xrandr --output HDMI-0 --mode 2560x1440 2> /dev/null
#   xrandr --size 2560x1440 2> /dev/null
# fi
# fi

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init --path)"

#nix allow non-free packages
export NIXPKGS_ALLOW_UNFREE=1
export PASSWORD_STORE_DIR=~/.local/share/password-store
export GROOVYSH_PROMPT='groovy'

if ! pgrep ssh-agent &>/dev/null; then
  echo "$(date)" >> "$HOME/tmp/ssh-agent.log"
  echo "starting ssh-agent" >> "$HOME/tmp/ssh-agent.log"
  eval `ssh-agent -s`
  # if [ -f "$HOME/.ssh/id_rsa" ]; then
  #   ssh-add "$HOME/.ssh/id_rsa"
  # fi
  #
  # if [ -f "$HOME/.ssh/id_ed25519" ];then
  #   ssh-add "$HOME/.ssh/id_ed25519"
  # fi
fi

echo "$(date)" >> "$HOME/tmp/ssh-agent.log"
echo "SSH_AUTH_SOCK=$SSH_AUTH_SOCK" >> "$HOME/tmp/ssh-agent.log"

ssh-add -l &>/dev/null
if [ $? -eq 2 ]; then
  echo "$(date)" >> "$HOME/tmp/ssh-agent.log"
  echo "agent restart required" >> "$HOME/tmp/ssh-agent.log"
  #echo pkill ssh-agent
fi

true

# vim: set ft=sh:
