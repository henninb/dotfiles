# emacs commands

## close window and buffer
```
Cx,4,0
```

## quit within emacs
```
Cx-g
```

## emacsclient as a server
use emacsclient as $EDITOR
emacsclient -create-frame --alternate-editor=""

## emacsclient from a shell
emacsclient -c -e "(print (+ 5 4))"
emacsclient -e "(print (+ 5 4))"
