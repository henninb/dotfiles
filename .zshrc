# TODO: needs to be tested
[[ $- != *i* ]] && return

# TODO: test this further
if [ "$0" = "zsh" ]; then
  export MYSHELL=zsh
elif [ "$0" = "bash" ]; then
  export MYSHELL=bash
else
  export MYSHELL=$(ps -o args= -p $$ | egrep -m 1 -o '\w{0,5}sh'| head -1)
fi

[ -z "$MYSHELL" ] && echo SHELL not found: dollar zero $0 and need to find a fix.
ln -sfn $HOME/.zshrc $HOME/.bashrc
#[[ -o interactive ]] || exit 0

if [ -f /etc/os-release ]; then
    . /etc/os-release
    export OS=$NAME
    export OS_VER=$VERSION_ID
elif type lsb_release >/dev/null 2>&1; then
    export OS=$(lsb_release -si)
    export OS_VER=$(lsb_release -sr)
elif [ -f /etc/lsb-release ]; then
    . /etc/lsb-release
    export OS=$DISTRIB_ID
    export OS_VER=$DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
    export OS=Debian
    export OS_VER=$(cat /etc/debian_version)
elif [ -f /etc/SuSe-release ]; then
    ...
elif [ -f /etc/redhat-release ]; then
    ...
else
  export OS=$(uname -s)
  export OS_VER=$(uname -r)
fi

#SPACESHIP_PROMPT_ORDER=(user host dir git)
SPACESHIP_PROMPT_ORDER=(exit_code host dir git jobs char)
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_PROMPT_SEPARATE_LINE=false
SPACESHIP_CHAR_SYMBOL=❯
SPACESHIP_CHAR_SUFFIX=" "
SPACESHIP_HG_SHOW=false
SPACESHIP_PACKAGE_SHOW=false
SPACESHIP_NODE_SHOW=false
SPACESHIP_RUBY_SHOW=false
SPACESHIP_ELM_SHOW=false
SPACESHIP_ELIXIR_SHOW=false
SPACESHIP_XCODE_SHOW_LOCAL=false
SPACESHIP_SWIFT_SHOW_LOCAL=false
SPACESHIP_GOLANG_SHOW=false
SPACESHIP_PHP_SHOW=false
SPACESHIP_RUST_SHOW=false
SPACESHIP_JULIA_SHOW=false
SPACESHIP_DOCKER_SHOW=false
SPACESHIP_DOCKER_CONTEXT_SHOW=false
SPACESHIP_AWS_SHOW=false
SPACESHIP_CONDA_SHOW=false
SPACESHIP_VENV_SHOW=false
SPACESHIP_PYENV_SHOW=false
SPACESHIP_DOTNET_SHOW=false
SPACESHIP_EMBER_SHOW=false
SPACESHIP_KUBECONTEXT_SHOW=false
SPACESHIP_TERRAFORM_SHOW=false
SPACESHIP_TERRAFORM_SHOW=false
SPACESHIP_VI_MODE_SHOW=false
SPACESHIP_JOBS_SHOW=false
SPACESHIP_DIR_PREFIX=""
#SPACESHIP_DIR_TRUNC_PREFIX=/home/
SPACESHIP_DIR_TRUNC_REPO=false
SPACESHIP_HOST_PREFIX="@"
SPACESHIP_HOST_SHOW=always
SPACESHIP_USER_SHOW=false
SPACESHIP_GIT_PREFIX=""

if [ "$OS" = "Darwin" ]; then
  ZSH_THEME="agnoster"
else
  ZSH_THEME="spaceship"
#  ZSH_THEME="dracula"
fi

if [ ! -x "$(command -v unzip)" ]; then
  echo unzip not installed.
fi

if [ ! -x "$(command -v fc-cache)" ]; then
  echo fc-cache not installed.
fi

if [ "$MYSHELL" = "zsh" ]; then
  [ -f "$HOME/.autojump/etc/profile.d/autojump.sh" ] && source $HOME/.autojump/etc/profile.d/autojump.sh
  [ -f "$HOME/.autojump/etc/profile.d/autojump.sh" ] && autoload -U compinit && compinit -u
fi

# TODO: test this, not sure if/how this works
HISTORY_IGNORE="(ls|cd|pwd|exit|cd ..)"


if [ "$OSTYPE" = "linux-gnu" ]; then
  if [ "$OS" = "Gentoo" ]; then
  #  echo ${JDK_HOME}
  #  echo fix java_home
    export JAVA_HOME=$(readlink -f $(readlink -f $JDK_HOME))
  elif [ -x "$(command -v javac)" ]; then
    export JAVA_HOME=$(dirname $(dirname $(readlink -f $(readlink -f $(which javac)) || readlink -f $(which javac))))
  else
    echo install java
  fi
elif [ "$OSTYPE" = "linux-gnueabihf" ]; then
  echo JAVA_HOME
else
  echo JAVA_HOME is not setup.
fi

