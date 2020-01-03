TERM=xterm
GREEN="\[$(tput setaf 2)\]"
RESET="\[$(tput sgr0)\]"
MAGENTA=$(tput setaf 5)
BLUE=$(tput setaf 4)
RESET=$(tput sgr0)

#export PS1="${GREEN}my prompt${RESET}> "

#echo $PS1
#export PS1="[\\u@\\H \\W \\@]\\$ "

# with color
#export PS1="\e[0;31m[\u@\h \W]\$ \e[m "

# with more color
#export PS1="\[\e[32m\][\[\e[m\]\[\e[31m\]\u\[\e[m\]\[\e[33m\]@\[\e[m\]\[\e[32m\]\h\[\e[m\]:\[\e[36m\]\w\[\e[m\]\[\e[32m\]]\[\e[m\]\[\e[32;47m\]\\$\[\e[m\] "

#export PS1="\[$(tput setaf 1)\]\u@\h:\w $ \[$(tput sgr0)\]"

#failed
#export PS1="\[$(tput sc; cursor-moving code) positioned prompt stuff $(tput rc)\] normal prompt stuff"

#export PS1="\[$(tput bold)$(tput setb 5)$(tput setaf 7)\]\u@\h:\w $ \[$(tput sgr0)\]"

#export PS1='[\[$MAGENTA\]\u\[$RESET\]@\[$MAGENTA\]\h\[$RESET\]:\[$BLUE\]\w\[$RESET\]]\\$ '

#export export PS1="\t \u@\h \w\\$\[$(tput sgr0)\]"

#export PS1="\[$(tput bold)\]\[$(tput setaf 4)\][\[$(tput setaf 5)\]\u\[$(tput setaf 4)\]@\[$(tput setaf 5)\]\h \[$(tput setaf 2)\]\W\[$(tput setaf 4)\]]\\$ \[$(tput sgr0)\]"

export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"
