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

wsbarFg = "#f0f0ff"
wsbarBg = "#0f0f0f"

stripDzen s = aux s [] -- strip dzen formatting to undo ppHidden
  where aux [] acc = acc
        aux x  acc = (\(good,bad) -> aux (dropDzen bad) (acc++good)) $ span (/= '^') x
            where dropDzen b = drop 1 $ dropWhile (/= ')') b

dzenLogHook h = def
    { ppCurrent = wrap (setfg currentBg "[") (setfg currentBg "]") . \wsId -> if ':' `elem` wsId then drop 2 wsId else wsId
    -- , ppVisible = dzenColor nonEmptyFg nonEmptyBg . wrap " " " " . \wsId -> if (':' `elem` wsId) then drop 2 wsId else wsId
    , ppVisible = dzenColor nonEmptyFg nonEmptyBg . wrap " " " " . \wsId -> if ':' `elem` wsId then drop 2 wsId else wsId
    , ppHidden =  dzenColor nonEmptyFg nonEmptyBg . wrap " " " " . \wsId -> if ':' `elem` wsId then drop 2 wsId else wsId -- don't use ^fg() here!!
    , ppHiddenNoWindows = dzenColor emptyFg emptyBg . wrap " " " " . \wsId -> if ':' `elem` wsId then drop 2 wsId else wsId
    , ppUrgent = dzenColor urgentFg urgentBg . wrap " " " " . stripDzen  . \wsId -> if ':' `elem` wsId then drop 2 wsId else wsId
    , ppSep = ""
    , ppWsSep = ""
    , ppTitle = (" : " ++) . dzenColor titleFg titleBg . wrap "< " " >"
    , ppLayout = dzenColor "#ffffff" "" . layoutToIcon
    , ppOutput = hPutStrLn h
    }
    where
        iconDir    = "/home/akh/.xmonad/dzen/icons/"
        icon s     = "^i(" ++ s ++ ")^ca()"
        tileIcon   = icon $ iconDir ++ "stlarch/tile.xbm"
        tabbedIcon = icon $ iconDir ++ "layout-tabbed.xbm"
        fullIcon   = icon $ iconDir ++ "stlarch/monocle.xbm"
        mirrorIcon = icon $ iconDir ++ "stlarch/bstack.xbm"
        titleFg = currentFg
        titleBg = currentBg
        currentFg = "#ffffff"
        currentBg = "#0066ff"
        urgentFg = "#ff0000"
        urgentBg = wsbarBg
        nonEmptyFg = "#ffffff"
        nonEmptyBg = wsbarBg
        emptyFg = "#888888"
        emptyBg = wsbarBg
        withMargin = wrap " " " "
        withBackground color = wrap ("%{B" ++ color ++ "}") "%{B-}"
        withForeground color = wrap ("%{F" ++ color ++ "}") "%{F-}"
        wrapOpenWorkspaceCmd wsp
          | all isDigit wsp = wrapOnClickCmd ("xdotool key super+" ++ wsp) wsp
          | otherwise = wsp
        wrapOnClickCmd cmd = wrap ("%{A1:" ++ cmd ++ ":}") "%{A}"
        showNamedWorkspaces1 wsId = pad wsId
        setfg color stuff = wrap ("^fg(" ++ color ++ ")") "^fg()" stuff
        setbg color stuff = wrap ("^bg(" ++ color ++ ")") "^bg()" stuff
        layoutToIcon x
            | "Mirror Tall" `isInfixOf` x = "mirror ^i(/home/drew/.dzen/icons/layout-mirror-tall.xbm)"
            | "Tall" `isInfixOf` x = "tall ^i(/home/drew/.dzen/icons/layout-tall.xbm)"
            | "Full" `isInfixOf` x = "full ^i(/home/drew/.dzen/icons/layout-full.xbm)"
            | otherwise = x