export PATH=$PYENV_ROOT/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/node_modules/.bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.rvm/bin:$PATH
export PATH=/opt/kafka/bin:$PATH
export PATH=/opt/kafka-client/bin:$PATH
export PATH=/opt/kotlinc/bin:$PATH
export PATH=/opt/oracle-instantclient:$PATH
export PATH="$HOME/.dynamic-colors/bin:$PATH"

export GOPATH=$HOME/.local
export SDKMAN_DIR="$HOME/.sdkman"

export EDITOR=nvim
export PAGER=less

# Tells 'less' not to paginate if less than a page
export LESS="-F -X $LESS"
# TODO: will this continue to function?
export GIT_PAGER=cat git diff
export CHEF_USER=$(whoami)
export NVM_DIR="$HOME/.nvm"
export TMOUT=0
export GPG_TTY=$(tty)
export PYENV_ROOT="$HOME/.pyenv"
export VAGRANT_DEFAULT_PROVIDER=kvm
# TODO is this required
export POWERLINE_BASH_CONTINUATION=1
export POWERLINE_BASH_SELECT=1
export KEYTIMEOUT=1

# for rust
[ -s "$HOME/.cargo/env" ] && source $HOME/.cargo/env

[ -s "$HOME/.alias-master" ] && source $HOME/.alias-master

if [ -x "$(command -v nvim)" ]; then
  [ -s "$HOME/.alias-neovim" ] && source $HOME/.alias-neovim
fi

if [ \( "$OS" = "FreeBSD" \) -o \(  "$OS" = "Alpine Linux" \) -o \(  "$OS" = "OpenBSD" \) -o \(  "$OS" = "Darwin" \) ]; then
  [ -s "$HOME/.alias-bsd" ] && source $HOME/.alias-bsd
fi

[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ] && source $HOME/.sdkman/bin/sdkman-init.sh

if [ ! "$OS" = "FreeBSD" ]; then
  if [ -x "$(command -v chef)" ]; then
    if [ "$MYSHELL" = "zsh" ]; then
      eval "$(chef shell-init zsh)"
    else
      eval "$(chef shell-init bash)"
    fi
  fi
fi

mkdir -p ~/.fonts
ls -l ~/.fonts/{Monofur_Bold_for_Powerline.ttf,Monofur_Italic_for_Powerline.ttf,Monofur_for_Powerline.ttf} > /dev/null 2>&1
if [ $? -ne 0 ]; then
  cd ~/.fonts
  unzip ../monofur-fonts.zip
  fc-cache -vf ~/.fonts/
  cd -
fi

[ -s "$NVM_DIR/nvm.sh" ] && source $NVM_DIR/nvm.sh

[ ! -f "$HOME/.ssh/id_rsa.pub" ] && ssh-keygen -y -f $HOME/.ssh/id_rsa > $HOME/.ssh/id_rsa.pub

[ ! -d "$HOME/.pyenv" ] && git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv

grep -A 3 '\[branch "master"\]' $HOME/.git/config | grep 'remote = origin' > /dev/null
if [ $? -ne 0 ]; then
  git branch --set-upstream-to=origin/master master
fi

# workaround for font colors
# sed -i 's/blue $CURRENT_FG/39d $CURRENT_FG/' ~/.oh-my-zsh/themes/agnoster.zsh-theme

# neofetch will run on certain conditions
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  if [ -x "$(command -v neofetch)" ]; then
    [ -n "$TMUX" ] || neofetch
  fi
#  export DISPLAY=localhost:10.0
fi

mkdir -p $HOME/.config/compton

[ -f $HOME/.config/nvim/init.vim ] && ln -sfn $HOME/.config/nvim/init.vim $HOME/.vimrc
[ -f $HOME/.config/picom/picom.conf ] && ln -sfn $HOME/.config/picom/picom.conf $HOME/.config/compton/compton.conf
[ -f $HOME/.xinitrc ] && ln -sfn $HOME/.xinitrc $HOME/.xsession
[ -f /opt/arduino/arduino ] && ln -sfn /opt/arduino/arduino $HOME/.local/bin/arduino
[ -f /opt/intellij/bin/idea.sh ] && ln -sfn /opt/intellij/bin/idea.sh $HOME/.local/bin/idea.sh
[ -f /opt/intellij/bin/idea.sh ] && ln -sfn /opt/intellij/bin/idea.sh $HOME/.local/bin/intellij
[ -f /opt/firefox/firefox ] && ln -sfn /opt/firefox/firefox $HOME/.local/bin/firefox
[ -f /opt/vscode/bin/code ] && ln -sfn /opt/vscode/bin/code $HOME/.local/bin/code
[ -f $HOME/.tmux-rice.conf ] && ln -sfn $HOME/.tmux-rice.conf $HOME/.tmux.conf
#ln -sfn $HOME/.config/polybar/config-default $HOME/.config/polybar/config
[ -f $HOME/.config/polybar/config-master ] && ln -sfn $HOME/.config/polybar/config-master $HOME/.config/polybar/config
[ -f $HOME/.ssh/config ] && chmod 600 $HOME/.ssh/config
[ -f $HOME/.ssh/authorized_keys ] && chmod 600 $HOME/.ssh/authorized_keys
[ -f $HOME/.ssh/config ] && chmod 600 $HOME/.ssh/config
[ -f $HOME/.ssh/id_rsa ] && chmod 600 $HOME/.ssh/id_rsa
[ -d $HOME/.ssh ] && chmod 700 $HOME/.ssh
chmod 700 $HOME
[ -d $HOME/.gnupg ] && chmod 700 $HOME/.gnupg
[ -f $HOME/.ghci ] && chmod 644 $HOME/.ghci

