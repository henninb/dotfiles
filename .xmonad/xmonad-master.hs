import XMonad
import System.Exit
import System.IO
import XMonad.Actions.SpawnOn
import XMonad.Operations
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.SpawnOnce

import qualified Data.Map as M
import Data.Monoid
import Graphics.X11.ExtraTypes.XF86
import XMonad.Actions.CycleWS
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook
import qualified XMonad.StackSet as W

import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.Fullscreen

import XMonad.Layout.Grid
import XMonad.Layout.Mosaic
import XMonad.Layout.NoBorders
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.IndependentScreens

import XMonad.Prompt ( XPPosition (Top), alwaysHighlight, font , position, promptBorderWidth )
import XMonad.Prompt.ConfirmPrompt ( confirmPrompt )

import Graphics.X11.Xinerama (getScreenInfo)
import Graphics.X11.Xlib.Types (Rectangle)
--import qualified XMonad.DBus as D
import qualified DBus as D
import qualified DBus.Client as D
import qualified Codec.Binary.UTF8.String as UTF8

xdisplays :: X [Rectangle]
xdisplays = withDisplay $ io . getScreenInfo

myTerminal = "urxvt"
myBrowser = "firefox"
myFont = "xft:SauceCodePro NF:pixelsize=16"
--myBar = "xmobar ~/.config/xmobar/xmobarrc"
myBar = "$HOME/.config/polybar/launch-master.sh xmonad"
-- myBar = "dzen2 -y -1"
-- myBar = "dzen2 -bg lightblue -fg grey80 -fn fixed"
-- myBar = "date | dzen2 -p -bg black -fg grey80 -fn fixed"
-- myBar = "echo 'Arch is the best' | dzen2 -fg black -bg lightblue -w 230 -p -e & transset .3 & sleep 1 ; xdotool mousemove 5 5 ; xdotool click 1"


---- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

  --myWorkspaces    = ["1","2","3","4","5","6","7","8","9","aa","bb","cc","dd"]
myWorkspaces =
    ["1:web", "2:term", "3:mail", "4:files", "5:steam", "6:media", "7:audio", "8:misc", "9:other"]

