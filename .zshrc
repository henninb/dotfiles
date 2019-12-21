export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# DISABLE_AUTO_UPDATE="true"
# export UPDATE_ZSH_DAYS=13
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
#ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# ZSH_CUSTOM=/path/to/new-custom-folder

plugins=(git zsh-autosuggestions docker zsh-syntax-highlighting )

if [ -f $ZSH/oh-my-zsh.sh ]; then
  source $ZSH/oh-my-zsh.sh
fi

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_COLLATE="C"

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

HISTORY_IGNORE="(ls|cd|pwd|exit|cd ..)"

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

if [ "$OS" = "Linux Mint" ]; then
  #export JAVA_HOME=/usr/lib/jvm/default-java/
  [ -d "/usr/lib/jvm/java-8-openjdk-amd64" ] && export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
fi

export EDITOR=vim
export PAGER=less

# Tells 'less' not to paginate if less than a page
export LESS="-F -X $LESS"
export GIT_PAGER=cat git diff

# for rust
[ -s "$HOME/.cargo/env" ] && source $HOME/.cargo/env

[ -s "$HOME/.alias.env" ] && source $HOME/.alias.env

export SDKMAN_DIR="$HOME/.sdkman"
[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ] && source $HOME/.sdkman/bin/sdkman-init.sh

if [ ! "$OS" = "FreeBSD" ]; then
  if [ -x "$(command -v chef)" ]; then
    eval "$(chef shell-init zsh)"
  fi
fi
export CHEF_USER=$(whoami)

# fpath=(
#     ~/.zshrc/pjava
#     ~/.zshrc/gemerge
#     "${fpath[@]}"
# )

# autoload -Uz pjava
# autoload -Uz gemerge

FONTS="Sauce-Code-Pro-Nerd-Font-Complete-Mono-Windows-Compatible.ttf  Sauce-Code-Pro-Nerd-Font-Complete-Mono.ttf  Sauce-Code-Pro-Nerd-Font-Complete-Windows-Compatible.ttf  Sauce-Code-Pro-Nerd-Font-Complete.ttf"
mkdir -p ~/.fonts
ls -l ~/.fonts/{Sauce-Code-Pro-Nerd-Font-Complete-Mono-Windows-Compatible.ttf,Sauce-Code-Pro-Nerd-Font-Complete-Mono.ttf,Sauce-Code-Pro-Nerd-Font-Complete-Windows-Compatible.ttf,Sauce-Code-Pro-Nerd-Font-Complete.ttf} > /dev/null 2>&1
if [ $? -ne 0 ]; then
  cd ~/.fonts
  unzip ../sauce-code-pro-nerd-fonts.zip
  fc-cache -vf ~/.fonts/
  cd -
fi

echo copy fonts to ~/.local/share/fonts

# neovim has python env issues with VIMRUNTIME variable set.
# if [ -d "/usr/local/share/vim/vim81" ]; then
#   export VIMRUNTIME=/usr/local/share/vim/vim81
# elif [ -d "/usr/share/vim/vim81" ]; then
#   export VIMRUNTIME=/usr/share/vim/vim81
# elif [ -d "/usr/share/vim/vim80" ]; then
#   export VIMRUNTIME=/usr/share/vim/vim80
# elif [ -d "/usr/share/vim/vim74" ]; then
#   export VIMRUNTIME=/usr/share/vim/vim74
# else
#   echo VIMRUNTIME is set to the default.
# fi
# echo unset VIMRUNTIME

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source $NVM_DIR/nvm.sh

#[ -t 0 ] && echo "TTY available" || echo "No TTY available"

[ -n "$STY" ] && export TERM="screen-256color"
[ -n "$TMUX" ] && export TERM="xterm-256color"
#export TERM=rxvt-256color
echo ${TERM}

[ ! -f "~/.ssh/id_rsa.pub" ] && ssh-keygen -y -f ~/.ssh/id_rsa > ~/.ssh/id_rsa.pub

# if [ \( "$OS" = "Arch Linux" \) -o \(  "$OS" = "Raspbian GNU/Linux" \) ]; then
#   XMOBAR_WITH_PTS=$(ps -ef | grep xmobar | grep -v grep | grep pts | awk {'print$2'})
#   XMOBAR_WITHOUT_PTS=$(ps -ef | grep xmobar | grep -v grep | grep -v pts | awk {'print$2'})

