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

background= "#181512"
foreground= "#D6C3B6"
color0=  "#332d29"
color8=  "#817267"
color1=  "#8c644c"
color9=  "#9f7155"
color2=  "#746C48"
color10= "#9f7155"
color3=  "#bfba92"
color11= "#E0DAAC"
color4=  "#646a6d"
color12= "#777E82"
color5=  "#766782"
color13= "#897796"
color6=  "#4B5C5E"
color14= "#556D70"
color7=  "#504339"
color15= "#9a875f"

wsbarFg = "#f0f0ff"
wsbarBg = "#0f0f0f"

stripDzen s = aux s [] -- strip dzen formatting to undo ppHidden
  where aux [] acc = acc
        aux x  acc = (\(good,bad) -> aux (dropDzen bad) (acc++good)) $ span (/= '^') x
            where dropDzen b = drop 1 $ dropWhile (/= ')') b

dzenOutput barOutputString =
    io $ appendFile "/tmp/.xmonad-info" (barOutputString ++ "\n")

dzenLogHook h = def
  {
      ppCurrent = dzenColor color15 background . pad . clickableWorkspace
    , ppVisible = dzenColor color14 background . pad . clickableWorkspace
    , ppHidden = dzenColor color14 background . pad . clickableWorkspace
    , ppHiddenNoWindows  = dzenColor background background . pad
    , ppWsSep = ""
    , ppSep = "    "
    , ppLayout = wrap "^ca(1,xdotool key super+space)" "^ca()" . dzenColor color2 background
        -- (\x -> case x of
        --   "Full"        ->  "^i(/home/sunn/.xmonad/dzen2/layout_full.xbm)"
        --   "Spacing 5 ResizableTall"  ->  "^i(/home/sunn/.xmonad/dzen2/layout_tall.xbm)"
        --   "ResizableTall"      ->  "^i(/home/sunn/.xmonad/dzen2/layout_tall.xbm)"
        --   "SimplestFloat"      ->  "^i(/home/sunn/.xmonad/dzen2/mouse_01.xbm)"
        --   "Circle"      ->  "^i(/home/sunn/.xmonad/dzen2/full.xbm)"
        --   _        ->  "^i(/home/sunn/.xmonad/dzen2/grid.xbm)"
        -- )
--    , ppTitle  =  wrap "^ca(1,xdotool key alt+shift+x)^fg(#D23D3D)^fn(fkp)x ^fn()" "^ca()" . dzenColor foreground background . shorten 40 . pad
    , ppTitle  =  wrap "^ca(1,xdotool key super+shift+x)" "^ca()" . dzenColor color15 background . shorten 40 . pad
    , ppOrder  =  \(ws:l:t:_) -> [ws,l, t]
    , ppOutput  =   hPutStrLn h
    -- , ppOutput  = dzenOutput
  } where
      clickableWorkspace ws = "^ca(1,xdotool key super+" ++ ws ++ ") " ++ ws ++ " ^ca()"
