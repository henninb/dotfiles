# if the contents of the file .config/fish/fishfile does not contain spacefish then
# fisher add matchai/spacefish set --erase fish_greeting
set --universal fish_greeting

if not type -q unzip > /dev/null
  echo unzip not installed.
end

if not type -q fc-cache > /dev/null
  echo fc-cache not installed.
end

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

if test "$OS" = "openSUSE Tumbleweed"
    set -x NIX_SSL_CERT_FILE /var/lib/ca-certificates/ca-bundle.pem
end

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
  source $HOME/.alias-neovim.fish
end

if [ \( "$OS" = "FreeBSD" \) -o \(  "$OS" = "Alpine Linux" \) -o \(  "$OS" = "OpenBSD" \) -o \(  "$OS" = "Darwin" \) ];
  source $HOME/.alias-bsd
end

if [ (uname) = "Linux" ]
  if [ $OS = "Gentoo" ]
    if command -v java-config >/dev/null 2>&1
      set -gx JAVA_HOME (java-config -o ^/dev/null)
    else
      echo "install java-config on gentoo"
    end
  else if command -v javac >/dev/null 2>&1
    set -gx JAVA_HOME (dirname (dirname (readlink -f (readlink -f (which javac))))^/dev/null)
  else
    echo "JAVA_HOME is not set up."
  end
else
  echo "not Linux"
end

# if test "(uname)" = "Linux"
#  echo "here"
#   if test "$OS" = "Gentoo"
#     if command -v java-config >/dev/null 2>&1
#       set -gx JAVA_HOME (java-config -o ^/dev/null)
#     else
#       echo "install java-config on gentoo"
#     end
#   else if command -v javac >/dev/null 2>&1
#     set -gx JAVA_HOME (dirname (dirname (readlink -f (readlink -f (which javac))))^/dev/null)
#   else
#     echo "JAVA_HOME is not set up."
#   end
# else if test (uname) = "Darwin"
#   #set -gx JAVA_HOME (/usr/libexec/java_home -v 1.8)
#   set -gx JAVA_HOME (/usr/libexec/java_home)
# else if test (uname) = "FreeBSD"
#   set -gx JAVA_HOME /usr/local/openjdk17
# else
#  echo "JAVA_HOME is not set up."
# end

# set -gx PATH $JAVA_HOME/bin $PATH

set -x PATH $HOME/Applications $PATH
set -x PATH /opt/yubico-authenticator $PATH
set -x PATH $HOME/.ghcup/bin $PATH
set -x PATH $HOME/.nix-profile/bin $PATH
set -x PATH $HOME/scripts $PATH
set -x PATH $HOME/python/streamdeck-env/bin $PATH
set -x PATH $HOME/.local/share/bin $PATH
set -x PATH $PYENV_ROOT/bin $PATH
set -x PATH $HOME/.local/bin $PATH
set -x PATH /usr/local/opt/openjdk@17/bin $PATH
# set -x PATH $HOME/.local/share/npm/bin $PATH
set -x PATH $HOME/.local/share/cargo/bin $PATH
set -x PATH $HOME/.rvm/bin $PATH
set -x PATH /opt/kafka/bin $PATH
set -x PATH /opt/kafka-client/bin $PATH
set -x PATH /opt/kotlinc/bin $PATH
set -x PATH /opt/sbt/bin $PATH
set -x PATH /opt/oracle-instantclient $PATH
set -x PATH $HOME/.dynamic-colors/bin $PATH
set -x PATH /usr/local/go/bin $PATH
set -x PATH /usr/local/bin $PATH
set -x PATH /sbin $PATH
set -x PATH $JAVA_HOME/bin $PATH
set -x PATH /opt/fastly/bin $PATH
#set -x PATH /var/lib/snapd/snap/bin $PATH
#set -x PATH $HOME/.gem/ruby/3.0.0/bin $PATH
set -x PATH $PATH:/home/henninb/.local/share/JetBrains/Toolbox/scripts
set -gx CDPATH ~/projects/github.com

if test -d /usr/local/go
    set -gx GOROOT /usr/local/go
end

set -gx GOPATH $HOME/.local

# Tells 'less' not to paginate if less than a page
set -gx LESS "-F -X $LESS"

set -gx CHEF_USER (whoami)
set -gx NVM_DIR "$HOME/.nvm"
set -gx TMOUT 0
set -gx GPG_TTY (tty)
# set -x PYENV_ROOT "$HOME/.pyenv"
set -gx VAGRANT_DEFAULT_PROVIDER kvm
# TODO is this required
set -gx POWERLINE_BASH_CONTINUATION 1
set -gx POWERLINE_BASH_SELECT 1
set -gx KEYTIMEOUT 1

set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_STATE_HOME "$HOME/.local/state"
set -gx XDG_CACHE_HOME "$HOME/.cache"