myKeys conf@XConfig {XMonad.modMask = modMask} =
    M.fromList $
    [
      --((modMask .|. shiftMask, xK_Return), spawn myTerminal)
    -- ((modMask .|. shiftMask, xK_Return), spawn "urxvt")
    ((modMask .|. shiftMask, xK_Return), spawn "urxvt")
  --, ((modMask,                 xK_Return), spawn "termite")
  , ((modMask,                 xK_Return), spawn "alacritty")
  , ((modMask,               xK_i), spawn myBrowser)
  , ((modMask .|. shiftMask, xK_i), spawn (myBrowser ++ " -private-window"))
  --, ((modMask .|. shiftMask, xK_p), spawn "rofi -show drun")
  , ((modMask .|. shiftMask, xK_p), spawn "dmenu_run -nb orange -nf '#444' -sb yellow -sf black -fn 'monofur for Powerline'")
  , ((modMask .|. shiftMask, xK_x), spawn "xscreensaver-command -lock")
   -- close focused window
  , ((modMask .|. shiftMask, xK_BackSpace), kill)
    --- Rotate through the available layout algorithms

    , ((0, xF86XK_AudioLowerVolume   ), spawn "amixer -q -D pulse sset Master 2%-")
    , ((0, xF86XK_AudioRaiseVolume   ), spawn "amixer -q -D pulse sset Master 2%+")
    --, ((0, xF86XK_AudioMute          ), spawn "amixer set Master toggle")
    , ((0, xF86XK_AudioMute          ), spawn "amixer -D pulse sset Master toggle")

  , ((modMask,               xK_space), sendMessage NextLayout)
    --  Reset the layouts on the current workspace to default
  , ((modMask .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf)
    -- Resize viewed windows to the correct size
  , ((modMask, xK_n), refresh)
    -- Move focus to the next window
  , ((modMask, xK_Tab), windows W.focusDown)
    -- Move focus to the next window
  , ((modMask, xK_j), windows W.focusDown)
    -- Move focus to the previous window
  , ((modMask, xK_k), windows W.focusUp)
    -- Volume Control
    -- Brightness Control
    -- Move focus to the master window
  , ((modMask, xK_m), windows W.focusMaster)
    -- Swap the focused window and the master window
    -- Swap the focused window with the next window
  , ((modMask .|. shiftMask, xK_j), windows W.swapDown)
    -- Swap the focused window with the previous window
  , ((modMask .|. shiftMask, xK_k), windows W.swapUp)
    -- Push window back into tiling
  , ((modMask, xK_t), withFocused $ windows . W.sink)
    -- Increment the number of windows in the master area
    -- Deincrement the number of windows in the master area
    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- Quit xmonad
  --, ((modMask .|. shiftMask, xK_q), io (exitWith ExitSuccess))
  --, (( modMask.|. shiftMask, xK_q), confirmPrompt myXPConfig "exit" (io exitSuccess))
  , (( modMask.|. shiftMask, xK_Escape), confirmPrompt myXPConfig "exit" (io exitSuccess))
  , ( (mod1Mask .|. shiftMask, xK_r), spawn "xmonad --recompile; xmonad --restart")
  , ((0, xK_F12), namedScratchpadAction myScratchPads "terminator")
  , ((0, xK_F11), namedScratchpadAction myScratchPads "firefox")
  , ((modMask, xK_f), sendMessage (Toggle "Full"))
  ] ++
    --
    -- mod-[1..9], Switch to workspace N
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
  [ ((m .|. modMask, k), windows $ f i)
  | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
  , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
  ] ++
    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
  [ ((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
  | (key, sc) <- zip [xK_w, xK_e, xK_r] [0 ..]
  , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
  ]

myXPConfig = def
  { position          = Top
  , alwaysHighlight   = True
  , promptBorderWidth = 0
  --, font              = "xft:monospace:size=12"
  , font              = "xft:SauceCodePro NF:pixelsize=16"
  }

--  , ((modMask .|. mod1Mask, xK_u), spawn "setxkbmap -layout us")
--  , ((modMask, xK_o), namedScratchpadAction myScratchPads "terminal")
--  , ((modMask, xK_p), namedScratchpadAction myScratchPads "music")
myStartupHook =
  spawn "/usr/bin/stalonetray"-- spawn "nm-applet"

myScratchPads =
  [
    NS "terminator" "terminator" (appName =? "terminator") nonFloating
  , NS "termite" "termite" (appName =? "termite") nonFloating
  , NS "firefox" "firefox" (className =? "Firefox") nonFloating
  , NS "Steam" "Steam"     (className =? "Steam") doFloat
  , NS "arduino" "arduino" (className =? "arduino") doFloat
  ]

myManageHook =
  composeAll
    [ className =? "stalonetray" --> doIgnore
    , className =? "rdesktop" --> doFullFloat
    --, className =? "Firefox" --> doFullFloat
    , title =? "Outlast" --> doFullFloat
    , title =? "Path of Exile" --> doFullFloat
    , manageDocks
    , isFullscreen --> (doF W.focusDown <+> doFullFloat)
    ] <+>
  namedScratchpadManageHook myScratchPads

--      , className =? "mpv"          --> doFullFloat
myMouseBindings XConfig {XMonad.modMask = modMask} =
  M.fromList
    -- mod-button1, Set the window to floating mode and move by dragging
  [ ((modMask, button1)
    , \w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster)
    -- mod-button2, Raise the window to the top of the stack
  , ((modMask, button2), \ w -> focus w >> windows W.shiftMaster)
    -- mod-button3, Set the window to floating mode and resize by dragging
  , ( (modMask, button3)
    , \w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster)
    -- you may also bind events to the mouse scroll wheel (button4 and button5)
  ]

-- myLogHook :: D.Client -> PP
-- myLogHook dbus = def { ppOutput = D.send dbus }
myLogHook :: D.Client -> PP
myLogHook dbus = def
    { ppOutput = dbusOutput dbus
    , ppCurrent = wrap ("%{F" ++ "#2266d0" ++ "} ") " %{F-}"
    , ppVisible = wrap ("%{F" ++ "#83a598" ++ "} ") " %{F-}"
    , ppUrgent = wrap ("%{F" ++ "#fb4934" ++ "} ") " %{F-}"
    , ppHidden = wrap " " " "
    , ppWsSep = ""
    , ppSep = " | "
    , ppTitle = myAddSpaces 25
    }

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


myLayoutHook =
  avoidStruts
    (toggleLayouts Full Grid |||
     toggleLayouts Full (ThreeColMid 1 (1 / 20) (1 / 2)) |||
     simpleTabbed ||| toggleLayouts Full tiled ||| Mirror tiled)
  where
    -- default tiling algorithm partitions the screen into two panes
    tiled = Tall nmaster delta ratio
    -- The default number of windows in the master pane
    nmaster = 1
    -- Default proportion of screen occupied by master pane
    ratio = 1 / 2
    -- Percent of screen to increment by when resizing panes

delta = 3 / 100

main = do

  xmproc <- spawnPipe myBar
  --dbus <- D.connectSession
  --D.requestAccess dbus
  xmonad $
    -- ewmh $
    docks $
    defaults
      --{ logHook = myLogHook
      { logHook =
          dynamicLogWithPP $
          xmobarPP
            { ppOutput = hPutStrLn xmproc
         -- ,ppVisible = xmobarColor "#7F7F7F" ""
         -- ,ppTitle = xmobarColor "#222222" ""
         -- ,ppCurrent = xmobarColor "#2E9AFE" ""
         -- ,ppHidden  = xmobarColor "#7F7F7F" ""
         -- ,ppLayout = xmobarColor"#7F7F7F" ""
         -- ,ppUrgent = xmobarColor "#900000" "" . wrap "[" "]"
            }
      , manageHook = manageDocks <+> (isFullscreen --> doFullFloat) <+> myManageHook
      , startupHook = setWMName "LG3D"
      -- , startupHook = myStartupHook
      }

defaults =
  def
    --modMask = mod4Mask
    { terminal = myTerminal
    , workspaces = myWorkspaces
    , keys = myKeys
    , layoutHook = smartBorders myLayoutHook
    , handleEventHook = handleEventHook def <+> docksEventHook
    , focusedBorderColor = "#2E9AFE"
    , normalBorderColor = "#000000"
    , mouseBindings = myMouseBindings
    , manageHook = myManageHook <+> manageHook def
    , borderWidth = 1
    , startupHook = myStartupHook
--    , logHooks = xmproc
    }
