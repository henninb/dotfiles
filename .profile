#.profile is not executed by zsh
case $(tty) in /dev/tty[0-9]*)
  setfont ter-powerline-v16b ;;
esac

[ -t 0 ] && echo "TTY available" || echo "No TTY available"

export PATH="$HOME/.cargo/bin:$PATH"