set -gx ANDROID_HOME "$XDG_DATA_HOME"/android
set -gx AWS_SHARED_CREDENTIALS_FILE "$XDG_CONFIG_HOME"/aws/credentials
set -gx AWS_CONFIG_FILE "$XDG_CONFIG_HOME"/aws/config
set -gx HISTFILE "$XDG_STATE_HOME"/zsh/history
set -gx CARGO_HOME "$XDG_DATA_HOME"/cargo
set -gx SDKMAN_DIR "$XDG_DATA_HOME"/sdkman
set -gx RUSTUP_HOME "$XDG_DATA_HOME"/rustup
set -gx AZURE_CONFIG_DIR "$XDG_DATA_HOME"/azure
set -gx PSQLRC "$XDG_CONFIG_HOME/pg/psqlrc"
set -gx PSQL_HISTORY "$XDG_DATA_HOME/psql_history"
set -gx PGPASSFILE "$XDG_CONFIG_HOME/pg/pgpass"
set -gx _JAVA_OPTIONS -Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
set -gx STACK_ROOT "$XDG_DATA_HOME"/stack
set -gx NVM_DIR "$XDG_DATA_HOME"/nvm
set -gx _Z_DATA "$XDG_DATA_HOME/z"
set -gx TERMINFO "$XDG_DATA_HOME"/terminfo
set -gx TERMINFO_DIRS "$XDG_DATA_HOME"/terminfo:/usr/share/terminfo
set -gx LEIN_HOME "$XDG_DATA_HOME"/lein
set -gx GRADLE_USER_HOME "$XDG_DATA_HOME"/gradle
set -gx SCREENRC "$XDG_CONFIG_HOME"/screen/screenrc
set -gx PYENV_ROOT "$XDG_DATA_HOME"/pyenv
set -gx NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME"/npm/npmrc
# set -x GNUPGHOME "$XDG_DATA_HOME"/gnupg
set -x GTK2_RC_FILES "$XDG_CONFIG_HOME"/gtk-2.0/gtkrc

[ -s "$HOME/.nix-profile/etc/profile.d/nix.fish" ] && source "$HOME/.nix-profile/etc/profile.d/nix.fish"
[ -s "$HOME/.cargo/env" ]; and source "$HOME/.cargo/env"
[ -s "$SDKMAN_DIR/bin/sdkman-init.fish" ] && source "$SDKMAN_DIR/bin/sdkman-init.fish"
#[ -s "$NVM_DIR/nvm.sh" ]; and chmod 755 "$NVM_DIR/nvm.sh"; and source "$NVM_DIR/nvm.sh"
[ ! -f "$HOME/.ssh/id_rsa.pub" ]; and ssh-keygen -y -f "$HOME/.ssh/id_rsa" > "$HOME/.ssh/id_rsa.pub"
[ ! -d "$XDG_DATA_HOME/pyenv" ]; and git clone https://github.com/pyenv/pyenv.git "$XDG_DATA_HOME/pyenv"

if [ -z (find ~/.fonts -maxdepth 1 -type f \( -name Monofur_for_Powerline.ttf \)) ]
    mkdir -p ~/.fonts
    cd ~/.fonts || return
    unzip $HOME/.local/fonts/monofur-fonts.zip
    fc-cache -vf ~/.fonts/
    cd -
end

if ! grep -A 3 '\[branch "main"\]' "$HOME/.git/config" | grep 'remote = origin' > /dev/null
  git branch --set-upstream-to=origin/main main
end

[ -f /opt/arduino/arduino ]; and ln -sfn /opt/arduino/arduino "$HOME/.local/bin/arduino" 2> /dev/null
[ -f /opt/intellij/bin/idea.sh ]; and ln -sfn /opt/intellij/bin/idea.sh "$HOME/.local/bin/intellij" 2> /dev/null
[ -f /opt/firefox/firefox ]; and ln -sfn /opt/firefox/firefox "$HOME/.local/bin/firefox" > /dev/null
[ -f /opt/vscode/bin/code ]; and ln -sfn /opt/vscode/bin/code "$HOME/.local/bin/code" 2> /dev/null
[ -f "$HOME/.tmux-default.conf" ]; and ln -sfn "$HOME/.tmux-default.conf" "$HOME/.tmux.conf" 2> /dev/null
[ -f "$HOME/.ssh/config" ]; and chmod 600 "$HOME/.ssh/config"
[ -f "$HOME/.ssh/authorized_keys" ]; and chmod 600 "$HOME/.ssh/authorized_keys"
[ -f "$HOME/.ssh/config" ]; and chmod 600 "$HOME/.ssh/config"
[ -f "$HOME/.ssh/id_rsa" ]; and chmod 600 "$HOME/.ssh/id_rsa"
[ -d "$HOME/.ssh" ]; and chmod 700 "$HOME/.ssh"
chmod 700 "$HOME"
[ -d "$HOME/.gnupg" ]; and chmod 700 "$HOME/.gnupg"
[ -f "$HOME/.ghci" ]; and chmod 644 "$HOME/.ghci"

mkdir -p $HOME/keepass-git
cd "$HOME/keepass-git"
git fetch
git merge origin/main > /dev/null
cd -


# vim keybindings
fish_vi_key_bindings

# emacs keybindings - fish_key_reader
bind -M insert \ca beginning-of-line
bind -M insert \ce end-of-line
bind -M insert \cw backward-kill-word
bind -M insert \ck kill-line
# for mode in (bind -L)
# end

set -g fish_color_command green
set -g fish_color_argument purple
# set -g fish_color_normal yellow

starship init fish | source

# vim: set ft=sh:
