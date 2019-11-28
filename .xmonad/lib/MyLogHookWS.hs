module MyLogHookWS
( myLogHookWS
) where

import XMonad

-- hooks --
import XMonad.Hooks.DynamicLog
import qualified GHC.IO.Handle.Types as H

-- miscelllanous --
import System.IO

-- own module: configuration decomposition --
import MyColor

------------------------------------------------------------------------

   
-- Status Bars and Logging

wrapXBitmapWS bitmap = "^i(.xmonad/assets/layout/"++bitmap++")"
leftDeco fgWS bgWS = "^fg("++(myColor bgWS)++")"
    ++"^i(.xmonad/assets/deco/mr2m.xbm)"
    ++"^fg()^bg("++(myColor bgWS)++")^fg("++(myColor fgWS)++")"
rightDeco  = "^fg()^bg()" 


myLogHookWS ::  H.Handle -> X ()
--myLogHookWS h = dynamicLogWithPP $ def
myLogHookWS h = dynamicLogWithPP $ defaultPP
    {
        ppCurrent         = wrap (leftDeco "DarkGray" "Yellow") rightDeco
                          . wrap "[ " "]" . (icon_grid ++) . pad                           
      , ppVisible         = wrap (leftDeco "Blue" "White") rightDeco
                          . pad
      , ppHidden          = wrap (leftDeco "White" "Green") rightDeco
                          . pad
      , ppHiddenNoWindows = wrap (leftDeco "White" "Decoration") rightDeco
                          . pad
      , ppUrgent          = wrap (leftDeco "Red" "PureWhite") rightDeco
                          . pad
      , ppWsSep           = ""
      , ppSep             = "      "
      , ppOrder           = \(ws:l:t:_) -> [ws]
      , ppLayout          = dzenColor (myColor "Foreground") (myColor "Background") 
      , ppTitle           = dzenColor (myColor "Foreground") (myColor "Background")
      , ppOutput          = hPutStrLn h 
    }
    where 
        icon_grid = wrapXBitmapWS "grid.xbm"
          
          
          
