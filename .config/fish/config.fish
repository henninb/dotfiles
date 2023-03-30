# if the contents of the file .config/fish/fishfile does not contain spacefish then
# fisher add matchai/spacefish
#set --erase fish_greeting
set --universal fish_greeting

if test -f /etc/os-release
    set OS (grep '^NAME=' /etc/os-release | tr -d '"' | cut -d = -f2)
    set OS_VER (grep '^VERSION_ID=' /etc/os-release | tr -d '"' | cut -d = -f2)
else if type lsb_release >/dev/null 2>&1
    set OS (lsb_release -si)
    set OS_VER (lsb_release -sr)
else if test -f /etc/lsb-release
    echo /etc/lsb-release
    set OS (grep '^DISTRIB_ID=' /etc/lsb-release | tr -d '"' | cut -d = -f2)
    set OS_VER (grep '^DISTRIB_RELEASE=' /etc/lsb-release | tr -d '"' | cut -d = -f2)
else if test -f /etc/debian_version
    set OS "Debian"
    set OS_VER (cat /etc/debian_version)
else if test -f /etc/SuSe-release
    echo "should not enter here v1"
    return
else if test -f /etc/redhat-release
    echo "should not enter here v2"
    return
else
    # FreeBSD branches here.
    set OS (uname -s)
    set OS_VER (uname -r)
end

set -x OS $OS
set -x OS_VER $OS_VER

# if [ -f /etc/os-release ];
#   set OS (cat /etc/os-release | grep '^NAME=' | tr -d '"' | cut -d = -f2)
#   set OS_VER (cat /etc/os-release | grep '^VERSION_ID=' | tr -d '"' | cut -d = -f2)
# else if [ type lsb_release >/dev/null 2>&1 ];
#   set OS (lsb_release -si)
#   set OS_VER (lsb_release -sr)
# else if [ -f /etc/lsb-release ];
#   set OS (cat /etc/lsb-release | grep '^DISTRIB_ID=' | tr -d '"' | cut -d = -f2)
#   set OS_VER (cat /etc/lsb-release | grep '^DISTRIB_RELEASE=' | tr -d '"' | cut -d = -f2)
# else if [ -f /etc/debian_version ];
#   set OS Debian
#   set OS_VER (cat /etc/debian_version)
# else if [ -f /etc/SuSe-release ];
#   exit 1
# else if [ -f /etc/redhat-release ];
#   exit 2
# else
#   set OS (uname -s)
#   set OS_VER (uname -r)
# end

# source $HOME/.alias-master

if [ -x (command -v nvim) ];
  source $HOME/.alias-neovim
end

if [ \( "$OS" = "FreeBSD" \) -o \(  "$OS" = "Alpine Linux" \) -o \(  "$OS" = "OpenBSD" \) -o \(  "$OS" = "Darwin" \) ];
  source $HOME/.alias-bsd
end

alias gs='git status'

function gp
  echo $argv | read -l arg1
  git pull
  git add .
  git commit -m "$arg1"
  git push
end

starship init fish | source

# vim: set ft=sh:
