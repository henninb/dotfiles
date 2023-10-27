# emacs commands

## close window and buffer
```C-x,4,0```

## close the split buffer
```C-x,0```

## quit within emacs (custom)
``` C-x-g ```

## emacsclient as a server
use emacsclient as $EDITOR
emacsclient -create-frame --alternate-editor=""

## emacsclient from a shell
emacsclient -c -e "(print (+ 5 4))"
emacsclient -e "(print (+ 5 4))"

## startup Dired
``` C-x,d or C-x,4,d ```

## startup magit
``` M-x,magit ```

## startup emms
``` M-x,emms ```

## install package magit
``` M-x package-install RET magit RET ```

## version of magit
```M-x magit-version RET```

## tramp
``` C-x,C-f /ssh:pi@192.168.100.124:/home/pi/.zshrc```
```~/.authinfo.gpg```
```(setq password-cache-expiry nil)```
```which requires the package password-cache.el```

## evaluate an expression
``` M-: (= 0 1) RET ```

## buffer movement
```^x, ^>```
```^x, ^<```


emacs --eval "(eshell)"
emacs --eval "(eww)"

emacs -f eww
emacs -f eshell
emacs -f emms
emacs -f dired
emacs -f magit
emacs -f vterm
