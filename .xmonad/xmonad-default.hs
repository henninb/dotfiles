{-# LANGUAGE RebindableSyntax #-}
import XMonad

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.Minimize
import XMonad.Hooks.Place
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.FadeInactive
import XMonad.Util.EZConfig
import XMonad.Util.NamedActions
import XMonad.Util.SpawnOnce
import XMonad.Layout.FixedColumn
import XMonad.Actions.SpawnOn
-- import XMonad.Layout.LimitWindows
-- import XMonad.Layout.Magnifier
-- import XMonad.Layout.Minimize
-- import XMonad.Layout.NoBorders
-- import XMonad.Layout.PerWorkspace
-- import XMonad.Layout.Renamed
-- import XMonad.Layout.Spacing
-- import XMonad.Layout.ThreeColumns
import XMonad.Layout.WindowArranger --DecreaseRight, IncreaseUp
-- import XMonad.Layout.Gaps
import XMonad.Actions.Submap
-- Prompt
-- import XMonad.Prompt
-- import XMonad.Prompt.FuzzyMatch
-- import Control.Arrow (first)

import XMonad.Util.NamedScratchpad (namedScratchpadManageHook)

import Graphics.X11.ExtraTypes
-- import XMonad.Util.Paste (sendKey)

-- import qualified XMonad.Actions.Search as S

import XMonad.Util.Run(spawnPipe, safeSpawn)

-- import qualified XMonad.Layout.BoringWindows as B
import Control.Monad (forM_, join)

import qualified XMonad.StackSet as W
-- import qualified Data.Map        as M
-- import qualified Codec.Binary.UTF8.String as UTF8
import Prelude
import Data.Maybe
import XMonad.Actions.GroupNavigation
import XMonad.Hooks.RefocusLast
import Data.Char (isSpace, toUpper, isDigit)

import System.Environment (setEnv, getEnv)
-- import System.Info
-- import qualified System.Info (os, arch)
import System.Info ( os )
import XMonad.Util.NamedWindows (getName)
import Data.Function (on)
import Data.List (sortBy)

-- import qualified Local.KeyBindings as Local
import Local.Colors
import Local.KeyBindings
import Local.Workspaces
import Local.MouseBinding
import Local.ManagedHook
import Local.Layouts

main :: IO ()
main = do
  safeSpawn "mkfifo" ["/tmp/.xmonad-info"]
  forM_ [".xmonad-info"] $ \file -> safeSpawn "mkfifo" ["/tmp/" ++ file]

  xmonad
    $ withUrgencyHook NoUrgencyHook
    $ ewmh
    -- $ myConfig { logHook = dynamicLogWithPP polybarLogHook }
    $ myConfig { logHook =
      case os of
        "freebsd" -> dynamicLogWithPP polybarLogHook
        "linux"   -> dynamicLogWithPP polybarLogHook
        _    -> eventLogHookForPolybar
    }
    `removeKeys` myRemoveKeys
    `additionalKeysP` keyMaps
    `additionalKeys` []

myTerminal :: String
myTerminal = "alacritty"
--myModMask      = mod4Mask
-- modMask = 115 -- Windows start button
-- modMask = xK_Meta_L

-- xmodmap - shows the key mapping
-- TODO: need to fix as the Win [M1] key is now useless
-- altKeyMask :: KeyMask
-- altKeyMask = mod1Mask

-- superKeyMask :: KeyMask
-- superKeyMask = mod4Mask

-- myFont :: String
-- myFont = "xft:monofur for Powerline:bold:size=9:antialias=true:hinting=true"

myBorderWidth :: Dimension
myBorderWidth = 1

myBrowser :: String
myBrowser = "brave"

mySpacing :: Int
mySpacing = 5

myAddSpaces :: Int -> String -> String
myAddSpaces len str = sstr ++ replicate (len - length sstr) ' '
  where
    sstr = shorten len str

polybarOutput barOutputString =
  io $ appendFile "/tmp/.xmonad-info" (barOutputString ++ "\n")

eventLogHookForPolybar = do
    winset <- gets windowset
    title <- maybe (return "") (fmap show . getName) . W.peek $ winset
    let currWs = W.currentTag winset
    let wss = map W.tag $ W.workspaces winset

    io $ appendFile "/tmp/.xmonad-title-log" (title ++ "\n")
    io $ appendFile "/tmp/.xmonad-info" (wsStr currWs wss ++ "\n")

    where
      fmt currWs workSpace
            | currWs == workSpace = "[" ++ workSpace ++ "]"
            | otherwise    = " " ++ workSpace ++ " "
      wsStr currWs wss = join $ map (fmt currWs) $ sortBy (compare `on` (!! 0)) wss
      wrapOpenWorkspaceCmd wsp
          | all isDigit wsp = wrapOnClickCmd ("xdotool key super+" ++ wsp) wsp
          | otherwise = wsp
      wrapOnClickCmd cmd = wrap ("%{A1:" ++ cmd ++ ":}") "%{A}"

currentWorkSpace :: X (Maybe String)
currentWorkSpace = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

polybarLogHook = def
    { ppOutput = polybarOutput
    , ppCurrent = wrap ("%{B" ++ "#400473" ++ "}" ++ "%{F" ++ "#FF69B4" ++ "}") " %{B- F-}" . wrap "[" "]" -- hotpink foreground, could try ff1d8e
    -- , ppCurrent = wrap ("%{B" ++ "#008000" ++ "}" ++ "%{F" ++ "#FF69B4" ++ "}") " %{B- F-}" . wrap "[" "]" -- hotpink foreground, could try ff1d8e --background green
    -- , ppCurrent = wrap ("%{B" ++ "#343434" ++ "}" ++ "%{F" ++ "#FF69B4" ++ "}") " %{B- F-}" . wrap "[" "]" -- hotpink foreground, could try ff1d8e
    , ppVisible = wrap ("%{F" ++ "#FF1493" ++ "} ") " %{F-}"
    -- , ppHiddenNoWindows = wrap ("%{F" ++ "#928374" ++ "} ") " %{F-}" --lightgrey foreground
    -- , ppHiddenNoWindows = id
    -- , ppUrgent = wrap ("%{F" ++ "#FF0000" ++ "} ") " %{F-}"  --red foreground
    , ppUrgent = withFG red
    -- , ppHidden = wrap " " "
    -- , ppHidden = withFG gray . withMargin . withFont 5 . (`wrapClickableWorkspace` "__hidden__")
    -- , ppHidden = withFG gray . withMargin . withFont 5 . (`wrapClickableWorkspace` showNamedWorkspaces id)
    , ppHidden = wrap "<" ">" . unwords . map wrapOpenWorkspaceCmd . words
    , ppHiddenNoWindows = withFG gray . wrap "{" "}" . unwords . map wrapOpenWorkspaceCmd . words
    -- , ppHiddenNoWindows  = withFG gray . withMargin . withFont 5 . (`wrapClickableWorkspace` "__empty__")"
    , ppOrder = \(workSpace:l:t:ex) -> [workSpace,l]++ex++[t]
    , ppWsSep = (withFG gray . withMargin) ":"
    , ppSep = (withFG gray . withMargin) "|"
    , ppTitle = myAddSpaces 25
    , ppExtras = [currentWorkSpace]
    }    where
      withMargin = wrap " " " "
      withFont fNum = wrap ("%{T" ++ show (fNum :: Int) ++ "}") "%{T}"
      withBG color = wrap ("%{B" ++ color ++ "}") "%{B-}"
      withFG color = wrap ("%{F" ++ color ++ "}") "%{F-}"
      --wrapOnClickCmd command     = wrap ("%{A1:" ++ command ++ ":}") "%{A}"
      -- wrapClickableWorkspace wsp = wrapOnClickCmd ("xdotool key super+" ++ wsp)
      wrapOpenWorkspaceCmd wsp
        | all isDigit wsp = wrapOnClickCmd ("xdotool key super+" ++ wsp) wsp
        | otherwise = wsp
      wrapOnClickCmd cmd = wrap ("%{A1:" ++ cmd ++ ":}") "%{A}"
      showNamedWorkspaces1 wsId = pad wsId

spawnToWorkspace :: String -> String -> X ()
spawnToWorkspace program workspace = do
                       spawn program
                       windows $ W.greedyView workspace . W.shift workspace

myStartupHook :: X ()
myStartupHook = do
    setWMName "LG3D"
    liftIO (setEnv "DESKTOP_SESSION" "xmonad")
    case os of
      "freebsd" -> spawnOnce "networkmgr"
      "linux"   -> spawnOnce "nm-applet"
      _    -> return ()
    spawnOnce "$HOME/.config/polybar/launch.sh xmonad"
    spawnOnce "flameshot" --dbus required
    spawnOnce "dunst"
    -- spawnOnce "picom"
    -- spawnOnce "sxhkd -c ~/.config/sxhkd/sxhkdrc-xmonad"
    -- spawn "clipmenud" --should I run copyq or clipmenu
    spawnOnce "copyq"
    spawnOn "1" "alacritty"
    spawnOn "2" "alacritty"
    case os of
      "freebsd" -> return ()
      "linux"   -> spawnOnce "blueman-applet" --dbus required
      _    -> return ()
    case os of
      "freebsd" -> return ()
      "linux"   -> spawnOnce "pamac-tray"
      _    -> return ()
    spawnOnce "numlockx on"
    spawnOnce "conky -c $HOME/.xmonad/system-overview"
    spawnOnce "mpDris2" -- required for mpd
    spawnOnce "volumeicon"
    spawnOnce "xscreensaver -no-splash"
    spawnOnce "feh --bg-scale $HOME/backgrounds/minnesota-vikings-dark.jpg"
    -- spawnToWorkspace "discord-flatpak" "9"

myConfig = def
  { terminal = myTerminal
  , layoutHook = windowArrange myLayouts
  , mouseBindings = myMouseBindings
  , manageHook = placeHook(smart(0.5, 0.5))
      <+> manageDocks
      <+> manageSpawn
      <+> myManageHook
      <+> myManageHook'
      <+> manageHook def
  , handleEventHook = docksEventHook
      <+> minimizeEventHook
      <+> fullscreenEventHook -- may have negative impact to flameshot
  -- , logHook = eventLogHookForPolybar
  , startupHook = myStartupHook
  , focusFollowsMouse = False
  , clickJustFocuses = False
  , borderWidth = myBorderWidth
  , normalBorderColor = myBorderColor
  , focusedBorderColor = myFocusBorderColor
  , workspaces = myWorkspaces
  , modMask = superKeyMask
  }
   `additionalKeysP`
   [
   ]
   `additionalKeys`
   [
   ]
