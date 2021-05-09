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
import XMonad.Layout.LimitWindows
import XMonad.Layout.Magnifier
import XMonad.Layout.Minimize
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Renamed
import XMonad.Layout.Spacing
import XMonad.Layout.ThreeColumns
import XMonad.Layout.WindowArranger --DecreaseRight, IncreaseUp
import XMonad.Layout.Gaps
import XMonad.Actions.Submap
-- Prompt
import XMonad.Prompt
import XMonad.Prompt.FuzzyMatch
import Control.Arrow (first)

import XMonad.Util.NamedScratchpad (namedScratchpadManageHook)

import Graphics.X11.ExtraTypes
import XMonad.Util.Paste (sendKey)

import qualified XMonad.Actions.Search as S

import XMonad.Util.Run(spawnPipe, safeSpawn)

import qualified XMonad.Layout.BoringWindows as B
import Control.Monad (forM_, join, liftM2)

import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import qualified Codec.Binary.UTF8.String as UTF8
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

import qualified Local.KeyBindings as Local
-- import qualified Local.Workspaces as Local
import Local.Workspaces


ws1 = "1"
ws2 = "2"
ws3 = "3"
ws4 = "4"
ws5 = "5"
ws6 = "6"
ws7 = "7"
ws8 = "8"
ws9 = "9"
ws0 = "0"

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
    -- `additionalKeysP` myKeys
    `additionalKeysP` Local.keyMaps
    `additionalKeys` []

myTerminal :: String
myTerminal = "alacritty"
--myModMask      = mod4Mask
-- modMask = 115 -- Windows start button
-- modMask = xK_Meta_L

-- xmodmap - shows the key mapping
-- TODO: need to fix as the Win [M1] key is now useless
altKeyMask :: KeyMask
altKeyMask = mod1Mask

superKeyMask :: KeyMask
superKeyMask = mod4Mask

myFont :: String
myFont = "xft:monofur for Powerline:bold:size=9:antialias=true:hinting=true"

myBorderWidth :: Dimension
myBorderWidth = 1

myBrowser :: String
myBrowser = "brave"

mySpacing :: Int
mySpacing = 5

-- Purple
myBorderColor :: String
myBorderColor = "#282828"

red :: String
red = "#fb4934"

myFocusBorderColor :: String
myFocusBorderColor = "#5b51c9"

gray = "#888974"
purple = "#d3869b"
aqua = "#8ec07c"

myRemoveKeys :: [(KeyMask, KeySym)]
myRemoveKeys = [
                 (superKeyMask .|. shiftMask, xK_space)
               , (superKeyMask, xK_q)
               , (superKeyMask, xK_e)
               , (superKeyMask, xK_p)
               , (superKeyMask, xK_x)
               , (controlMask, xK_p)
               , (superKeyMask .|. shiftMask, xK_q)
               , (superKeyMask .|. shiftMask, xK_c)
               -- , (superKeyMask, xK_space)
               ]

archwiki, ebay, news, reddit, urban :: S.SearchEngine
archwiki = S.searchEngine "archwiki" "https://wiki.archlinux.org/index.php?search="
ebay     = S.searchEngine "ebay" "https://www.ebay.com/sch/i.html?_nkw="
news     = S.searchEngine "news" "https://news.google.com/search?q="
reddit   = S.searchEngine "reddit" "https://www.reddit.com/search/?q="
urban    = S.searchEngine "urban" "https://www.urbandictionary.com/define.php?term="

searchList :: [(String, S.SearchEngine)]
searchList = [ ("a", archwiki)
    , ("d", S.duckduckgo)
    , ("e", ebay)
    , ("g", S.google)
    , ("h", S.hoogle)
    , ("i", S.images)
    , ("n", news)
    , ("r", reddit)
    , ("s", S.stackage)
    , ("t", S.thesaurus)
    , ("v", S.vocabulary)
    , ("b", S.wayback)
    , ("u", urban)
    , ("w", S.wikipedia)
    , ("y", S.youtube)
    , ("z", S.amazon)
  ]