[ -f $HOME/.zsh_history ] && sort -t ";" -k 2 -u $HOME/.zsh_history | sort -o $HOME/.zsh_history


[ -s "$HOME/.rvm/scripts/rvm" ] && source $HOME/.rvm/scripts/rvm
[ -s "/etc/profile.d/rvm.sh" ] && source /etc/profile.d/rvm.sh

if [ "$OS" = "Gentoo" ]; then
  grep $(hostname) /etc/hosts > /dev/null
  if [ $? -ne 0 ]; then
    echo "Action required: add a hostname entry to /etc/hosts to prevent issues with xauth."
  fi
fi

#if [ "$MYSHELL" = "zsh" ]; then
#  if [ "$OS" = "Darwin" ]; then
#    #control arrow
#    # bindkey "^[^[[D" backward-word
#    # bindkey "^[^[[C" forward-word
#    # option arrow
#    bindkey "[D" backward-word
#    bindkey "[C" forward-word
#  else
#    #control arraws trigger forward and backward by word
#    bindkey "^[[1;5C" forward-word
#    bindkey "^[[1;5D" backward-word
#  fi
#fi

touch $HOME/.xmonad/.active
touch $HOME/.active-wm
touch $HOME/.zshrc-work-custom
source $HOME/.zshrc-work-custom

if [ "$MYSHELL" = "bash" ]; then
  if [ "$(uname -s)" = "Darwin" ]; then
    powerline-daemon -q
    source /usr/local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh
  elif [ "$(uname -s)" = "Linux" ]; then
    if [ -f "$HOME/.local/lib/python3.6/site-packages/powerline/bindings/bash/powerline.sh" ]; then
      powerline-daemon -q
      source $HOME/.local/lib/python3.6/site-packages/powerline/bindings/bash/powerline.sh
    elif [ -f "$HOME/.local/lib64/python3.6/site-packages/powerline/bindings/bash/powerline.sh" ]; then
      powerline-daemon -q
      source $HOME/.local/lib64/python3.6/site-packages/powerline/bindings/bash/powerline.sh
    elif [ -f "$HOME/.local/lib/python3.7/site-packages/powerline/bindings/shell/powerline.sh" ]; then
      powerline-daemon -q
      source $HOME/.local/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh
    else
      pip3 install powerline-status --user
      #source $HOME/.local/lib/python3.6/site-packages/powerline/bindings/bash/powerline.sh
    fi
  else
    echo "OS not found"
  fi
fi

if [ "$MYSHELL" = "zsh" ]; then
  # vi mode
  bindkey -v

  # Use vim keys in tab complete menu:
  # bindkey -M menuselect 'h' vi-backward-char
  # bindkey -M menuselect 'j' vi-down-line-or-history
  # bindkey -M menuselect 'k' vi-up-line-or-history
  # bindkey -M menuselect 'l' vi-forward-char
  # bindkey -M menuselect 'left' vi-backward-char
  # bindkey -M menuselect 'down' vi-down-line-or-history
  # bindkey -M menuselect 'up' vi-up-line-or-history
  # bindkey -M menuselect 'right' vi-forward-char
  # Fix backspace bug when switching modes
  bindkey "^?" backward-delete-char

  # Change cursor shape for different vi modes.
  function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]] ||
       [[ $1 = 'block' ]]; then
      echo -ne '\e[1 q'
    elif [[ ${KEYMAP} == main ]] ||
         [[ ${KEYMAP} == viins ]] ||
         [[ ${KEYMAP} = '' ]] ||
         [[ $1 = 'beam' ]]; then
      echo -ne '\e[5 q'
    fi
  }
  zle -N zle-keymap-select
fi

[ -f "$HOME/.config/broot/launcher/bash/1" ] && source $HOME/.config/broot/launcher/bash/1

if [ "$MYSHELL" = "zsh" ]; then
  source $HOME/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  source $HOME/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
  source $HOME/plugins/autojump/bin/autojump.zsh
  source $HOME/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
  #eval "$(starship init zsh)"
  source $HOME/themes/spaceship-prompt/spaceship.zsh
  #source $HOME/themes/alien/alien.zsh
  #source $HOME/themes/dracula-zsh-theme/dracula.zsh-theme
  #source $HOME/themes/agnoster-zsh-theme/agnoster.zsh-theme
elif [ "$MYSHELL" = "bash" ]; then
  eval "$(starship init bash)"
else
  echo unknown shell
fi

# zsh completion system.
zstyle ':completion:*' completer _complete
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
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

export HISTFILE=/$HOME/.zsh_history
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY
