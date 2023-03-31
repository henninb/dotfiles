# if the contents of the file .config/fish/fishfile does not contain spacefish then
# fisher add matchai/spacefish
#set --erase fish_greeting
set --universal fish_greeting

if test -f /etc/os-release
    set -gx OS (grep '^NAME=' /etc/os-release | tr -d '"' | cut -d = -f2)
else if type lsb_release >/dev/null 2>&1
    set -gx OS (lsb_release -si)
else if test -f /etc/lsb-release
    set -gx OS (grep '^DISTRIB_ID=' /etc/lsb-release | tr -d '"' | cut -d = -f2)
else if test -f /etc/debian_version
    set -gx OS "Debian"
else
    # FreeBSD, OpenBSD, Darwin branches here.
    set -gx OS (uname -s)
end

set -x OS $OS

# if test -f /etc/os-release
#     set OS (grep '^NAME=' /etc/os-release | tr -d '"' | cut -d = -f2)
# else if type lsb_release >/dev/null 2>&1
#     set OS (lsb_release -si)
# else if test -f /etc/lsb-release
#     set OS (grep '^DISTRIB_ID=' /etc/lsb-release | tr -d '"' | cut -d = -f2)
# else if test -f /etc/debian_version
#     set OS "Debian"
# else if test -f /etc/SuSe-release
#     echo "should not enter here v1"
#     return
# else if test -f /etc/redhat-release
#     echo "should not enter here v2"
#     return
# else
#     # FreeBSD branches here.
#     set OS (uname -s)
# end

# set -x OS $OS

if test "$OS" = "openSUSE Tumbleweed"
    set -x NIX_SSL_CERT_FILE /var/lib/ca-certificates/ca-bundle.pem
end

if test -e $HOME/.nix-profile/etc/profile.d/nix.sh; source $HOME/.nix-profile/etc/profile.d/nix.sh; end


if test "$TERM" = "dumb"
    set -x PS1 '$ '
end

function gitpush
  if test (count $argv) -lt 1
    echo "Usage: gitpush <messages>" >&2
  else
    git pull origin main
    git add .
    git commit -m "$argv"
    git push origin main
  end
end

source $HOME/.alias-fish

if [ -x (command -v nvim) ];
  source $HOME/.alias-neovim
end

if [ \( "$OS" = "FreeBSD" \) -o \(  "$OS" = "Alpine Linux" \) -o \(  "$OS" = "OpenBSD" \) -o \(  "$OS" = "Darwin" \) ];
  source $HOME/.alias-bsd
end

#alias gs='git status'

# function gp
#   echo $argv | read -l arg1
#   git pull
#   git add .
#   git commit -m "$arg1"
#   git push
# end

starship init fish | source

# vim: set ft=sh:
