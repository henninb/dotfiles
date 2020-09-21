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
import XMonad.Actions.Submap
-- Prompt
import XMonad.Prompt
import XMonad.Prompt.FuzzyMatch
import Control.Arrow (first)

import Control.Monad (liftM2)

import Graphics.X11.ExtraTypes
import XMonad.Util.Paste (sendKey)

import qualified XMonad.Actions.Search as S

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
    `removeKeys` myRemoveKeys
    `additionalKeysP` myKeys
    `additionalKeys` []

myTerminal :: String
myTerminal = "alacritty"
--myModMask      = mod4Mask
-- modMask = 115 -- Windows start button
-- modMask = xK_Meta_L

altKeyMask :: KeyMask
altKeyMask = mod1Mask

myFont :: String
myFont = "xft:Mononoki Nerd Font:bold:size=9:antialias=true:hinting=true"

myBorderWidth :: Dimension
myBorderWidth = 1

myBrowser :: String
myBrowser = "firefox"

mySpacing :: Int
mySpacing = 5

-- Purple
myBorderColor :: String
myBorderColor = "#282828"

red :: String
red = "#fb4934"

myFocusBorderColor :: String
myFocusBorderColor = "#5b51c9"

myRemoveKeys = [
                 (altKeyMask .|. shiftMask, xK_space)
               , (altKeyMask, xK_q)
               , (altKeyMask .|. shiftMask, xK_q)
               , (altKeyMask .|. shiftMask, xK_c)
               , (altKeyMask, xK_space)
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
     map (first $ (,) altKeyMask)       -- meta key + <key>
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
keyBindings conf = let m = modMask conf in
     M.fromList
    [((m .|. altKeyMask, k), windows $ f i) |
     (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9],
     (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

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

isTerminal :: Window -> X Bool
isTerminal = fmap (== "Alacritty") . runQuery className

myKeys :: [(String, X ())]
myKeys = [
    ("M-S-e"             , spawn "emacs")
  , ("M-e"               , spawn "urxvt -e nvim")
  , ("M-r"               , spawn "urxvt -e lf")
  , ("M-i"               , spawn "brave-browser")
  , ("M-S-i"             , spawn ("firefox" ++ " -private-window"))
  , ("M-<Print>"         , spawn "flameshot gui -p $HOME/Desktop")
  -- , ("M-S-<Return>"      , spawn "tdrop -am -w 1355 -y 25 urxvt -name 'urxvt-float'")
  , ("M-S-<Return>"      , spawn "tdrop -am -w 1355 -y 25 st -T 'st-float'")
  , ("M-<Return>"        , spawn myTerminal)
  , ("M-S-<Backspace>"   , spawn "xdo close")
  , ("M-S-<Escape>"      , spawn "wm-exit xmonad")
  , ("M-<Escape>"        , spawn "xmonad --restart")
  , ("M-S-p"             , spawn "dmenu_run -nb orange -nf '#444' -sb yellow -sf black -fn 'monofur for Powerline'")
  -- , ("M-p"               , spawn "clipmenu -nb orange -nf '#444' -sb yellow -sf black -fn 'monofur for Powerline'")
  , ("M-v"               , sendKey noModMask xF86XK_Paste)
  -- , ("M-S-v"               , sendKey noModMask xF86XK_Select)
  , ("M-x"               , spawn "exec= redshift -O 3500")
  , ("M-S-x"             , spawn "exec= redshift -x")
  , ("<XF86AudioLowerVolume>", spawn "amixer set Master 5%- unmute")
  , ("<XF86AudioRaiseVolume>", spawn "amixer set Master 5%+ unmute")
  , ("<XF86AudioPlay>", spawn "mpc toggle")
  , ("<XF86AudioPrev>", spawn "mpc prev")
  , ("<XF86AudioNext>", spawn "mpc next")
  , ("M-m", windows W.focusMaster)
  , ("M-j", windows W.focusDown)
  , ("M-k", windows W.focusUp)
  , ("M-S-m", windows W.swapMaster)
  , ("M-S-j", windows W.swapDown)
  , ("M-S-k", windows W.swapUp)
  , ("M-<Up>", sendMessage (MoveUp 10))
  , ("M-<Down>", sendMessage (MoveDown 10))
  , ("M-<Right>", sendMessage (MoveRight 10))
  , ("M-<Left>", sendMessage (MoveLeft 10))
  , ("M-S-<Up>", sendMessage (IncreaseUp 10))
  , ("M-S-<Down>", sendMessage (IncreaseDown 10))
  , ("M-S-<Right>", sendMessage (IncreaseRight 10))
  , ("M-S-<Left>", sendMessage (IncreaseLeft 10))
  , ("M-C-<Up>", sendMessage (DecreaseUp 10))
  , ("M-C-<Down>", sendMessage (DecreaseDown 10))
  , ("M-C-<Right>", sendMessage (DecreaseRight 10))
  , ("M-C-<Left>", sendMessage (DecreaseLeft 10))
  ]
    -- Appending search engine prompts to keybindings list.
    ++ [("M-s " ++ k, S.promptSearch myXPConfig' f) | (k,f) <- searchList ]
    ++ [("M-S-s " ++ k, S.selectSearch f) | (k,f) <- searchList ]
    -- bspwm like feature
    ++ [("M-" ++ ws, windows $ W.greedyView ws) | ws <- myWorkspaces ]
    ++ [("M-S-" ++ ws, windows $ W.greedyView ws . W.shift ws) | ws <- myWorkspaces ]
    -- ++ [("M-S-1",     windows $ W.greedyView ws1 . W.shift ws1)
    --   , ("M-S-2",     windows $ W.greedyView ws2 . W.shift ws2)
    --   ]

myManageHook = composeAll
    [ className =? "MPlayer"          --> doFloat
    , title     =? "urxvt-float"      --> doFloat --custom window title
    , title     =? "st-float"         --> doFloat --custom window title
    , className =? "Gimp"             --> doFloat
    , className =? "Emacs"            --> viewShift "6"
    , title     =? "Oracle VM VirtualBox Manager"  --> doFloat
    , title     =? "Welcome to IntelliJ IDEA"      --> doFloat
    , className =? "jetbrains-idea"   --> doFloat
    , className =? "jetbrains-idea"   --> viewShift "5"
    , resource  =? "desktop_window"   --> doIgnore -- TODO: not sure what this does
    , className =? "feh"              --> doFloat
    , role      =? "pop-up"           --> doFloat
    , title     =? "Discord Updater" --> doFloat
    , (className =? "firefox" <&&> resource =? "Dialog") --> doFloat  -- Float Firefox Dialog
    , (className =? "Notepadqq" <&&> title =? "Search") --> doFloat
    , (className =? "Notepadqq" <&&> title =? "Advanced Search") --> doFloat
    , className =? "Xmessage" --> doFloat
    , role =? "browser" --> viewShift "4"
    ]
  where
    role = stringProperty "WM_WINDOW_ROLE"
    viewShift = doF . liftM2 (.) W.greedyView W.shift

myManageHook' = composeOne [ isFullscreen -?> doFullFloat ]

myLogHook :: D.Client -> PP
myLogHook dbus = def
    { ppOutput = dbusOutput dbus
    , ppCurrent = wrap ("%{F" ++ myFocusBorderColor ++ "} ") " %{F-}"
    , ppVisible = wrap ("%{F" ++ myFocusBorderColor ++ "} ") " %{F-}"
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

-- TODO: spawnOnce should be used?
myStartupHook :: X ()
myStartupHook = do
    setWMName "LG3D"
    spawn "$HOME/.config/polybar/launch.sh xmonad"
    spawn "flameshot"
    spawn "dunst"
    -- spawn "clipmenud"
    spawn "copyq"
    -- spawn "sonata"
    spawn "blueman-applet"
    -- spawn "mpd"
    spawn "volumeicon"
    spawn "xscreensaver -no-splash"
    spawn "feh --bg-scale $HOME/backgrounds/minnesota-vikings-dark.jpg"

-- myConfig :: XPConfig
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
  , normalBorderColor = myBorderColor
  , focusedBorderColor = myFocusBorderColor
  , workspaces = myWorkspaces
  , modMask = altKeyMask
  }
   `additionalKeysP`
   [
   ]
   `additionalKeys`
   [
   ]
