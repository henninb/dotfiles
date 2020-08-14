import XMonad

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.Minimize
import XMonad.Hooks.Place
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook
import XMonad.Util.EZConfig
import XMonad.Util.NamedActions
import XMonad.Layout.FixedColumn
import XMonad.Layout.LimitWindows
import XMonad.Layout.Magnifier
import XMonad.Layout.Minimize
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Renamed
import XMonad.Layout.Spacing
import XMonad.Layout.ThreeColumns
import XMonad.Layout.WindowArranger
import XMonad.Layout.Gaps

import qualified DBus as D
import qualified DBus.Client as D
import qualified XMonad.Layout.BoringWindows as B

import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import qualified Codec.Binary.UTF8.String as UTF8

main :: IO ()
main = do
  dbus <- D.connectSession
  D.requestName dbus (D.busName_ "org.xmonad.log")
    [D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue]

  xmonad
    $ withUrgencyHook NoUrgencyHook
    $ ewmh
    $ myConfig { logHook = dynamicLogWithPP (myLogHook dbus) }
    `additionalKeysP` myKeys
    -- `additionalKeys` []
    --`removeKeys` []

myTerminal :: String
myTerminal = "urxvt"
--myModMask      = mod4Mask
myModMask = mod1Mask
myBorderWidth = 1
myBrowser = "firefox"
mySpacing :: Int
mySpacing = 5

-- Colors
bg :: String
bg = "#282828"
red :: String
red = "#fb4934"
blue ::String
blue = "#83a598"
purple :: String
purple = "#d3869b"
pur2 :: String
pur2 = "#5b51c9"
blue2 :: String
blue2 = "#2266d0"

myLayouts = renamed [CutWordsLeft 1] . avoidStruts . minimize . B.boringWindows $ perWS

-- layout per workspace
perWS = onWorkspace ws1 my3FT $
        onWorkspace ws2 myAll $
        onWorkspace ws3 myFTM $
        onWorkspace ws4 my3FT $
        onWorkspace ws5 myFTM $
        onWorkspace ws6 myFT myAll -- all layouts for all other workspaces

myFT  = myTileLayout ||| myFullLayout ||| commonLayout
myFTM = myTileLayout ||| myFullLayout ||| myMagn
my3FT = myTileLayout ||| myFullLayout ||| my3cmi
myAll = myTileLayout ||| myFullLayout ||| my3cmi ||| myMagn

myFullLayout = renamed [Replace "Full"]
    $ gaps [(U,5), (D,5)]
    $ noBorders Full
myTileLayout = renamed [Replace "Main"]
    $ Tall 1 (3/100) (1/2)
my3cmi = renamed [Replace "3Col"]
    $ ThreeColMid 1 (3/100) (1/2)
myMagn = renamed [Replace "Mag"]
    $ noBorders
    $ limitWindows 3
    $ magnifiercz' 1.4
    $ FixedColumn 1 20 80 10
commonLayout = renamed [Replace "Com"]
    $ avoidStruts
    $ gaps [(U,5), (D,5)]
    $ Tall 1 (5/100) (1/3)


ws1 = "1"
ws2 = "2"
ws3 = "3"
ws4 = "4"
ws5 = "5"
ws6 = "6"
ws7 = "7"
ws8 = "8"
ws9 = "9"

myWorkspaces :: [String]
myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

