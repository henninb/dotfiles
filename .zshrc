# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# TODO: needs to be tested
#[ $- != *i* ] && return
# [[ $- != *i* ]] && return

# TODO: test this further
if [ "$0" = "zsh" ]; then
  MYSHELL=zsh
elif [ "$0" = "bash" ]; then
  MYSHELL=bash
else
  MYSHELL=$(ps -o args= -p $$ | grep -E -m 1 -o '\w{0,5}sh'| head -1)
fi
export MYSHELL

[ -z "$MYSHELL" ] && echo "SHELL not found: dollar zero $0 and need to find a fix."

# export OS
# export OS_VER

# if [ "$OS" = "Darwin" ]; then
#   ZSH_THEME="agnoster"
# else
#   ZSH_THEME="spaceship"
# #  ZSH_THEME="dracula"
# fi

if [ ! -x "$(command -v unzip)" ]; then
  echo unzip not installed.
fi

if [ ! -x "$(command -v fc-cache)" ]; then
  echo fc-cache not installed.
fi

# if [ "$MYSHELL" = "zsh" ]; then
#   [ -f "$HOME/.autojump/etc/profile.d/autojump.sh" ] && source $HOME/.autojump/etc/profile.d/autojump.sh
#   [ -f "$HOME/.autojump/etc/profile.d/autojump.sh" ] && autoload -U compinit && compinit -u
# fi

# TODO: test this, not sure if/how this works
HISTORY_IGNORE="(ls|cd)"
export HISTORY_IGNORE

if [ "${OSTYPE}" = "linux-gnu" ] || [ "${OSTYPE}" = "linux" ]; then
  if [ "${OS}" = "Gentoo" ]; then
    if [ -x "$(command -v java-config)" ]; then
      JAVA_HOME=$(java-config -o) 2> /dev/null
      export JAVA_HOME
    else
      echo "install java-config on gentoo"
    fi
  elif [ -x "$(command -v javac)" ]; then
    JAVA_HOME=$(dirname "$(dirname "$(readlink -f "$(readlink -f "$(which javac)")" || readlink -f "$(which javac)")")")
    export JAVA_HOME
  else
    echo JAVA_HOME is not setup.
  fi
elif [ "${OSTYPE}" = "linux-gnueabihf" ]; then
  echo "WARN: stop using java8"
  JAVA_HOME=/usr/lib/jvm/java-17-openjdk-armhf
  export JAVA_HOME
elif [ "$OS" = "Darwin" ]; then
  # JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"
  JAVA_HOME="$(/usr/libexec/java_home)"
  export JAVA_HOME
elif [ "$OS" = "FreeBSD" ]; then
  JAVA_HOME=/usr/local/openjdk17
  export JAVA_HOME
else
  echo JAVA_HOME is not setup.
fi

export PATH="$HOME/Applications:$PATH"
export PATH="/opt/yubico-authenticator:$PATH"
export PATH="$HOME/.ghcup/bin:$PATH"
export PATH="$HOME/.nix-profile/bin:$PATH"
export PATH="$HOME/scripts:$PATH"
export PATH="$HOME/python/streamdeck-env/bin:$PATH"
export PATH="$HOME/.local/share/bin:$PATH"
export PATH=$PYENV_ROOT/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
# npm bin -g
export PATH="/usr/local/opt/openjdk@17/bin:$PATH"
export PATH="$HOME/.local/share/npm/bin:$PATH"
export PATH="$HOME/.local/share/cargo/bin:$PATH"
export PATH="$HOME/.rvm/bin:$PATH"
export PATH="/opt/kafka/bin:$PATH"
# export PATH="/opt/node/bin:$PATH"
export PATH="/opt/kafka-client/bin:$PATH"
export PATH="/opt/kotlinc/bin:$PATH"
export PATH="/opt/sbt/bin:$PATH"
export PATH="/opt/oracle-instantclient:$PATH"
export PATH="$HOME/.dynamic-colors/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="$JAVA_HOME/bin:$PATH"
export PATH="/opt/fastly/bin:$PATH"
export PATH="/var/lib/snapd/snap/bin:$PATH"
export PATH="$HOME/.gem/ruby/3.0.0/bin:$PATH"
export PATH="$PATH:/home/henninb/.local/share/JetBrains/Toolbox/scripts"
# export PATH="/opt/STM32CubeProgrammer/bin:$PATH"
# export PATH="$HOME/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin:$PATH"
export CDPATH=~/projects/github.com

