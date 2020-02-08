#set --erase fish_greeting
set --universal fish_greeting
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

if [ -f /etc/os-release ]; then
    . /etc/os-release
    export OS=$NAME
    export OS_VER=$VERSION_ID
else if type lsb_release >/dev/null 2>&1; then
    set OS $(lsb_release -si)
    set OS_VER $(lsb_release -sr)
else if [ -f /etc/lsb-release ]; then
    . /etc/lsb-release
    export OS=$DISTRIB_ID
    export OS_VER=$DISTRIB_RELEASE
else if [ -f /etc/debian_version ]; then
    export OS=Debian
    export OS_VER=$(cat /etc/debian_version)
else if [ -f /etc/SuSe-release ]; then
    ...
else if [ -f /etc/redhat-release ]; then
    ...
else
  export OS=$(uname -s)
  export OS_VER=$(uname -r)
end

echo $OS
source $HOME/.alias-master
source $HOME/.alias-neovim
source $HOME/.alias-bsd
