# vim commands

## modes
1.1 insert (and replace)
1.2 normal (command)
1.3 visual
1.3.1 plain visual mode
1.3.2 block visual mode
1.3.3 linewise visual mode
1.4 select
1.5 command-line
1.6 Ex-mode

master motions and operators di" - delete inside double quote on a line - example line is: text before key="value"
## delete inside single quote on a line - example line is: text before key='value'
```
di'
```

## change inside double quote on a line
```
ci"
```

## change inside single quote on a line
```
ci'
```

## change inside parenthesis on a line, but must be in the parenthesis
```
ci(
```

## change in html tag <div>content</div>
```
cit
```

## change forward until and including the double quote
```
cf"
```

## change forward until and excluding the double quote
```
ct"
```

## change forward until a t char is found
```
cft
```

## change inner word
```
ciw
```

## change inner word including the space
```
caw
```

## change 6 lines
```
c6j
```

## repeat the previous command
```
.
```

## indent the next 5 lines
```
5>>
```

## find the first occurence of the letter 'c' on the line
```
fc
```

## delete an empty line
```
:g/^$/d
```

## delete trailing white space
```
:%s/\s\+$//g
```

## delete lines containing a string
```
:%g!/lazy/d
```

## create a vertical split
```
:vsplit
```

```
vim -O vim_cmds.txt vim_cmds.txt.bak
```

## moves curses to first non white space
```
^
```

## map the command ,l to run the compile and run
```
:map ,l :!clear && gcc % && ./a.out<cr>
```

^r <register> " in insert mode to paste
vim scp://pi@192.168.100.125/home/pi/.bashrc
:set rnu!
:set nu!

:set nonu nornu
