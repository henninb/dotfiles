# xmonad

## logout code
```
main = xmonad $ defaultConfig {
    keys = myKeys
}

myKeys = azertyKeys `M.union` qwertyKeys

azertyKeys = ...
qwertyKeys = ...

myKeys = [
    ...
    , ((modMask .|. shiftMask, xK_x), io exitSuccess)
    ...
    ]
```

## logout with a shell script
```
runhaskell -e "import XMonad; import System.Exit; exitSuccess"
```

## run a haskell program
```
stack exec runhaskell
stack exec runhaskell Main.hs
runhaskell -e "import XMonad; import System.Exit; exitSuccess"
```