myKeys :: [(String, X ())]
myKeys = [
    ("M-S-e"             , spawn "emacs")
  , ("M-e"               , spawn "urxvt -e nvim")
  , ("M-r"               , spawn "urxvt -e lf")
  , ("M-i"               , spawn "brave-browser")
  , ("M-S-i"             , spawn ("firefox" ++ " -private-window"))
  -- , ("M-<Print>"      , spawn "flameshot gui -p $HOME/Desktop")
  , ("M-S-<Return>"      , spawn myTerminal)
  , ("M-<Return>"        , spawn "alacritty")
  , ("M-S-<Backspace>"   , spawn "xdo close")
  , ("M-S-<Escape>"      , spawn "xmonad_exit")
  , ("M-S-p"             , spawn "dmenu_run -nb orange -nf '#444' -sb yellow -sf black -fn 'monofur for Powerline'")

  , ("M-m", windows W.focusMaster)             -- Move focus to the master window
  , ("M-j", windows W.focusDown)               -- Move focus to the next window
  , ("M-k", windows W.focusUp)                 -- Move focus to the prev window
  , ("M-S-m", windows W.swapMaster)            -- Swap the focused window and the master window
  , ("M-S-j", windows W.swapDown)              -- Swap the focused window with the next window
  , ("M-S-k", windows W.swapUp)                -- Swap the focused window with the prev window
  , ("M-<Up>", sendMessage (MoveUp 10))             --  Move focused window to up
  , ("M-<Down>", sendMessage (MoveDown 10))         --  Move focused window to down
  , ("M-<Right>", sendMessage (MoveRight 10))       --  Move focused window to right
  , ("M-<Left>", sendMessage (MoveLeft 10))         --  Move focused window to left
  , ("M-S-<Up>", sendMessage (IncreaseUp 10))       --  Increase size of focused window up
  , ("M-S-<Down>", sendMessage (IncreaseDown 10))   --  Increase size of focused window down
  , ("M-S-<Right>", sendMessage (IncreaseRight 10)) --  Increase size of focused window right
  , ("M-S-<Left>", sendMessage (IncreaseLeft 10))   --  Increase size of focused window left
  , ("M-C-<Up>", sendMessage (DecreaseUp 10))       --  Decrease size of focused window up
  , ("M-C-<Down>", sendMessage (DecreaseDown 10))   --  Decrease size of focused window down
  , ("M-C-<Right>", sendMessage (DecreaseRight 10)) --  Decrease size of focused window right
  , ("M-C-<Left>", sendMessage (DecreaseLeft 10))   --  Decrease size of focused window left
  ]
     -- ++
    -- []
    -- ((m .|. mod4Mask, k), windows $ f i)
    --      | (i, k) <- zip myWorkspaces [xK_1 .. xK_9]
    --      , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

