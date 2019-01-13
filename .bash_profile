
[[ -f ~/.bashrc ]] && . ~/.bashrc

export PATH="$HOME/.cargo/bin:$PATH"

export IRCNICK=henninb
export IRCUSER=henninb
export IRC_HOST=
export IRCNAME=henninb
export IRCSERVER=chat.freenode.net

alias youtube-dl="youtube-dl --no-check-certificate -f 'bestaudio[ext=m4a]'"
alias vi="vim"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
