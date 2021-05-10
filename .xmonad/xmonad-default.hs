{-# LANGUAGE RebindableSyntax #-}
import XMonad

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.Minimize
import XMonad.Hooks.Place
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook
import XMonad.Util.EZConfig
import XMonad.Util.SpawnOnce
import XMonad.Actions.SpawnOn
import XMonad.Layout.WindowArranger --DecreaseRight, IncreaseUp
import XMonad.Util.Run(spawnPipe, safeSpawn)
import Control.Monad (forM_)
import Prelude
import System.Environment (setEnv)
import System.Info (os)

import Local.Colors
import Local.KeyBindings
import Local.Workspaces
import Local.MouseBinding
import Local.ManagedHook
import Local.Layouts
import Local.PolybarLogHook

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
