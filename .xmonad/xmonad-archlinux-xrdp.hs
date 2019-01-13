-------------------------------------------------
--   __   __                                _  --
--   \ \ / /                               | | --
--    \ V / _ __ ___   ___  _ __   __ _  __| | --
--     > < | '_ ` _ \ / _ \| '_ \ / _` |/ _` | --
--    / . \| | | | | | (_) | | | | (_| | (_| | --
--   /_/ \_\_| |_| |_|\___/|_| |_|\__,_|\__,_| --
-------------------------------------------------
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
import System.Exit
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

xdisplays :: X [Rectangle]
xdisplays = withDisplay $ io . getScreenInfo

myTerminal = "urxvt"
myBrowser = "firefox"
myFont = "xft:SauceCodePro NF:pixelsize=16"

---- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

--myWorkspaces    = ["1","2","3","4","5","6","7","8","9","aa","bb","cc","dd"]
myWorkspaces =
  ["1:web", "2:term", "3:mail", "4:files", "5:steam", "6:media", "7:audio", "8:misc", "9:other"]

-- xmobarEscape = concatMap doubleLts
--   where
--     doubleLts '<' = "<<"
--     doubleLts x = [x]
--myWorkspaces :: [String]
-- myWorkspaces =
--   clickable . (map xmobarEscape) $
--   [ "1:\xf269"
--   , "2:\xf120"
--   , "3:\xf0e0"
--   , "4:\xf07c"
--   , "5:\xf1b6"
--   , "6:\xf281"
--   , "7:\xf04b"
--   , "8:\xf167"
--   , "9"
--   ]
--   where
--     clickable l =
--       [ "<action=xdotool key super+" ++ show (n) ++ ">" ++ ws ++ "</action>"
--       | (i, ws) <- zip [1 .. 9] l
--       , let n = i
--       ]
myKeys conf@(XConfig {XMonad.modMask = modMask}) =
  M.fromList $
    -- launch a terminal
  [
    --((modMask, xK_Return), spawn myTerminal)
  -- ((modMask, xK_Return), spawn "urxvt")
    ((modMask, xK_Return), spawn "termite")
  , ((modMask, xK_i), spawn myBrowser)
  , ((modMask .|. shiftMask, xK_i), spawn (myBrowser ++ " -private-window"))
  , ((modMask .|. shiftMask, xK_p), spawn "rofi -show drun")
  , ((modMask .|. shiftMask, xK_t), spawn "terminator")
  , ((modMask .|. shiftMask, xK_y), spawn "urxvt")
  , ((modMask .|. shiftMask, xK_x), spawn "xscreensaver-command -lock")
   -- close focused window
  , ((modMask .|. shiftMask, xK_BackSpace), kill)
    --- Rotate through the available layout algorithms
  , ((modMask, xK_space), sendMessage NextLayout)
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
  , ((0, xF86XK_AudioMute), spawn "amixer set Master toggle")
  , ((0, xF86XK_AudioLowerVolume), spawn "amixer set Master 5%- unmute")
  , ((0, xF86XK_AudioRaiseVolume), spawn "amixer set Master 5%+ unmute")
    -- Brightness Control
  , ((0, xF86XK_MonBrightnessDown), spawn "xbacklight -dec 10")
  , ((0, xF86XK_MonBrightnessUp), spawn "xbacklight -inc 10")
    -- Move focus to the master window
  , ((modMask, xK_m), windows W.focusMaster)
    -- Swap the focused window and the master window
  , ((modMask .|. shiftMask, xK_Return), windows W.swapMaster)
    -- Swap the focused window with the next window
  , ((modMask .|. shiftMask, xK_j), windows W.swapDown)
    -- Swap the focused window with the previous window
  , ((modMask .|. shiftMask, xK_k), windows W.swapUp)
    -- Shrink the master area
  , ((modMask, xK_h), sendMessage Shrink)
    -- Expand the master area
  , ((modMask, xK_l), sendMessage Expand)
    -- Push window back into tiling
  , ((modMask, xK_t), withFocused $ windows . W.sink)
    -- Increment the number of windows in the master area
  , ((modMask, xK_comma), sendMessage (IncMasterN 1))
    -- Deincrement the number of windows in the master area
  , ((modMask, xK_period), sendMessage (IncMasterN (-1)))
    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
  , ((modMask, xK_b), sendMessage ToggleStruts)
    -- Quit xmonad
  --, ((modMask .|. shiftMask, xK_q), io (exitWith ExitSuccess))
  , (( modMask.|. shiftMask, xK_q), confirmPrompt myXPConfig "exit" (io exitSuccess))
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
myStartupHook = do
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
myMouseBindings (XConfig {XMonad.modMask = modMask}) =
  M.fromList $
    -- mod-button1, Set the window to floating mode and move by dragging
  [ ( (modMask, button1)
    , (\w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster))
    -- mod-button2, Raise the window to the top of the stack
  , ((modMask, button2), (\w -> focus w >> windows W.shiftMaster))
    -- mod-button3, Set the window to floating mode and resize by dragging
  , ( (modMask, button3)
    , (\w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster))
    -- you may also bind events to the mouse scroll wheel (button4 and button5)
  ]

myLayoutHook =
  avoidStruts
    (toggleLayouts Full (Grid) |||
     toggleLayouts Full (ThreeColMid 1 (1 / 20) (1 / 2)) |||
     simpleTabbed ||| toggleLayouts Full (tiled) ||| Mirror tiled)
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
  -- xmproc <- spawnPipe "xmobar -B white -a right -F blue"
  --xmproc <- spawnPipe "/usr/bin/xmobar /home/henninb/.config/xmobar/xmobarrc >>/tmp/xmobar.log 2>&1"
  --xmproc <- spawnPipe "/usr/bin/xmobar .config/xmobar/xmobarrc &!"
  -- good
  xmproc <- spawnPipe "/usr/bin/xmobar ~/.config/xmobar/xmobarrc"
  --xmproc <- spawnPipe "polybar desktop"
  --xmproc <- spawnPipe "/usr/bin/xmobar .config/xmobar/xmobarrc && ps -ef| grep xmobar > /tmp/xmobar.pid"
--  xmeyes <- spawnPipe("xeyes")
  -- n <- countScreens
  -- xmproc <- mapM(\i -> spawnPipe $ "xmobar" ++ show i ++ "-x " ++ show i) [0..n-1]
  -- xmproc <- spawnPipe ("xmobar -x " ++ show sid)
  xmonad $
    -- ewmh $
    docks $
    defaults
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
    , layoutHook = smartBorders $ myLayoutHook
    , handleEventHook = handleEventHook def <+> docksEventHook
    , focusedBorderColor = "#2E9AFE"
    , normalBorderColor = "#000000"
    , mouseBindings = myMouseBindings
    , manageHook = myManageHook <+> manageHook def
    , borderWidth = 1
    , startupHook = myStartupHook
--    , logHooks = xmproc
    }
