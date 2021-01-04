# one of the first items called with respect to zsh

#export LC_ALL=en_US.UTF-8
# make zsh/terminfo work for terms with application and cursor modes
case "$TERM" in
  xterm-termite)
    #echo termite-workaround
    export TERM=xterm-256color
    ;;
  xterm)
    #echo xterm-workaround
    export TERM=xterm-256color
    ;;
esac

case $(tty) in
  /dev/tty[0-9]*)
    setfont ter-powerline-v16b
    export TERM=linux
    #echo in console
    # sed -i 's/39d $CURRENT_FG/blue $CURRENT_FG/' ~/.oh-my-zsh/themes/agnoster.zsh-theme
  ;;
esac

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


[ -n "$STY" ] && export TERM="screen-256color"
[ -n "$TMUX" ] && export TERM="xterm-256color"

if [[ $- == *i* ]]; then
  # Start blinking
  LESS_TERMCAP_mb=$(tput bold; tput setaf 2) # green
  export LESS_TERMCAP_mb
  # Start bold
  LESS_TERMCAP_md=$(tput bold; tput setaf 2) # green
  export LESS_TERMCAP_md
  # Start stand out
  LESS_TERMCAP_so=$(tput bold; tput setaf 3) # yellow
  export LESS_TERMCAP_so
  # End standout
  LESS_TERMCAP_se=$(tput rmso; tput sgr0)
  export LESS_TERMCAP_se
  # Start underline
  LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 1) # red
  export LESS_TERMCAP_us
  # End bold, blinking, standout, underline
  LESS_TERMCAP_me=$(tput sgr0)
  export LESS_TERMCAP_me
fi

gemerge() {
  if [ "$#" -ne 1 ]; then
    echo "Usage: ${FUNCNAME} <package>" >&2
  else
    qlist -I | grep -v grep | grep "$1"
    if [ $? -ne 0 ]; then
      echo "$1 will emerge."
      sudo emerge "$1"
    else
      echo  "$1 already built."
    fi
  fi
}

pjava() {
  if [ "$#" -ne 1 ]; then
    echo "Usage: ${FUNCNAME} <appname>" >&2
  else
    mkdir -p "src/main/java/$1"
    mkdir -p src/main/resources
    touch src/main/resources/application.yml
    touch "src/main/java/$1/Application.java"
    mkdir -p src/test

    gradle wrapper
    ./gradlew wrapper --gradle-version=5.5.1
    rm -rf .gradle
  fi
}

git_sparse_clone() (
  rurl="$1" localdir="$2" && shift 2

  mkdir -p "$localdir"
  cd "$localdir" || exit

  git init
  git remote add -f origin "$rurl"

  git config core.sparseCheckout true

  # Loops over remaining args
  for i; do
    echo "$i" >> .git/info/sparse-checkout
  done

  git pull origin master
)

gitpush() {
  if [ "$#" -lt 1 ]; then
    echo "Usage: ${FUNCNAME} <messages>" >&2
  else
    git pull
    git add .
    git commit -m "$*"
    git push
  fi
}

niceProcess() {
  if [ "$#" -ne 1 ]; then
    echo "Usage: ${FUNCNAME} <process_name>" >&2
  else
    PROC_NAME=$1
    NICE_VAL=19
    PID=$(pgrep -x ${PROC_NAME})
    if [ $? -eq 0 ]; then
      #PID=$(ps -Af | grep -w "${PROC_NAME}" | grep -v grep | head -n 1 | awk '{print $2}')
      CURRENT_NICE=$(ps -Afl -C ${PID} | awk '{print $11}' | grep -v NI | head -n 1)
      if [ "${CURRENT_NICE}" != "${NICE_VAL}" ]; then
        echo "RUNNING: sudo renice -n \"${NICE_VAL}\" -p ${PID}"
        sudo renice -n "${NICE_VAL}" -p "${PID}"
        #ps -Afl -C ${PID}
      else
        echo ${NICE_VAL}
      fi
    else
      echo no pid found.
    fi
  fi
}

mdless() {
  if [ "$#" -lt 1 ]; then
    echo "Usage: ${FUNCNAME} <mdfile>" >&2
  else
    glow -s dark "$1" | less -r
  fi
}

ytd() {
  if [ "$#" -ne 1 ]; then
    echo "Usage: ${FUNCNAME} <youtube_id>" >&2
  else
    echo "$1"
    youtube-dl -f bestaudio --extract-audio "https://www.youtube.com/watch?v=$1" --output "$1.opus"
    ffmpeg -i "$1.opus" "$1.mp3"
    rm "$1.opus"
  fi
}

squash() {
  git rebase -i HEAD~${1:-2}
}

# fix for emacs tramp 10/25/2020
[ "$TERM" = "dumb" ] && unsetopt zle && PS1='$ '
