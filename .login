#.login is not executed by zsh (.zlogin is executed)

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

export PATH=$HOME/.local/bin:$PATH

export FONTCONFIG_PATH=/etc/fonts
