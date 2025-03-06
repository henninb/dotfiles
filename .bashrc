# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

export PATH="/opt/brave-browser:$PATH"
export PATH="/opt/brave-bin:$PATH"
export PATH="/opt/mullvad-browser/Browser:$PATH"
export PATH="/opt/google-cloud-sdk/bin:$PATH"
export PATH="$HOME/Applications:$PATH"
export PATH="/opt/yubico-authenticator:$PATH"
export PATH="$HOME/.ghcup/bin:$PATH"
export PATH="$HOME/.nix-profile/bin:$PATH"
export PATH="$HOME/scripts:$PATH"
export PATH="$HOME/python/streamdeck-env/bin:$PATH"
export PATH="$HOME/.local/share/bin:$PATH"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/opt/openjdk@17/bin:$PATH"
export PATH="$HOME/.local/share/npm/bin:$PATH"
export PATH="$HOME/.local/share/cargo/bin:$PATH"
export PATH="$HOME/.rvm/bin:$PATH"
export PATH="/opt/kafka/bin:$PATH"
export PATH="/opt/charles/bin:$PATH"
export PATH="/opt/flutter/bin:$PATH"
export PATH="/opt/android-studio/bin:$PATH"
export PATH="/opt/kafka-client/bin:$PATH"
export PATH="/opt/kotlinc/bin:$PATH"
export PATH="/opt/sbt/bin:$PATH"
export PATH="/opt/oracle-instantclient:$PATH"
export PATH="$HOME/.dynamic-colors/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/sbin:$PATH"
export PATH="/sbin:$PATH"
export PATH="$JAVA_HOME/bin:$PATH"
export PATH="/opt/fastly/bin:$PATH"

eval "$(starship init bash)"

# vim: set ft=sh:
