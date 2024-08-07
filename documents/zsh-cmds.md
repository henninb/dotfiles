## zsh

# details
```
Zsh
Zsh always executes zshenv. Then, depending on the case:

run as a login shell, it executes zprofile;
run as an interactive, it executes zshrc;
run as a login shell, it executes zlogin.
At the end of a login session, it executes zlogout, but in reverse order, the user-specific file first, then the system-wide one, constituting a chiasmus with the zlogin files.
```

# zsh commands
```
> bindkey
"^A" vi-beginning-of-line
"^C" self-insert
"^D" list-choices
"^E" vi-end-of-line
"^F" self-insert
"^G" list-expand
"^H" vi-backward-delete-char
"^I" fzf-completion
"^J" accept-line
"^K" self-insert
"^L" clear-screen
"^M" accept-line
"^N"-"^P" self-insert
"^Q" vi-quoted-insert
"^R" fzf-history-widget
"^S" self-insert
"^T" fzf-file-widget
"^U" vi-kill-line
"^V" vi-quoted-insert
"^W" vi-backward-kill-word
"^X^R" _read_comp
"^X?" _complete_debug
"^XC" _correct_filename
"^Xa" _expand_alias
"^Xc" _correct_word
"^Xd" _list_expansions
"^Xe" _expand_word
"^Xh" _complete_help
"^Xm" _most_recent_file
"^Xn" _next_tags
"^Xt" _complete_tag
"^X~" _bash_list-choices
"^Y"-"^Z" self-insert
"^[" vi-cmd-mode
"^[," _history-complete-newer
"^[/" _history-complete-older
"^[OA" up-line-or-history
"^[OB" down-line-or-history
"^[OC" vi-forward-char
"^[OD" vi-backward-char
"^[[200~" bracketed-paste
"^[[A" history-substring-search-up
"^[[B" history-substring-search-down
"^[[C" vi-forward-char
"^[[D" vi-backward-char
"^[c" fzf-cd-widget
"^[~" _bash_complete-word
"^\\\\"-"~" self-insert
"^?" backward-delete-char
"\M-^@"-"\M-^?" self-insert
```
