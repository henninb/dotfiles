module Local.ManagedHook(myManageHook, myManageHook') where

import XMonad
import XMonad.Hooks.ManageHelpers
import qualified XMonad.StackSet as W
import Control.Monad (liftM2)
import XMonad.Util.NamedScratchpad (namedScratchpadManageHook)

import Local.Workspaces

myManageHook = composeAll
    [ className =? "MPlayer"          --> doFloat
    , title     =? "urxvt-float"      --> doFloat --custom window title
    , title     =? "st-float"         --> doFloat --custom window title
    , className =? "Gimp"             --> doFloat
    , className =? "Emacs"            --> viewShift ( myWorkspaces !! 6 )
    , className =? "dzen2"            --> doIgnore
    -- , className =? "discord"          --> viewShift ( myWorkspaces !! 8 )
    , title     =? "Oracle VM VirtualBox Manager"  --> doFloat
    , title     =? "Welcome to IntelliJ IDEA"      --> doFloat
    , title     =? "Welcome to IntelliJ IDEA"      --> viewShift ( myWorkspaces !! 4 )
    , className =? "qemu-system-x86_64"            --> doFloat
    , className =? "Audacity"                      --> doFloat
    , className =? "KeePassXC"                     --> doFloat
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