[ -d /usr/local/go ] && export GOROOT=/usr/local/go
export GOPATH=$HOME/.local
# export SDKMAN_DIR="$HOME/.sdkman"

# export SUDO_EDITOR=nvim
# export VISUAL=nvim
# export EDITOR=nvim
# export PAGER=less
# export OPENER=xdg-open
# export READER=zathura
# export TERMINAL=alacritty
# if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
#   export BROWSER=elinks
# else
#   export BROWSER=firefox
# fi
# export GIT_EDITOR=nvim
# export GIT_CONFIG="$HOME/.gitconfig"

# Tells 'less' not to paginate if less than a page
export LESS="-F -X $LESS"
# TODO: will this continue to function?
export GIT_PAGER=cat git diff
export CHEF_USER="$(whoami)"
export NVM_DIR="$HOME/.nvm"
export TMOUT=0
export GPG_TTY="$(tty)"
# export PYENV_ROOT="$HOME/.pyenv"
export VAGRANT_DEFAULT_PROVIDER=kvm
# TODO is this required
export POWERLINE_BASH_CONTINUATION=1
export POWERLINE_BASH_SELECT=1
export KEYTIMEOUT=1


export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

export ANDROID_HOME="$XDG_DATA_HOME"/android
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config
export HISTFILE="${XDG_STATE_HOME}"/zsh/history
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export SDKMAN_DIR="$XDG_DATA_HOME"/sdkman
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export AZURE_CONFIG_DIR="$XDG_DATA_HOME"/azure
export PSQLRC="$XDG_CONFIG_HOME/pg/psqlrc"
export PSQL_HISTORY="$XDG_DATA_HOME/psql_history"
export PGPASSFILE="$XDG_CONFIG_HOME/pg/pgpass"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export STACK_ROOT="$XDG_DATA_HOME"/stack
export NVM_DIR="$XDG_DATA_HOME"/nvm
export _Z_DATA="$XDG_DATA_HOME/z"
export TERMINFO="$XDG_DATA_HOME"/terminfo
export TERMINFO_DIRS="$XDG_DATA_HOME"/terminfo:/usr/share/terminfo
export LEIN_HOME="$XDG_DATA_HOME"/lein
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export SCREENRC="$XDG_CONFIG_HOME"/screen/screenrc
export PYENV_ROOT="$XDG_DATA_HOME"/pyenv
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
# export GNUPGHOME="$XDG_DATA_HOME"/gnupg
 export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
# export ELINKS_CONFDIR="$XDG_CONFIG_HOME"/elinks
# export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker

# compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
# mkdir -p "$XDG_CACHE_HOME/xmonad"
# mkdir -p "$XDG_CONFIG_HOME/xmonad"
# mkdir -p "$XDG_DATA_HOME/xmonad"
# touch $XDG_CACHE_HOME/xmonad/.save $XDG_CONFIG_HOME/xmonad/.save $XDG_DATA_HOME/xmonad/.save