myKeys1 :: [((KeyMask, KeySym), X ())]
--myKeys :: [((ButtonMask, KeySym), X ())]
myKeys1 = [ ((mod1Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock") ]

-- myAdditionalKeys c = (subtitle "Custom Keys":) $ mkNamedKeymap c $
--   myProgramKeys ++ myWindowManagerKeys ++ myMediaKeys

-- myProgramKeys =
--   [
--     ("M-S-e"             , addName "open emacs" $ spawn "emacs")
--   , ("M-e"               , addName "open neovim" $ spawn "urxvt -e nvim")
--   , ("M-r"               , addName "open lf" $ spawn "urxvt -e lf")
--   , ("M-i"               , addName "Open firefox" $ spawn "brave-browser")
--   , ("M-S-i"             , addName "Open firefox private" $ spawn ("firefox" ++ " -private-window"))
--   , ("M-S-<Return>"      , addName "open default terminal" $ spawn myTerminal)
--   , ("M-<Return>"        , addName "open backup terminal" $ spawn "alacritty")
--   , ("M-S-<Backspace>"   , addName "" $ spawn "xdo close")
--   , ("M-S-<Escape>"      , addName "exit xmonad" $ spawn "xmonad_exit")
--   , ("M-S-p"             , addName "open dmenu" $ spawn "dmenu_run -nb orange -nf '#444' -sb yellow -sf black -fn 'monofur for Powerline'")
--   ]

-- myWindowManagerKeys =
--   [
--   ]

-- myMediaKeys =
--   [ ("<XF86MonBrightnessUp>"   , addName "Increase backlight" $ spawn "xbacklight -inc 10")
--   , ("<XF86AudioPrev>"         , addName "Previous track" $ spawn "mpc prev")
--   , ("<XF86AudioNext>"         , addName "Next track" $ spawn "mpc next")
--   , ("<XF86AudioPlay>"         , addName "Toggle play/pause" $ spawn "mpc toggle")
--   , ("<XF86AudioRaiseVolume>"  , addName "Raise volume" $ spawn "pactl set-sink-volume 1 +5%")
--   , ("<XF86AudioLowerVolume>"  , addName "Lower volume" $ spawn "pactl set-sink-volume 1 -5%")
--   , ("<XF86AudioMute>"         , addName "Toggle mute" $ spawn "pactl set-sink-mute 1 toggle")
--   , ("C-S-="                   , addName "Raise volume" $ spawn "pactl set-sink-volume 1 +5%")
--   , ("C-S--"                   , addName "Lower volume" $ spawn "pactl set-sink-volume 1 -5%")
--   , ("C-S-,"                   , addName "Previous track" $ spawn "mpc prev")
--   , ("C-S-."                   , addName "Next track" $ spawn "mpc next")
--   , ("C-S-/"                   , addName "Toggle play/pause" $ spawn "mpc toggle")
--   ]

myManageHook = composeAll
    [ className =? "MPlayer"          --> doFloat
    , className =? "Gimp"             --> doFloat
    , resource  =? "desktop_window"   --> doIgnore
    , className =? "feh"              --> doFloat
    , role      =? "pop-up"           --> doFloat
    ]
  where
    role = stringProperty "WM_WINDOW_ROLE"

myManageHook' = composeOne [ isFullscreen -?> doFullFloat ]

myLogHook :: D.Client -> PP
myLogHook dbus = def
    { ppOutput = dbusOutput dbus
    , ppCurrent = wrap ("%{F" ++ blue2 ++ "} ") " %{F-}"
    , ppVisible = wrap ("%{F" ++ blue ++ "} ") " %{F-}"
    , ppUrgent = wrap ("%{F" ++ red ++ "} ") " %{F-}"
    , ppHidden = wrap " " " "
    , ppWsSep = ""
    , ppSep = " | "
    , ppTitle = myAddSpaces 25
    }

-- Emit a DBus signal on log updates
dbusOutput :: D.Client -> String -> IO ()
dbusOutput dbus str = do
    let signal = (D.signal objectPath interfaceName memberName) {
            D.signalBody = [D.toVariant $ UTF8.decodeString str]
        }
    D.emit dbus signal
  where
    objectPath = D.objectPath_ "/org/xmonad/Log"
    interfaceName = D.interfaceName_ "org.xmonad.Log"
    memberName = D.memberName_ "Update"

myAddSpaces :: Int -> String -> String
myAddSpaces len str = sstr ++ replicate (len - length sstr) ' '
  where
    sstr = shorten len str

myStartupHook = do
  setWMName "LG3D"
  spawn "$HOME/.config/polybar/launch.sh xmonad"
  --spawn "flashshot"

myConfig = def
  { terminal = myTerminal
  , layoutHook = windowArrange myLayouts
  , manageHook = placeHook(smart(0.5, 0.5))
      <+> manageDocks
      <+> myManageHook
      <+> myManageHook'
      <+> manageHook def
  , handleEventHook = docksEventHook
      <+> minimizeEventHook
      <+> fullscreenEventHook
  , startupHook = myStartupHook
  , focusFollowsMouse = False
  , clickJustFocuses = False
  , borderWidth = myBorderWidth
  , normalBorderColor = bg
  , focusedBorderColor = pur2
  , workspaces = myWorkspaces
  , modMask = myModMask
  }
-- myDefaults = myConfig
             `additionalKeysP`
             [ ("<Print>", spawn "flameshot gui -p $HOME/Desktop"),
               ("M-<Print>", spawn "flameshot gui -p $HOME/Desktop"),
               ("C-<Print>", spawn "xeyes")
             ]
