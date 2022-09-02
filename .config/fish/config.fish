# if the contents of the file .config/fish/fishfile does not contain spacefish then
# fisher add matchai/spacefish
#set --erase fish_greeting
set --universal fish_greeting

# eval (starship init fish)
#
# set SPACESHIP_PROMPT_ORDER exit_code kubectl host dir git jobs char
# set SPACESHIP_PROMPT_ADD_NEWLINE false
# set SPACESHIP_PROMPT_SEPARATE_LINE false
# set SPACESHIP_CHAR_SYMBOL ♜
# set SPACESHIP_CHAR_SUFFIX " "
# set SPACESHIP_HG_SHOW false
# set SPACESHIP_PACKAGE_SHOW false
# set SPACESHIP_NODE_SHOW false
# set SPACESHIP_RUBY_SHOW false
# set SPACESHIP_ELM_SHOW false
# set SPACESHIP_ELIXIR_SHOW false
# set SPACESHIP_XCODE_SHOW_LOCAL false
# set SPACESHIP_SWIFT_SHOW_LOCAL false
# set SPACESHIP_GOLANG_SHOW false
# set SPACESHIP_PHP_SHOW false
# set SPACESHIP_RUST_SHOW false
# set SPACESHIP_JULIA_SHOW false
# set SPACESHIP_DOCKER_SHOW false
# set SPACESHIP_DOCKER_CONTEXT_SHOW false
# set SPACESHIP_AWS_SHOW false
# set SPACESHIP_CONDA_SHOW false
# set SPACESHIP_VENV_SHOW false
# set SPACESHIP_PYENV_SHOW false
# set SPACESHIP_DOTNET_SHOW false
# set SPACESHIP_EMBER_SHOW false
# set SPACESHIP_KUBECONTEXT_SHOW false
# set SPACESHIP_TERRAFORM_SHOW false
# set SPACESHIP_VI_MODE_SHOW false
# set SPACESHIP_JOBS_SHOW false
# set SPACESHIP_DIR_PREFIX ""
# set SPACESHIP_DIR_TRUNC_REPO false
# set SPACESHIP_HOST_PREFIX "@"
# set SPACESHIP_HOST_SHOW always
# set SPACESHIP_USER_SHOW false
# set SPACESHIP_GIT_PREFIX ""
# set SPACESHIP_KUBECTL_SHOW true
# set SPACESHIP_KUBECTL_VERSION_SHOW false
# set SPACESHIP_KUBECTL_VERSION_PREFIX ""
# set SPACESHIP_KUBECTL_SYMBOL ""
# set SPACESHIP_KUBECTL_PREFIX ""

# install fisher add matchai/spacefish
set SPACEFISH_PROMPT_ORDER exit_code host dir git jobs char
set SPACEFISH_PROMPT_ADD_NEWLINE false
set SPACEFISH_PROMPT_SEPARATE_LINE false
set SPACEFISH_CHAR_SYMBOL ❯
set SPACEFISH_CHAR_SYMBOL ♜
set SPACEFISH_CHAR_SUFFIX ' '
set SPACEFISH_HG_SHOW false
set SPACEFISH_PACKAGE_SHOW false
set SPACEFISH_NODE_SHOW false
set SPACEFISH_RUBY_SHOW false
set SPACEFISH_ELM_SHOW false
set SPACEFISH_ELIXIR_SHOW false
set SPACEFISH_XCODE_SHOW_LOCAL false
set SPACEFISH_SWIFT_SHOW_LOCAL false
set SPACEFISH_GOLANG_SHOW false
set SPACEFISH_PHP_SHOW false
set SPACEFISH_RUST_SHOW false
set SPACEFISH_JULIA_SHOW false
set SPACEFISH_DOCKER_SHOW false
set SPACEFISH_DOCKER_CONTEXT_SHOW false
set SPACEFISH_AWS_SHOW false
set SPACEFISH_CONDA_SHOW false
set SPACEFISH_VENV_SHOW false
set SPACEFISH_PYENV_SHOW false
set SPACEFISH_DOTNET_SHOW false
set SPACEFISH_EMBER_SHOW false
set SPACEFISH_KUBECONTEXT_SHOW false
set SPACEFISH_TERRAFORM_SHOW false
set SPACEFISH_TERRAFORM_SHOW false
set SPACEFISH_VI_MODE_SHOW false
set SPACEFISH_JOBS_SHOW false
set SPACEFISH_DIR_PREFIX ''
set SPACEFISH_DIR_TRUNC_REPO false
set SPACEFISH_HOST_PREFIX '@'
set SPACEFISH_HOST_SHOW always
set SPACEFISH_USER_SHOW false
set SPACEFISH_GIT_PREFIX ''
#
if [ -f /etc/os-release ];
  set OS (cat /etc/os-release | grep '^NAME=' | tr -d '"' | cut -d = -f2)
  set OS_VER (cat /etc/os-release | grep '^VERSION_ID=' | tr -d '"' | cut -d = -f2)
else if [ type lsb_release >/dev/null 2>&1 ];
  set OS (lsb_release -si)
  set OS_VER (lsb_release -sr)
else if [ -f /etc/lsb-release ];
  set OS (cat /etc/lsb-release | grep '^DISTRIB_ID=' | tr -d '"' | cut -d = -f2)
  set OS_VER (cat /etc/lsb-release | grep '^DISTRIB_RELEASE=' | tr -d '"' | cut -d = -f2)
else if [ -f /etc/debian_version ];
  set OS Debian
  set OS_VER (cat /etc/debian_version)
else if [ -f /etc/SuSe-release ];
  exit 1
else if [ -f /etc/redhat-release ];
  exit 2
else
  set OS (uname -s)
  set OS_VER (uname -r)
end

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

# vim: set ft=sh:
