# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    export OS=$NAME
    export OS_VER=$VERSION_ID
elif type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    export OS=$(lsb_release -si)
    export OS_VER=$(lsb_release -sr)
elif [ -f /etc/lsb-release ]; then
    # For some versions of Debian/Ubuntu without lsb_release command
    . /etc/lsb-release
    export OS=$DISTRIB_ID
    export OS_VER=$DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
    # Older Debian/Ubuntu/etc.
    export OS=Debian
    export OS_VER=$(cat /etc/debian_version)
elif [ -f /etc/SuSe-release ]; then
    # Older SuSE/etc.
    ...
elif [ -f /etc/redhat-release ]; then
    # Older Red Hat, CentOS, etc.
    ...
else
    # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
    export OS=$(uname -s)
    export OS_VER=$(uname -r)
fi

echo "OS=$OS version=$OS_VER"

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE
export HISTSIZE=1000
export HISTFILESIZE=4000
export HISTIGNORE='&:[ ]*'
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
if [ "$OS" != "Gentoo" ]; then
  [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

if [ ! "$OS" = "Alpine Linux" ]; then
  if [ -f "$HOME/bash_prompt.sh" ]; then
    export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"
    #. $HOME/bash_prompt.sh
  fi
fi

if [ "$OS" = "FreeBSD" ]; then
  export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
fi

# Set vim as default text editor
export EDITOR=vim
export VISUAL=vim

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export TMOUT=0

# Use less command as a pager
export PAGER=less
export PATH=$HOME/.local/bin:$PATH:$HOME/bin

if [ "$OS" = "Linux Mint" ]; then
  export JAVA_HOME=/usr/lib/jvm/default-java/
fi

[ -s "$HOME/.alias.env" ] && source $HOME/.alias.env

gitpush() {
    git add .
    git commit -m "$*"
    git push
}
alias gp=gitpush
if [ "$OS" = "OpenBSD" ]; then
  alias pip=pip3.6
fi

export LC_COLLATE="C"

RESET="\[\033[0m\]"
RED="\[\033[0;31m\]"
GREEN="\[\033[01;32m\]"
BLUE="\[\033[01;34m\]"
YELLOW="\[\033[0;33m\]"

PS_INFO="$GREEN\u@\h$RESET:$BLUE\w"
PS_GIT="$YELLOW\$PS_BRANCH"
PS_TIME="\[\033[\$((COLUMNS-10))G\] $RED[\t]"
#export PS1="\${PS_FILL}\[\033[0G\]${PS_INFO} ${PS_GIT}${PS_TIME}\n${RESET}\$ "

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

