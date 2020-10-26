# emacs commands

## close window and buffer
```
Cx,4,0
```

## close the split buffer
```
Cx,0
```

## quit within emacs (i overwrote this)
```
Cx-g
```

## emacsclient as a server
use emacsclient as $EDITOR
emacsclient -create-frame --alternate-editor=""

## emacsclient from a shell
emacsclient -c -e "(print (+ 5 4))"
emacsclient -e "(print (+ 5 4))"

## startup Dired
```
Cx,d
Cx,4,d
```

## startup magit
```
Mx,magit
```

## startup emms
```
Mx,emms
```

## install package magit
```
M-x package-install RET magit RET
```

## version of magit
```M-x magit-version RET```

## tramp
```
Cx,Cf
/ssh:henninb@192.168.100.208:/home/henninb/.zshrc
Cg to quit
```
