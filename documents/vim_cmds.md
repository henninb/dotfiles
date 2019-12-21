# vim commands
1.1 insert (and replace) 1.2 normal (command) 1.3 visual. 1.3.1 plain visual mode. 1.3.2 block visual mode. 1.3.3 linewise visual mode.  1.4 select.  1.5 command-line.  1.6 Ex-mode.  master motions and operators di" - delete inside double quote on a line - example line is: text before key="value"
di' - delete inside single quote on a line - example line is: text before key='value'

ci" - change inside double quote on a line
ci' - change inside single quote on a line

ci( - change inside parenthesis on a line, but must be in the parenthesis

cit - change in html tag <div>content</div>

cf" - change forward until and including the double quote

ct" - change forward until and excluding the double quote
cft - change forward until a t char is found
ciw - change inner word
caw - change inner word including the space
c6j - change 6 lines

## repeat
. = repeat

5>> indent the next 5 lines

fc find first occurrence of c in a line

:g/^$/d will delete empty lines
:%s/\s\+$//g delete trailing spaces
:%g!/lazy/d delete lines contains lazy in them

:vsplit
vim -O vim_cmds.txt vim_cmds.txt.bak

^r <register> " in insert mode to paste
^ moves curses to first non white space

vim scp://dev-john@10.0.18.12/project/src/main.c


:map ,l :!clear && gcc % && ./a.out<cr>

:set rnu!
:set nu!

:set nonu nornu
