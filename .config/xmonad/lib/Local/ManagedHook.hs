module Local.ManagedHook(myManageHook, myManageHook') where

import XMonad
import XMonad.Hooks.ManageHelpers (composeOne, isFullscreen, doFullFloat, (-?>))
import XMonad.StackSet (greedyView, shift)
import Control.Monad (liftM2)
import XMonad.Util.NamedScratchpad (namedScratchpadManageHook)

import Local.Workspaces (myWorkspaces, scratchPads)

myManageHook = composeAll
    [
       className =? "confirm"         --> doFloat
     , className =? "file_progress"   --> doFloat
     , className =? "dialog"          --> doFloat
     , className =? "download"        --> doFloat
     , className =? "error"           --> doFloat
     , className =? "notification"    --> doFloat
     , className =? "splash"          --> doFloat
     , className =? "toolbar"         --> doFloat
     , className =? "Xmessage"        --> doFloat
     , role      =? "pop-up"          --> doFloat
     , resource  =? "desktop_window"  --> doIgnore -- TODO: not sure what this does

    , className =? "Gimp"             --> doFloat
    -- , className =? "Emacs"            --> viewShift ( myWorkspaces !! 6 )
    , className =? "dzen2"            --> doIgnore
    -- , className =? "discord"          --> viewShift ( myWorkspaces !! 8 )
    , title     =? "Oracle VM VirtualBox Manager"  --> doFloat
    , title     =? "Welcome to IntelliJ IDEA"      --> doFloat
    , title     =? "Welcome to IntelliJ IDEA"      --> viewShift ( myWorkspaces !! 4 )
    , className =? "qemu-system-x86_64"            --> doFloat
    , className =? "Audacity"                      --> doFloat
    , className =? "KeePassXC"                     --> doFloat
    , className =? "keepassxc"                     --> doFloat -- mint linux
    , className =? "Sotify"                        --> doFloat
    , className =? "vlc"                           --> doFloat
    , className =? "streamdeck UI"                 --> doFloat
    , className =? "jetbrains-idea"                --> doFloat
    , className =? "jetbrains-idea-ce"             --> doFloat
    , className =? "Slack"                         --> viewShift ( myWorkspaces !! 7 )
    , className =? "jetbrains-idea"                --> viewShift ( myWorkspaces !! 4 )
    , className =? "jetbrains-idea-ce"             --> viewShift ( myWorkspaces !! 4 )
    -- , className =? "Streamdeck UI"                 --> viewShift ( myWorkspaces !! 9 )
    , className =? "feh"                           --> doFloat
    , className =? "Sxiv"                          --> doFloat
    , title     =? "Discord Updater"               --> doFloat
    , (className =? "firefox" <&&> resource =? "Dialog") --> doFloat  -- Float Firefox Dialog
    , (className =? "Notepadqq" <&&> title =? "Search") --> doFloat
    , (className =? "Notepadqq" <&&> title =? "Advanced Search") --> doFloat
    , role =? "browser"                            --> viewShift ( myWorkspaces !! 3 )
    ]  <+> namedScratchpadManageHook scratchPads
  where
    role = stringProperty "WM_WINDOW_ROLE"
    viewShift = doF . liftM2 (.) greedyView shift
    -- myShift = doF . liftM2 (.) W.greedyView

myManageHook' = composeOne [ isFullscreen -?> doFullFloat ]
