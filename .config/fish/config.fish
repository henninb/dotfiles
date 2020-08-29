# if the contents of the file .config/fish/fishfile does not contain spacefish then
# fisher add matchai/spacefish
#set --erase fish_greeting
set --universal fish_greeting


# install fisher add matchai/spacefish
set SPACEFISH_PROMPT_ORDER exit_code host dir git jobs char
set SPACEFISH_PROMPT_ADD_NEWLINE false
set SPACEFISH_PROMPT_SEPARATE_LINE false
set SPACEFISH_CHAR_SYMBOL ❯
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
