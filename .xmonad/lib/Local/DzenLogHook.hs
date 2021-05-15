module Local.DzenLogHook (dzenLogHook) where

import XMonad
import XMonad.Hooks.DynamicLog
import Data.Char (isDigit)
import Control.Monad (join)
-- import Data.List (sortBy)
import XMonad.Util.Run
import Data.Function (on)
import XMonad.Util.Dzen
import XMonad.Util.NamedWindows (getName)
import qualified XMonad.StackSet as W
import Data.List

import Local.Colors

-- stripDzen s = aux s [] -- strip dzen formatting to undo ppHidden
--   where aux [] acc = acc
--         aux x  acc = (\(good,bad) -> aux (dropDzen bad) (acc++good)) $ span (/= '^') x
--             where dropDzen b = drop 1 $ dropWhile (/= ')') b
myPurple :: String
myPurple = "#663399"

dzenOutput barOutputString =
    io $ appendFile "/tmp/.xmonad-info" (barOutputString ++ "\n")

currentWindowCount :: X (Maybe String)
currentWindowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

dzenLogHook h = def
  {
      ppOutput  =   hPutStrLn h
      -- ppOutput  = dzenOutput
    , ppCurrent = withForeground myPurple . withBackground lightpink . withMargin . clickableWorkspace
    , ppVisible = withForeground white . withMargin . clickableWorkspace
    , ppUrgent = withForeground red . withMargin
    , ppHidden = withForeground white . withMargin . clickableWorkspace
    , ppHiddenNoWindows = withForeground gray . withMargin .clickableWorkspace
    , ppOrder  =  \(ws:l:t:_) -> [ws,l, t]
    , ppWsSep = ""
    , ppSep = "    "
    , ppLayout = withForeground white . wrap "^ca(1,xdotool key super+space)" "^ca()"
    --TODO: what would the clickable do?
    , ppTitle =  withForeground white . wrap "^ca(1,xdotool key super+shift+x)" "^ca()"  . shorten 40 . withMargin
    , ppExtras = [currentWindowCount]
  } where
      clickableWorkspace ws = "^ca(1,xdotool key super+" ++ ws ++ ") " ++ ws ++ " ^ca()"
      withFont = wrap "^fn(monofur for Powerline-12)" "^fn()"
      withForeground color = wrap ("^fg(" ++ color ++ ")") "^fg()" . withFont
      withBackground color = wrap ("^bg(" ++ color ++ ")") "^bg()"
      withMargin = wrap " " " "

