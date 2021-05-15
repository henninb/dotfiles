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

dzenOutput barOutputString =
    io $ appendFile "/tmp/.xmonad-info" (barOutputString ++ "\n")

dzenLogHook h = def
  {
      -- ppCurrent = dzenColor foreground background . padding . clickableWorkspace
      ppCurrent = withForeground purple . padding . clickableWorkspace
    -- , ppVisible = dzenColor foreground background . padding . clickableWorkspace
    , ppVisible = withForeground white . padding . clickableWorkspace
    , ppHidden = withForeground gray . padding . clickableWorkspace
    -- , ppHidden = dzenColor color14 background . padding . clickableWorkspace
    , ppHiddenNoWindows = padding
    -- , ppHiddenNoWindows  = dzenColor background background . padding
    , ppWsSep = ""
    , ppSep = "    "
    , ppLayout = wrap "^ca(1,xdotool key super+space)" "^ca()"
    , ppTitle  =  wrap "^ca(1,xdotool key super+shift+x)" "^ca()"  . shorten 40 . padding
    , ppOrder  =  \(ws:l:t:_) -> [ws,l, t]
    , ppOutput  =   hPutStrLn h
    -- , ppOutput  = dzenOutput
  } where
      clickableWorkspace ws = "^ca(1,xdotool key super+" ++ ws ++ ") " ++ ws ++ " ^ca()"
      withForeground color = wrap ("^fg(" ++ color ++ ")") "^fg()"
      withFont = wrap "^fn(monofur for Powerline-12)" "^fn()"
      padding = wrap " " " "