#   for XMOBAR_PID in $(echo $XMOBAR_WITHOUT_PTS); do
#     PARENT_PID=$(ps -o comm= -p $(ps -o ppid= -p ${XMOBAR_PID}))
#     if [ "$PARENT_PID" = "systemd" ]; then
#       kill -9 $XMOBAR_PID
#     fi
#   done
#   [ -n "$XRDP_SESSION" ] && [ ! -n "$XMOBAR_WITH_PTS" ] && nohup xmobar ~/.config/xmobar/xmobarrc 2> /dev/null &
# fi

[ ! -d "$HOME/.pyenv" ] && git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv
[ ! -d "$HOME/.oh-my-zsh" ] && git clone git@github.com:ohmyzsh/ohmyzsh.git $HOME/.oh-my-zsh
[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ] && git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ] && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

grep -A 3 '\[branch "master"\]' $HOME/.git/config | grep 'remote = origin' > /dev/null
if [ $? -ne 0 ]; then
  echo git branch --set-upstream-to=origin/master master
  git branch --set-upstream-to=origin/master master
fi

export XDG_CONFIG_HOME=~/.config
export XDG_DATA_HOME=~/.local/share
export XDG_DATA_DIRS=~/.local/share:$XDG_DATA_DIRS
# export XDG_DATA_HOME=~/.local/share/fonts:${XDG_DATA_HOME}
# sed -i 's/blue $CURRENT_FG/39d $CURRENT_FG/' ~/.oh-my-zsh/themes/agnoster.zsh-theme

export TMOUT=0
export GPG_TTY=$(tty)
export PYENV_ROOT="$HOME/.pyenv"
export VAGRANT_DEFAULT_PROVIDER=kvm
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  echo ssh session has started.
  export DISPLAY=localhost:10.0
fi

ln -sfn $HOME/.config/nvim/init.vim $HOME/.vimrc
#ln -sfn $HOME/.xinitrc $HOME/.xsessionrc
ln -sfn $HOME/.xinitrc $HOME/.xsession
ln -sfn /opt/arduino/arduino $HOME/.local/bin/arduino
ln -sfn /opt/intellij/bin/idea.sh $HOME/.local/bin/idea.sh
ln -sfn /opt/intellij/bin/idea.sh $HOME/.local/bin/intellij
ln -sfn /opt/firefox/firefox $HOME/.local/bin/firefox
ln -sfn /opt/vscode/bin/code $HOME/.local/bin/code

chmod 600 $HOME/.ssh/authorized_keys
chmod 600 $HOME/.ssh/config
chmod 600 $HOME/.ssh/id_rsa
chmod 700 $HOME
chmod 700 $HOME/.gnupg
chmod 644 $HOME/.ghci

sort -t ";" -k 2 -u $HOME/.zsh_history | sort -o $HOME/.zsh_history

export PATH=$PATH:$PYENV_ROOT/bin
export PATH=$PATH:$HOME/.local/bin:$HOME/bin
export PATH=$PATH:$HOME/node_modules/.bin
export PATH=$PATH:$HOME/.cargo/bin
#export PATH=$PATH:$HOME/.gem/ruby/2.6.0/bin
export PATH=$PATH:$HOME/.rvm/bin
export PATH=/opt/kafka/bin:$PATH
export PATH=/opt/kotlinc/bin:$PATH
[ -s "$HOME/.rvm/scripts/rvm" ] && source $HOME/.rvm/scripts/rvm
[ -s "/etc/profile.d/rvm.sh" ] && source /etc/profile.d/rvm.sh
#echo "stty -tostop"
if [ \( "$OS" = "Linux Mint" \) -o \(  "$OS" = "Ubuntu" \) -o \(  "$OS" = "Raspbian GNU/Linux" \) ]; then
  if [ -x "$(command -v inxi)" ]; then
    # inxi -Sxxx #causes xmonad to hang
    inxi
  else
    sudo apt install -y inxi
    inxi -Sxxx
  fi
fi