# cleanup
#export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority" # This line will break some DMs.
export NOTMUCH_CONFIG="$HOME/.config/notmuch-config"
# export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"
export WGETRC="$HOME/.config/wget/wgetrc"
export INPUTRC="$HOME/.config/inputrc"
# export ZDOTDIR="$HOME/.config/zsh"
export PASSWORD_STORE_DIR="$HOME/.local/share/password-store"
# This is the list for lf icons:
export LF_ICONS="di=📁:\
fi=📃:\
tw=🤝:\
ow=📂:\
ln=⛓:\
or=❌:\
ex=🎯:\
*.txt=✍:\
*.mom=✍:\
*.me=✍:\
*.ms=✍:\
*.png=🖼:\
*.ico=🖼:\
*.jpg=📸:\
*.jpeg=📸:\
*.gif=🖼:\
*.svg=🗺:\
*.xcf=🖌:\
*.html=🌎:\
*.xml=📰:\
*.gpg=🔒:\
*.css=🎨:\
*.pdf=📚:\
*.djvu=📚:\
*.epub=📚:\
*.csv=📓:\
*.xlsx=📓:\
*.tex=📜:\
*.md=📘:\
*.r=📊:\
*.R=📊:\
*.rmd=📊:\
*.Rmd=📊:\
*.mp3=🎵:\
*.opus=🎵:\
*.ogg=🎵:\
*.m4a=🎵:\
*.flac=🎼:\
*.mkv=🎥:\
*.mp4=🎥:\
*.webm=🎥:\
*.mpeg=🎥:\
*.zip=📦:\
*.rar=📦:\
*.7z=📦:\
*.tar.gz=📦:\
*.z64=🎮:\
*.v64=🎮:\
*.n64=🎮:\
*.1=ℹ:\
*.nfo=ℹ:\
*.info=ℹ:\
*.log=📙:\
*.iso=📀:\
*.img=📀:\
*.bib=🎓:\
*.ged=👪:\
*.part=💔:\
*.torrent=🔽:\
"