myXPKeymap :: M.Map (KeyMask,KeySym) (XP ())
myXPKeymap = M.fromList $
     map (first $ (,) controlMask)   -- control + <key>
     [ (xK_z, killBefore)            -- kill line backwards
     , (xK_k, killAfter)             -- kill line forwards
     , (xK_a, startOfLine)           -- move to the beginning of the line
     , (xK_e, endOfLine)             -- move to the end of the line
     , (xK_m, deleteString Next)     -- delete a character foward
     , (xK_b, moveCursor Prev)       -- move cursor forward
     , (xK_f, moveCursor Next)       -- move cursor backward
     , (xK_BackSpace, killWord Prev) -- kill the previous word
     , (xK_v, pasteString)           -- paste a string
     , (xK_g, quit)                  -- quit out of prompt
     , (xK_bracketleft, quit)
     ]
     ++
     map (first $ (,) superKeyMask)       -- meta key + <key>
     [ (xK_BackSpace, killWord Prev) -- kill the prev word
     , (xK_f, moveWord Next)         -- move a word forward
     , (xK_b, moveWord Prev)         -- move a word backward
     , (xK_d, killWord Next)         -- kill the next word
     , (xK_n, moveHistory W.focusUp')   -- move up thru history
     , (xK_p, moveHistory W.focusDown') -- move down thru history
     ]
     ++
     map (first $ (,) 0) -- <key>
     [ (xK_Return, setSuccess True >> setDone True)
     , (xK_KP_Enter, setSuccess True >> setDone True)
     , (xK_BackSpace, deleteString Prev)
     , (xK_Delete, deleteString Next)
     , (xK_Left, moveCursor Prev)
     , (xK_Right, moveCursor Next)
     , (xK_Home, startOfLine)
     , (xK_End, endOfLine)
     , (xK_Down, moveHistory W.focusUp')
     , (xK_Up, moveHistory W.focusDown')
     , (xK_Escape, quit)
     ]

myXPConfig :: XPConfig
myXPConfig = def
      { font                = myFont
      , bgColor             = "#292d3e"
      , fgColor             = "#d0d0d0"
      , bgHLight            = "#c792ea"
      , fgHLight            = "#000000"
      , borderColor         = "#535974"
      , promptBorderWidth   = 0
      , promptKeymap        = myXPKeymap
      , position            = Top
      , height              = 20
      , historySize         = 256
      , historyFilter       = id
      , defaultText         = []
      , autoComplete        = Just 100000  -- set Just 100000 for .1 sec
      , showCompletionOnTab = False
      -- , searchPredicate     = isPrefixOf
      , searchPredicate     = fuzzyMatch
      , alwaysHighlight     = True
      , maxComplRows        = Nothing      -- set to Just 5 for 5 rows
      }

myXPConfig' :: XPConfig
myXPConfig' = myXPConfig
      { autoComplete        = Nothing
      }

-- TODO: not sure what this code does right now
-- keyBindings conf = let m = modMask conf in
--      M.fromList
--     [((m .|. superKeyMask, k), windows $ f i) |
--      (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9],
--      (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

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
myTiled = renamed [Replace "test1" ]
    $ Tall 1 (1/2)

-- xmobarEscape :: String -> String
-- xmobarEscape = concatMap doubleLts
--     where
--         doubleLts '<' = "<<"
--         doubleLts x   = [x]


-- myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces [1..] -- (,) == \x y -> (x,y)

-- runFlameshot :: String -> X ()
-- runFlameshot mode = do
--   ssDir <- io getCaptureDir
--   spawnCmd "flameshot" $ mode : ["-p", ssDir]

-- -- TODO this will steal focus from the current window (and puts it
-- -- in the root window?) ...need to fix
-- runAreaCapture :: X ()
-- runAreaCapture = runFlameshot "gui"

-- clipboardCopy :: X ()
-- clipboardCopy =
--   withFocused $ \w ->
--     b <- isTerminal w
--     if b
--     then (sendKey noModMask xF86XK_Copy)
--     else (sendKey controlMask xK_c)

-- clipboardPaste :: X ()
-- clipboardPaste =
--   withFocused $ \w ->
--       b <- isTerminal w
--       if b
--         then sendKey noModMask xF86XK_Paste
--         else sendKey controlMask xK_v

-- isTerminal :: Window -> X Bool
-- isTerminal = fmap (== "Alacritty") . runQuery className

myMouseBindings XConfig {XMonad.modMask = modm} = M.fromList
    [
--     -- mod-button1, Set the window to floating mode and move by dragging
     ((modm, button1),
   \ w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster),
--     -- mod-button2, Raise the window to the top of the stack
     ((modm, button2), \ w -> focus w >> windows W.shiftMaster),
--     -- mod-button3, Set the window to floating mode and resize by dragging
      ((modm, button3),
   \ w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster)
    ]

-- haskell is 0-indexed
myManageHook = composeAll
    [ className =? "MPlayer"          --> doFloat
    , title     =? "urxvt-float"      --> doFloat --custom window title
    , title     =? "st-float"         --> doFloat --custom window title
    , className =? "Gimp"             --> doFloat
    , className =? "Emacs"            --> viewShift ( myWorkspaces !! 6 )
    -- , className =? "discord"          --> viewShift ( myWorkspaces !! 8 )
    , title     =? "Oracle VM VirtualBox Manager"  --> doFloat
    , title     =? "Welcome to IntelliJ IDEA"      --> doFloat
    , title     =? "Welcome to IntelliJ IDEA"      --> viewShift ( myWorkspaces !! 4 )
    , className =? "audacity"                      --> doFloat
    , className =? "audacity"                      --> viewShift ( myWorkspaces !! 5 )
    , className =? "Audacity"                      --> doFloat
    , className =? "Audacity"                      --> viewShift ( myWorkspaces !! 5 )
    , className =? "jetbrains-idea"   --> doFloat
    , className =? "jetbrains-idea"   --> viewShift ( myWorkspaces !! 4 )
    , resource  =? "desktop_window"   --> doIgnore -- TODO: not sure what this does
    -- Float flameshot's imgur window
    -- , className =? "flameshot" <&&> fmap (isInfixOf "Upload to Imgur") title --> doFloat
    , className =? "feh"              --> doFloat
    , role      =? "pop-up"           --> doFloat
    , title     =? "Discord Updater" --> doFloat
    , (className =? "firefox" <&&> resource =? "Dialog") --> doFloat  -- Float Firefox Dialog
    , (className =? "Notepadqq" <&&> title =? "Search") --> doFloat
    , (className =? "Notepadqq" <&&> title =? "Advanced Search") --> doFloat
    , className =? "Xmessage" --> doFloat
    , role =? "browser" --> viewShift ( myWorkspaces !! 3 )
    ]  <+> namedScratchpadManageHook scratchPads
  where
    role = stringProperty "WM_WINDOW_ROLE"
    viewShift = doF . liftM2 (.) W.greedyView W.shift
    -- myShift = doF . liftM2 (.) W.greedyView

myManageHook' = composeOne [ isFullscreen -?> doFullFloat ]

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
