import XMonad
import XMonad.Layout
import XMonad.Layout.NoBorders (noBorders)
import XMonad.Layout.PerWorkspace
import XMonad.Layout.LayoutHints
import XMonad.Layout.ThreeColumns
import XMonad.Hooks.DynamicLog ( PP(..), dynamicLogWithPP, dzenColor, shorten, wrap, defaultPP )
import XMonad.Hooks.UrgencyHook
import XMonad.Util.Run (spawnPipe)
import qualified XMonad.StackSet as W
import qualified Data.Map as M

import System.IO (hPutStrLn)

  -- custom prompt
import XMonad.Prompt ( XPPosition (Top), alwaysHighlight, font , position, promptBorderWidth )
import XMonad.Prompt.ConfirmPrompt ( confirmPrompt )
import System.Exit


-- Control Center {{{
-- Colour scheme {{{
myNormalBGColor     = "#2e3436"
myFocusedBGColor    = "#414141"
myNormalFGColor     = "#babdb6"
myFocusedFGColor    = "#73d216"
myUrgentFGColor     = "#f57900"
myUrgentBGColor     = myNormalBGColor
mySeperatorColor    = "#2e3436"
-- }}}
-- Icon packs can be found here:
-- http://robm.selfip.net/wiki.sh/-main/DzenIconPacks
myBitmapsDir        = "/home/samet/.icons"
myFont              = "-*-terminus-medium-*-*-*-12-*-*-*-*-*-iso8859-1"
myBrowser = "firefox"
-- }}}

-- Workspaces {{{
myWorkspaces :: [WorkspaceId]
myWorkspaces = ["general", "internet", "chat", "code"] ++ map show [5..9 :: Int]
-- }}}

  -- Custom Prompt
  --myXPConfig = def
  --    { position          = Top
  --    , alwaysHighlight   = True
  --    , promptBorderWidth = 0
  --    --, font              = "xft:monospace:size=12"
  --    , font              = "xft:SauceCodePro NF:pixelsize=16"
  --    }

-- Keybindings {{{
myKeys conf@(XConfig {modMask = modm}) = M.fromList $
    [
      ((mod1Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
          , ((modm .|. shiftMask, xK_p), spawn "dmenu_run -nb orange -nf '#444' -sb yellow -s  f black -fn Monospace-9:normal")
          , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
          , ((0, xK_Print), spawn "scrot")
          , ((modm, xK_i), spawn myBrowser)
          , ((modm .|. shiftMask, xK_i), spawn (myBrowser ++ " -private-window"))
          --, ((mod4Mask .|. shiftMask, xK_BackSpace), kill)
          , ((modm .|. shiftMask, xK_BackSpace), kill)
--          , ((modm .|. shiftMask, xK_q), confirmPrompt myXPConfig "exit" (io exitSuccess))
    ]
    ++
    -- Remap switching workspaces to M-[asdfzxcv]
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_a, xK_s, xK_d, xK_f, xK_v]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
-- }}}

statusBarCmd= "dzen2 -p -h 16 -w 400 -ta l -bg '" ++ myNormalBGColor ++ "' -fg '" ++ myNormalFGColor ++ "'  -sa c -fn '" ++ myFont ++ "'"
-- statusBarCmd = "/home/samet/.bin/dzen.sh"


main = do
    statusBarPipe <- spawnPipe statusBarCmd
    xmonad  defaultConfig
        { modMask = mod1Mask -- Use Super instead of Alt
        , terminal = "urxvtc -bg black -fg gray +sb"
        , borderWidth = 1
        , normalBorderColor = myNormalBGColor
        , focusedBorderColor = myFocusedFGColor
        , manageHook = manageHook defaultConfig <+> myManageHook
        , workspaces = myWorkspaces
        , logHook = dynamicLogWithPP $ myPP statusBarPipe
        -- more changes
    }
    where
        globalLayout = layoutHints (tiled) ||| layoutHints (noBorders Full) ||| layoutHints (Mirror tiled) ||| layoutHints (Tall 1 (3/100) (1/2))
        chatLayout = layoutHints (noBorders Full)
        tiled = ThreeCol 1 (3/100) (1/2)



-- Window rules (floating, tagging, etc) {{{
myManageHook = composeAll [
        className   =? "Firefox-bin"        --> doF(W.shift "internet"),
        className   =? "Gajim.py"           --> doF(W.shift "chat"),

        title       =? "Gajim"              --> doFloat,
        className   =? "stalonetray"        --> doIgnore,
        className   =? "trayer"             --> doIgnore
    ]
-- }}}

-- Dzen Pretty Printer {{{
myPP i = defaultPP
           { ppCurrent = wrap "^fg(#DDDDDD)^bg(#323232)^p(6)" "^p(6)^fg()^bg()"
           , ppVisible = wrap "^fg(#555555)^bg(#232323)^p(6)" "^p(6)^fg()^bg()"
           , ppHidden  = wrap "^fg(#BBBBBB)^bg(#232323)^p(6)" "^p(6)^fg()^bg()"
           , ppHiddenNoWindows = wrap "^fg(#555555)^bg(#262626)^p(6)" "^p(6)^fg()^bg()"
           , ppLayout  = (\x -> case x of
                                     "Tall"        -> "^i(/home/samet/.icons/tileright.xbm)"
                                     "Mirror Tall" -> "^i(/home/samet/.icons//tilebottom.xbm)"
                                     "Full"        -> "^i(/home/samet/.icons/max.xbm)"
                                     "ThreeCol"    -> "^i(/home/samet/.icons/threecol.xbm)"
                                     )
           , ppTitle   = shorten 80
           , ppSep     = " "
           , ppWsSep   = ""
           , ppOutput  = hPutStrLn i
           }
