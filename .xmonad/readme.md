example xmonad polybar config
https://gitlab.cactis.eu/mkr/Dotfiles/-/blob/99bd4f5a0685c2cf6a0a2c25df256d0e12083848/xmonad/xmonad.hs


  , ("M-S-m", withFocused minimizeWindow)
  , ("M-S-C-m", withLastMinimized maximizeWindowAndFocus)


    , ("M-b", sendMessage ToggleStruts)

    , ("M-M1-l", spawn "i3lock -d -c FFFFFF -t -i ~/Pictures/LockScreen.png")