# for rust
[ -s "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

[ -s "$HOME/.alias-main" ] && source "$HOME/.alias-main"

if [ -x "$(command -v nvim)" ] || [ -x "$(command -v neovim-flatpak)" ]; then
  [ -s "$HOME/.alias-neovim" ] && source "$HOME/.alias-neovim"
fi

# [ -s "$HOME/.sdkman/bin/sdkman-init.sh" ] && source "$HOME/.sdkman/bin/sdkman-init.sh"
[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

if [ ! "$OS" = "FreeBSD" ]; then
  if [ -x "$(command -v chef)" ]; then
    autoload -Uz compinit
    compinit
    if [ "$MYSHELL" = "zsh" ]; then
      eval "$(chef shell-init zsh)"
    else
      eval "$(chef shell-init bash)"
    fi
  fi
fi

if [ -z "$(find ~/.fonts -maxdepth 1 -type f  \( -name Monofur_for_Powerline.ttf \))" ]; then
  mkdir -p ~/.fonts
  cd ~/.fonts || return
  unzip "$HOME/.local/fonts/monofur-fonts.zip"
  fc-cache -vf ~/.fonts/
  cd - || return
fi

if [ "$OS" = "FreeBSD" ] || [ "$OS" = "Alpine Linux" ] || [ "$OS" = "OpenBSD" ] || [ "$OS" = "Darwin" ]; then
  [ -s "$HOME/.alias-bsd" ] && source "$HOME/.alias-bsd"
fi

[ -s "$NVM_DIR/nvm.sh" ] && chmod 755 "$NVM_DIR/nvm.sh" && source "$NVM_DIR/nvm.sh"

[ ! -f "$HOME/.ssh/id_rsa.pub" ] && ssh-keygen -y -f "$HOME/.ssh/id_rsa" > "$HOME/.ssh/id_rsa.pub"

[ ! -d "$XDG_DATA_HOME/pyenv" ] && git clone https://github.com/pyenv/pyenv.git "$XDG_DATA_HOME/pyenv"

# TODO: rewrite with the -z
if ! grep -A 3 '\[branch "main"\]' "$HOME/.git/config" | grep 'remote = origin' > /dev/null; then
  git branch --set-upstream-to=origin/main main
fi

# workaround for font colors
# sed -i 's/blue $CURRENT_FG/39d $CURRENT_FG/' ~/.oh-my-zsh/themes/agnoster.zsh-theme

# neofetch will run on certain conditions
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  if [ -x "$(command -v neofetch)" ]; then
    [ -n "$TMUX" ] || (curl 'wttr.in/Minneapolis?0' --silent --max-time 3 && neofetch)
  fi
else
  if [ "$OSTYPE" = "linux-gnu" ]; then
    if [ -f /sys/module/hid_apple/parameters/fnmode ]; then
      if ! cat /sys/module/hid_apple/parameters/fnmode | grep -q 2; then
        echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode
        echo "options hid_apple fnmode=2" | sudo tee -a /etc/modprobe.d/hid_apple.conf
        if command -v update-initramfs; then
          sudo update-initramfs -u -k all
        elif command -v mkinitcpio; then
          sudo mkinitcpio -p linux
        elif command -v genkernel; then
          sudo genkernel initramfs
        elif command -v xbps-reconfigure; then
          sudo xbps-reconfigure -f linux6.1
        elif command -v dracut; then
          sudo dracut -f --regenerate-all
        else
          echo "kernel gen not found"
        fi
        echo "reboot"
      fi
    fi
  fi
#  export DISPLAY=localhost:10.0
fi

[ -d "/var/lib/mpd/music/" ] && ln -sfn /var/lib/mpd/music/ "$HOME/media" 2> /dev/null
# [ -f "$HOME/.config/nvim/init.vim" ] && ln -sfn "$HOME/.config/nvim/init.vim" "$HOME/.vimrc" 2> /dev/null
# [ -f "$HOME/.config/picom/picom.conf" ] && ln -sfn "$HOME/.config/picom/picom.conf" "$HOME/.config/compton/compton.conf" 2> /dev/null
# TODO: ought not do this as it breaks lightdm
#[ -f "$HOME/.xinitrc" ] && ln -sfn "$HOME/.xinitrc" "$HOME/.xsession"
[ -f /opt/arduino/arduino ] && ln -sfn /opt/arduino/arduino "$HOME/.local/bin/arduino" 2> /dev/null
[ -f /opt/intellij/bin/idea.sh ] && ln -sfn /opt/intellij/bin/idea.sh "$HOME/.local/bin/intellij" 2> /dev/null
[ -f /opt/firefox/firefox ] && ln -sfn /opt/firefox/firefox "$HOME/.local/bin/firefox" > /dev/null
[ -f /opt/vscode/bin/code ] && ln -sfn /opt/vscode/bin/code "$HOME/.local/bin/code" 2> /dev/null
[ -f "$HOME/.tmux-default.conf" ] && ln -sfn "$HOME/.tmux-default.conf" "$HOME/.tmux.conf" 2> /dev/null
[ -f "$HOME/.ssh/config" ] && chmod 600 "$HOME/.ssh/config"
[ -f "$HOME/.ssh/authorized_keys" ] && chmod 600 "$HOME/.ssh/authorized_keys"
[ -f "$HOME/.ssh/config" ] && chmod 600 "$HOME/.ssh/config"
[ -f "$HOME/.ssh/id_rsa" ] && chmod 600 "$HOME/.ssh/id_rsa"
[ -d "$HOME/.ssh" ] && chmod 700 "$HOME/.ssh"
chmod 700 "$HOME"
[ -d "$HOME/.gnupg" ] && chmod 700 "$HOME/.gnupg"
[ -f "$HOME/.ghci" ] && chmod 644 "$HOME/.ghci"

[ -f "$HOME/.zsh_history" ] && sort -t ";" -k 2 -u "$HOME/.zsh_history" | sort -o "$HOME/.zsh_history"


#if [ "$OS" = "Gentoo" ]; then
#  if ! grep "$(hostname)" /etc/hosts > /dev/null; then
#    echo "Action required: add a hostname entry to /etc/hosts to prevent issues with xauth."
#  fi
#fi

touch "$HOME/.zshrc-work-custom"
source "$HOME/.zshrc-work-custom"

if [ "$MYSHELL" = "bash" ]; then
  if [ "$(uname -s)" = "Darwin" ]; then
    powerline-daemon -q
    source "/usr/local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh"
  elif [ "$(uname -s)" = "Linux" ]; then
    if [ -f "$HOME/.local/lib/python3.6/site-packages/powerline/bindings/bash/powerline.sh" ]; then
      powerline-daemon -q
      source "$HOME/.local/lib/python3.6/site-packages/powerline/bindings/bash/powerline.sh"
    elif [ -f "$HOME/.local/lib64/python3.6/site-packages/powerline/bindings/bash/powerline.sh" ]; then
      powerline-daemon -q
      source "$HOME/.local/lib64/python3.6/site-packages/powerline/bindings/bash/powerline.sh"
    elif [ -f "$HOME/.local/lib/python3.7/site-packages/powerline/bindings/shell/powerline.sh" ]; then
      powerline-daemon -q
      source "$HOME/.local/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh"
    else
      pip3 install powerline-status --user
      #source $HOME/.local/lib/python3.6/site-packages/powerline/bindings/bash/powerline.sh
    fi
  else
    echo "OS not found"
  fi
fi

if [ "${MYSHELL}" = "zsh" ]; then
  # vi mode
  bindkey -v

  # Fix backspace bug when switching modes
  bindkey "^?" backward-delete-char

  function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
        echo -ne '\e[1 q'
    elif [[ ${KEYMAP} == main ]] ||
         [[ ${KEYMAP} == viins ]] ||
         [[ ${KEYMAP} = '' ]] ||
         [[ $1 = 'beam' ]]; then
        echo -ne '\e[5 q'
    fi
  }

  _fix_cursor() {
     echo -ne '\e[5 q'
  }

  precmd_functions+=(_fix_cursor)

  zle -N zle-keymap-select
fi

# TODO: should I get ride of this config?
[ -f "$HOME/.config/broot/launcher/bash/1" ] && source "$HOME/.config/broot/launcher/bash/1"

if [ "$MYSHELL" = "zsh" ]; then
  source "$HOME/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  source "$HOME/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
  #source "$HOME/plugins/autojump/bin/autojump.zsh"
  source "$HOME/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh"
  source "$HOME/plugins/zed-zsh/zed.zsh"
  eval "$(starship init zsh)"
  # source "$HOME/themes/spaceship-prompt/spaceship.zsh"
elif [ "$MYSHELL" = "bash" ]; then
  eval "$(starship init bash)"
else
  echo unknown shell
fi

# zsh completion system.
zstyle ':completion:*' menu select

zmodload zsh/complist

# use the vi navigation keys in menu completion
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# zstyle ':completion:*' verbose yes

# zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
autoload -Uz compinit
compinit

# skip identical arrowup commands
setopt histignoredups

# https://github.com/mooz/percol

# not working
# bindkey "^[[A" history-beginning-search-backward
# bindkey "^[[B" history-beginning-search-forward

# requires plugin history-substring-search
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
# ability to use the vim keys while searching history [must be in vim mode]
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

## HISTORY
# export HISTTIMEFORMAT='%Y-%m-%d %T '
export HISTTIMEFORMAT='%d-%m-%y %T '
export HISTCONTROL=ignoreboth
# export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=1000000000
export SAVEHIST="$HISTSIZE"
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_SPACE
setopt share_history


[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

## bindkey section
bindkey "^A" vi-beginning-of-line
bindkey "^E" vi-end-of-line
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# remove a key?
bindkey -r "^B"

# touch "$HOME/env.secrets"

# set -a
# . "$HOME/env.secrets"
# set +a

autoload -Uz tetriscurses
# echo tetriscurses
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# TODO: is this required?
# if [ -e /home/henninb/.nix-profile/etc/profile.d/nix.sh ]; then . "${HOME}/.nix-profile/etc/profile.d/nix.sh"; fi

# if [ -x "$(command -v dig)" ]; then
  # externalip="$(dig +time=3 +tries=1 +short myip.opendns.com @resolver1.opendns.com)"
  # export externalip
# fi

# Added to address Alacritty issue
export LIBGL_ALWAYS_SOFTWARE=1
export EIX_LIMIT=0

# export MPD_HOST=localhost
# export MPD_PORT=6000

# fix for emacs tramp 10/25/2020
[ "$TERM" = "dumb" ] && unsetopt zle && PS1='$ '

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [ ! -f ~/.p10k.zsh ] || source ~/.p10k.zsh
[ -f "$HOME/.acme.sh/acme.sh.env" ] && source "$HOME/.acme.sh/acme.sh.env"

export PATH=/sbin:/usr/sbin:${PATH}

# added by travis gem
#[ ! -s /home/henninb/.travis/travis.sh ] || source /home/henninb/.travis/travis.sh


# needs to move to ~/.local/lib/
# source '/home/henninb/.local/lib/azure-cli/az.completion'
true

# vim: set ft=sh:
