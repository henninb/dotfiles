---------------------------------------------------------------------------
--                                                                       --
--     _|      _|  _|      _|                                      _|    --
--       _|  _|    _|_|  _|_|    _|_|    _|_|_|      _|_|_|    _|_|_|    --
--         _|      _|  _|  _|  _|    _|  _|    _|  _|    _|  _|    _|    --
--       _|  _|    _|      _|  _|    _|  _|    _|  _|    _|  _|    _|    --
--     _|      _|  _|      _|    _|_|    _|    _|    _|_|_|    _|_|_|    --
--                                                                       --
---------------------------------------------------------------------------
{-# LANGUAGE PatternSynonyms #-}

import XMonad
import XMonad.Hooks.DynamicLog (shorten, dynamicLogWithPP)
import XMonad.Hooks.EwmhDesktops (ewmh, fullscreenEventHook)
import XMonad.Hooks.ManageDocks (docksEventHook, docksStartupHook, manageDocks, docks)
import XMonad.Hooks.Minimize (minimizeEventHook)
import XMonad.Hooks.Place (smart, placeHook)
import XMonad.Hooks.SetWMName (setWMName)
import XMonad.Hooks.UrgencyHook (UrgencyHook(..), withUrgencyHook)
import XMonad.Util.EZConfig (additionalKeysP, additionalKeys, removeKeys)
import XMonad.Util.SpawnOnce (spawnOnce)
import XMonad.Actions.SpawnOn (spawnOn, manageSpawn)
import XMonad.Layout.WindowArranger (pattern DecreaseRight, pattern IncreaseUp, windowArrange)
import XMonad.Util.Run(spawnPipe, safeSpawn)
import System.Environment (setEnv)
import System.Info (os)
import XMonad.Layout.IndependentScreens (countScreens)
import XMonad.Actions.DynamicProjects (dynamicProjects)
import XMonad.Util.NamedActions (addDescrKeys')
import XMonad.StackSet (findTag, view)
import XMonad.Util.NamedWindows (getName)

import Local.Colors (myFocusBorderColor, myColor, myBorderColor)
import Local.KeyBindings (superKeyMask, keybinds, searchPromptKeybindings, myRemoveKeys, showKeyBindings)
import Local.Workspaces (myWorkspaces, projects)
import Local.MouseBinding (myMouseBindings)
import Local.ManagedHook (myManageHook, myManageHook')
import Local.Layouts (myLayouts)
import Local.PolybarLogHook (eventLogHookForPolybar)
import Local.DzenLogHook (dzenLogHook)

myFont :: String
myFont  = "terminus"

-- TODO fix the screen width
togglevga :: IO String
togglevga = do { screencount <- countScreens
    ; if screencount > 1
       then do
      let screenWidth = "2560"
      -- spawn "xrandr --output LVDS-0 --off --output HDMI-0 --auto"
      return screenWidth
       else do
      let screenWidth = "683"
      -- spawn "xrandr --output LVDS-0 --auto"
      return screenWidth
    ;}

topLeftBar :: String
topLeftBar = "dzen2 -x '0' -y '0' -h '14' -w '800' -ta 'l' -fg '" ++ myColor "foreground" ++ "' -bg '"++ myColor "background" ++"' -fn "++myFont
-- topMiddleBar = "~/.xmonad/assets/bin/main.sh | dzen2 -dock -x '600' -y '0' -h '14' -w '500' -ta 'l' -fg '" ++ myColor "foreground" ++ "' -bg '" ++ myColor "background" ++ "' -fn " ++ myFont

topRightBar :: String
topRightBar = "xmonad-conky-date | dzen2 -dock -x '2300' -y '0' -h '14' -w '500' -ta 'l' -fg '" ++ myColor "foreground" ++ "' -bg '" ++ myColor "background" ++ "' -fn " ++ myFont

myDzen :: String
myDzen = " dzen2 -xs 1 -dock -h 14 -ta 'l' -fn '" ++ myFont ++ "' -fg '" ++ myColor "foreground" ++ "' -bg '" ++ myColor "background" ++ "' "

myTopRight :: String
myTopRight = "conky -c ~/.config/conky/xmonad-bar-top-right | " ++ myDzen ++ " -x '800' -y '0' -ta 'r' -p"

main :: IO ()
main = do
  screenWidth <- togglevga
  -- for polybar
  safeSpawn "mkfifo" ["/tmp/.xmonad-info"]

  dzenLeftBar <- spawnPipe topLeftBar
  conkyTopRight <- spawnPipe myTopRight

  xmonad
    $ withUrgencyHook LibNotifyUrgencyHook
    -- $ withUrgencyHook NoUrgencyHook
    $ dynamicProjects projects
    $ docks
    $ ewmh
    -- once the code is done, turn on the following
    $ addDescrKeys' ((superKeyMask, xK_F1), showKeyBindings) keybinds
    -- https://github.com/Xervon/dotfiles/blob/48e379b2d1c175ff8de5607415ebd5e1d45f75b4/xmonad/lib/Config/Keybinds.hs
    -- $ myConfig { logHook = dynamicLogWithPP polybarLogHook }
    $ myConfig { logHook =
      case os of
        -- "freebsd" -> dynamicLogWithPP polybarLogHook
        "freebsd"   -> dynamicLogWithPP $ dzenLogHook dzenLeftBar
        "linux"   -> dynamicLogWithPP $ dzenLogHook dzenLeftBar
        -- "linux"   -> dynamicLogWithPP polybarLogHook
        _    -> eventLogHookForPolybar
    }
    `removeKeys` myRemoveKeys
    `additionalKeysP` searchPromptKeybindings
    `additionalKeys` []

myTerminal :: String
myTerminal = "alacritty"

myBorderWidth :: Dimension
myBorderWidth = 1

-- myBrowser :: String
-- myBrowser = "brave"

------------------------------------------------------------------------
-- desktop notifications -- dunst package required
------------------------------------------------------------------------

data LibNotifyUrgencyHook = LibNotifyUrgencyHook deriving (Read, Show)

instance UrgencyHook LibNotifyUrgencyHook where
    urgencyHook LibNotifyUrgencyHook w = do
        name     <- getName w
        -- Just idx <- fmap (findTag w) $ gets windowset
        Just idx <- findTag w <$> gets windowset

        safeSpawn "notify-send" [show name, "workspace " ++ idx]

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
    -- spawnOnce "$HOME/.config/polybar/launch.sh xmonad"
    spawnOnce "flameshot" --dbus required
    spawnOnce "dunst"
    -- spawnOnce "picom"
    spawnOnce "picom --experimental-backends --backend glx --xrender-sync-fence"
    -- spawnOnce "sxhkd -c ~/.config/sxhkd/sxhkdrc-xmonad"
    -- spawn "clipmenud" --should I run copyq or clipmenu
    spawnOnce "copyq"
    spawnOn (myWorkspaces !! 7) "slack -u"
    spawnOn (myWorkspaces !! 0) "alacritty"
    case os of
      "freebsd" -> return ()
      "linux"   -> spawnOnce "blueman-applet" --dbus required
      _    -> return ()
    case os of
      "freebsd" -> return ()
      "linux"   -> spawnOnce "pamac-tray"
      _    -> return ()
    spawnOnce "numlockx on"
    spawnOnce "emacs --daemon"
    spawnOnce "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
    -- spawnOnce "trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --widthtype pixel --width 108 --transparent true --tint 0x000000 --height 18 --alpha 0"
    spawnOnce "trayer --edge bottom --align right --SetDockType true --SetPartialStrut true --expand true --widthtype pixel --width 120 --transparent true --tint 0x000000 --height 18 --alpha 0"
    spawnOnce "conky -c $HOME/.config/conky/xmonad-system-overview"
    -- spawnOnce "mpDris2" -- required for mpd
    spawnOnce "volumeicon"
    spawnOnce "xscreensaver -no-splash"
    spawnOnce "feh --no-fehbg --bg-scale $HOME/.local/wallpaper/minnesota-vikings-dark.png"
    -- spawnOnce "killall redshift; sleep 4 ; redshift -l 48.024395:11.598893 &"
    windows $ view (myWorkspaces !! 0)

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
  , startupHook = docksStartupHook <+> myStartupHook
  , focusFollowsMouse = False
  , clickJustFocuses = False
  , borderWidth = myBorderWidth
  , normalBorderColor = myBorderColor
  , focusedBorderColor = myFocusBorderColor
  , workspaces = myWorkspaces
  , modMask = superKeyMask
  -- >> updatePointer (0.25, 0.25) (0.25, 0.25)
  }
   `additionalKeysP`
   [
   ]
   `additionalKeys`
   [
   ]
