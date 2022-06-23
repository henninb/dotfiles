-- module XMonad.Local.KeyBindings (keys, rawKeys) where
module Local.KeyBindings (myRemoveKeys, superKeyMask, showKeyBindings, keybinds, searchPromptKeybindings) where

import qualified Data.Map as M
import Graphics.X11.Xlib
import XMonad hiding (keys)
import XMonad.Actions.CopyWindow (kill1, copy)
import XMonad.Actions.DynamicProjects (switchProjectPrompt, switchProject)
import XMonad.Actions.GroupNavigation (Direction (..), nextMatch)
import XMonad.Actions.Minimize
import XMonad.Actions.Navigation2D
import XMonad.Actions.PhysicalScreens (onNextNeighbour, onPrevNeighbour)
import XMonad.Actions.Promote (promote)
import XMonad.Actions.RotSlaves (rotSlavesDown, rotSlavesUp)
import XMonad.Actions.SwapPromote (swapHybrid)
import XMonad.Actions.TagWindows (addTag, delTag, withTagged)
import XMonad.Hooks.ManageDocks (ToggleStruts (..))
import XMonad.Hooks.UrgencyHook (focusUrgent)
import XMonad.Layout.LayoutBuilder (IncLayoutN (..))
import XMonad.Layout.Maximize (maximizeRestore)
import XMonad.Layout.ResizableTile
import XMonad.Layout.Spacing
import XMonad.Actions.CycleWS (nextWS, prevWS, toggleWS, moveTo, shiftTo )
import XMonad.Layout.ZoomRow (zoomIn, zoomOut, zoomReset)
import XMonad.Layout.WindowArranger -- for DecreaseRight, IncreaseUp
import Graphics.X11.ExtraTypes (xF86XK_Paste)
import XMonad.Util.Paste (sendKey)
-- import XMonad.Util.Run
-- import XMonad.Prompt.Input
-- import XMonad.Actions.Submap
-- import XMonad.Actions.UpdateFocus
-- import XMonad.Layout.Minimize
import XMonad.Prompt (XPrompt (..))
import XMonad.Actions.DynamicWorkspaces (withNthWorkspace)
import XMonad.Prompt.Window (WindowPrompt (..), allWindows, windowMultiPrompt, wsWindows)
import XMonad.StackSet (greedyView, shift, tag, workspace, current, focusMaster, sink, swapUp, swapDown, swapMaster)
import XMonad.Util.EZConfig (mkKeymap, mkNamedKeymap)
import qualified XMonad.Util.ExtensibleState as XState (put, get)
-- import XMonad.Util.ExtensibleState (put, get)
import XMonad.Util.NamedScratchpad (namedScratchpadAction)
import qualified XMonad.Actions.Search as S
import XMonad.Util.NamedActions (addName, subtitle, showKm, submapName)
import XMonad.Util.Run (hPutStr, spawnPipe, safeSpawn, unsafeSpawn)
import System.IO (hClose)
import Control.Monad (liftM2, join)
import XMonad.Actions.CycleSelectedLayouts (cycleThroughLayouts)
import XMonad.Util.XSelection (getSelection)
import XMonad.Layout.BoringWindows (focusDown, focusUp)

import Local.Prompts
import Local.Workspaces

superKeyMask :: KeyMask
superKeyMask = mod4Mask

altKeyMask :: KeyMask
altKeyMask = mod1Mask

passmenuRunCmd :: String
-- passmenuRunCmd = scriptsPath ++ "passmenu " ++ (unwords $ dmenuArgs "Password:")
passmenuRunCmd = "passmenu " ++ unwords (dmenuArgs "Password:")

dmenuRunCmd :: String
-- passmenuRunCmd = scriptsPath ++ "passmenu " ++ (unwords $ dmenuArgs "Password:")
dmenuRunCmd = "dmenu " ++ unwords (dmenuArgs "Execute:")

myEmacs = "emacsclient -c -a 'emacs'"

lockScreen :: X ()
lockScreen = safeSpawn "xscreensaver-command" ["-lock"]

-- viewShift :: WorkspaceId -> Query (Endo (StackSet WorkspaceId l Window ScreenId sd))
-- viewShift = doF . liftM2 (.) greedyView shift

emacs :: X ()
emacs = do
  name <- gets (tag . workspace . current . windowset)
  safeSpawn ("e -cs " ++ name) []

data MessageMenu = MessageMenu

instance XPrompt MessageMenu where
  showXPrompt MessageMenu = "XMonad Action: "

-- | Remember certain actions taken so they can be repeated.
newtype LastXMessage = LastXMessage
  {getLastMessage :: X ()}

instance ExtensionClass LastXMessage where
  initialValue = LastXMessage (return ())

-- | Record the given message as the last used message, then execute it.
recordXMessage :: X () -> X ()
recordXMessage message = do
  XState.put (LastXMessage message)
  message

-- | Execute the last recorded message.
repeatLastXMessage :: X ()
repeatLastXMessage = getLastMessage =<< XState.get

unsafeWithSelection app = join $ io $ fmap (unsafeSpawn . (\ x -> app ++ " " ++ x)) getSelection

dmenuArgs :: String -> [String]
dmenuArgs title = [ "-i "
                  , "-nb", quote "#9370DB"
                  , "-nf", quote "#50fa7b"
                  , "-sb", quote "#EE82EE"
                  , "-sf", quote "black"
                  , "-fn", quote "monofur for Powerline"
                  , "-p",  quote title
                  ]
  where quote s = "'" ++ s ++ "'"

-- showKeyBindings :: [((XMonad.KeyMask, XMonad.KeySym), NamedAction)] -> NamedAction
showKeyBindings x =
  addName "Show Keybindings" $
  XMonad.io $ do
    h <- spawnPipe "yad --text-info"
    hPutStr h (unlines $ showKm x)
    hClose h
    return ()

myRemoveKeys :: [(KeyMask, KeySym)]
myRemoveKeys = [
                   (superKeyMask .|. shiftMask, xK_space)
                 , (superKeyMask, xK_q)
                 , (superKeyMask, xK_e)
                 , (superKeyMask, xK_n)
                 , (superKeyMask, xK_p)
                 , (superKeyMask, xK_x)
                 , (controlMask, xK_p)
                 , (controlMask, xK_n)
                 -- , (superKeyMask .|. shiftMask, xK_s)
                 , (superKeyMask .|. shiftMask, xK_q)
                 , (superKeyMask .|. shiftMask, xK_c)
                 -- , (superKeyMask, xK_space)
                 ]

      -- Appending search engine prompts to keybindings list.
searchPromptKeybindings :: [(String, X ())]
searchPromptKeybindings =
    [("M-s " ++ k, S.promptSearch myXPConfig' f) | (k,f) <- searchList ]
    ++ [("M-S-s " ++ k, S.selectSearch f) | (k,f) <- searchList ]

-- keybinds :: XConfig Layout -> [((KeyMask, KeySym), NamedAction)]
keybinds conf =
  let
    subKeys str ks = subtitle str : mkNamedKeymap conf ks
    wsKeys  = map show ([1..9] ++ [0] :: [Int])
    zipM  m nm ks as f = zipWith (\k d -> (m ++ k, addName nm $ f d)) ks as
    zipM' m nm ks as f b = zipWith(\k d -> (m ++ k, addName nm $ f d b)) ks as
  in
    subKeys "System"
    [
    ("M-M1-l", addName "Lock screen" lockScreen)
  , ("M-S-<Escape>", addName "Quit Xmonad" $ safeSpawn "wm-exit" ["xmonad"])
  , ("M-S-<Backspace>", addName "Terminate Process" kill1)
  -- , ("M-S-<Backspace>", addName "Kill all" $ confirmPrompt hotPromptTheme "kill all" killAll)
  -- , ("M-<Escape>", addName "Restart Xmonad" $ safeSpawn "xmonad --recompile && xmonad --restart" [] >> safeSpawn "notify-send 'recompile and restart xmonad'" [])
  , ("M-<Escape>", addName "Restart Xmonad" $ safeSpawn "xmonad-restart" [] >> safeSpawn "notify-send" ["recompile and restart xmonad"])
  , ("M-v", addName "Paste" $ sendKey noModMask xF86XK_Paste)
  , ("M-<Space>", addName "Switch Layout" $ sendMessage NextLayout)
  , ("M-S-<Space>", addName "Switch Layout Reverse" $ cycleThroughLayouts ["Full", "Panel", "Spiral", "Reading", "Media", "Terminal", "Common", "Mag", "3ColumnMid", "3Column", "Grid","Main"])
  , ("M-S-r", addName "Toggle struts" $ sendMessage ToggleStruts >> safeSpawn "notify-send" ["toggle struts"])
  , ("M-\\", addName "Minnimize Window" $ withFocused minimizeWindow)
  , ("M-S-\\", addName "Maximize Window" $ withLastMinimized maximizeWindow)
    ] ++

    subKeys "Launchers"
    [
    ("M-S-<Return>", addName "Alternate Terminal"      $ safeSpawn "st" [] >> safeSpawn "notify-send" ["st terminal"])
  , ("M-<Return>", addName "Terminal"        $ safeSpawn "terminal" [] >> safeSpawn "notify-send" ["terminal"])
  , ("M-S-p", addName "Application Launcher" $ safeSpawn "dmenu_run" ["-i", "-nb", "#9370DB", "-nf", "#50fa7b", "-sb", "#EE82EE", "-sf", "black", "-fn", "monofur for Powerline", "-p", "Command:"])
  , ("M-<F2>", addName "File Manager" $ safeSpawn "fm" [] >> safeSpawn "notify-send 'fm file manager'" [])
  , ("M-i", addName "Browser" $ safeSpawn "browser" [])
  , ("M-e", addName "Emacs" $ safeSpawn myEmacs [])
  , ("M-S-i", addName "Private Browser" $ safeSpawn "browser" ["--incognito"])
  -- , ("M-p", addName "Passowrd Manager" $ spawn passmenuRunCmd)
  , ("M-p", addName "Password Launcher" $ safeSpawn "passmenu" ["-i", "-nb", "#9370DB", "-nf", "#50fa7b", "-sb", "#EE82EE", "-sf", "black", "-fn", "monofur for Powerline", "-p", "Password:"])
  -- , ("M-<Print>"         , safeSpawn "flameshot gui -p $HOME/screenshots" [])
  , ("M-<F4>", addName "Screenshot" $ safeSpawn "flameshot-wrapper" [] >> safeSpawn "notify-send" ["flameshot"])
  , ("M-b", addName "redshift on" $ safeSpawn "redshift" ["-O", "3500"] >> safeSpawn "notify-send" ["redshift on"])
  , ("M-S-b", addName "redshift off" $ safeSpawn "redshift" ["-x"] >> safeSpawn "notify-send" ["redshift off"])
  , ("M-S-w", addName "Weather Minneapolis" $ safeSpawn "weather-gtk" [])
  -- , ("M-a", addName "Notify w current X selection"    $ unsafeWithSelection "notify-send")
    ]

    ++

    subKeys "Workspaces"
    ([
          ("M-;", addName "View previous workspace" viewPrevWS)
        , ("M-<Tab>", addName "toggle betweeen workspaces" toggleWS)
    ]
    ++ zipM "M-" "Move window to workspace" wsKeys [0..]  (\wn -> withNthWorkspace greedyView wn >> safeSpawn "notify-send" ["workspace: " ++ show(wn + 1)])
    ++ zipM "M-S-" "Move and shift window to workspace" wsKeys [0..]  (withNthWorkspace (liftM2 (.) greedyView shift))
    ++ zipM "M-C-" "Copy window to workkspace" wsKeys [0..] (withNthWorkspace copy)
    ++ zipM "M1-C-" "Shift window to workkspace" wsKeys [0..] (withNthWorkspace shift)
    )

    ++

    subKeys "Audio"
    [
    ("<XF86AudioLowerVolume>", addName "Lower Volume" $ safeSpawn "amixer" ["set", "Master", "5%-", "unmute"])
  , ("<XF86AudioRaiseVolume>", addName "Raise Volume" $ safeSpawn "amixer" ["set", "Master", "5%+", "unmute"])
  , ("<XF86AudioMute>", addName "Toggle Mute" $ safeSpawn "amixer" ["set", "Master", "toggle"])
  , ("<XF86AudioPlay>", addName "Toggle Play" $ safeSpawn "mpc" ["toggle"])
  , ("<XF86AudioPrev>", addName "Previous" $ safeSpawn "mpc" ["prev"])
  , ("<XF86AudioNext>", addName "Next" $ safeSpawn "mpc" ["next"])
    ]

   ++

   subKeys "Windows"
   [
   --focus
    ("M-m", addName "Focus on master window" $ windows focusMaster)
  , ("M-j",   addName "Focus next window" focusDown)
  , ("M-k",   addName "Focus previous window" focusUp)
  , ("M-S-m", addName "Swap master" $ windows swapMaster)
  , ("M-S-j", addName "Swap focused with next" $ windows swapDown)
  , ("M-S-k", addName "Swap focused with previous" $ windows swapUp)
  , ("M-,",   addName "Increase master windows" $ sendMessage (IncMasterN 1))
  , ("M-.",   addName "Decrease master windows" $ sendMessage (IncMasterN (-1)))
  -- , ("M-j", addName "Window Down" $ windowGo D False)
  -- , ("M-k", addName "Window Up" $ windowGo U False)
  , ("M-l", addName "Window Right" $ windowGo R False)
  , ("M-h", addName "Window Left" $ windowGo L False)
  , ("M-<Up>", addName "" $ sendMessage (MoveUp 10))
  , ("M-<Down>", addName "" $ sendMessage (MoveDown 10))
  , ("M-<Right>", addName "" $ sendMessage (MoveRight 10))
  , ("M-<Left>", addName "" $ sendMessage (MoveLeft 10))
  , ("M-S-<Up>", addName "" $ sendMessage (IncreaseUp 10))
  , ("M-S-<Down>", addName "" $ sendMessage (IncreaseDown 10))
  , ("M-S-<Right>", addName "" $ sendMessage (IncreaseRight 10))
  , ("M-S-<Left>", addName "" $ sendMessage (IncreaseLeft 10))
  , ("M-C-<Up>", addName "" $ sendMessage (DecreaseUp 10))
  , ("M-C-<Down>", addName "" $ sendMessage (DecreaseDown 10))
  , ("M-C-<Right>", addName "" $ sendMessage (DecreaseRight 10))
  , ("M-C-<Left>", addName "" $ sendMessage (DecreaseLeft 10))
  , ("M-S-h", addName "resize left" $ sendMessage Shrink)
  , ("M-S-l", addName "resize right" $ sendMessage Expand)
  -- , ("M-t", withFocused $ windows . sink)
  , ("M-t", addName "" $ withFocused $ windows . sink)
  -- ,("M-c",   addName "Select first empty workspace" $ moveTo Next EmptyWS)
  -- ,("M-S-c", addName "Move window to next empty workspace" $ shiftTo Next EmptyWS)
   ]
   ++
   subKeys "Scratchpads/misc"
   [
   ("M-S-o", submapName $ mkNamedKeymap conf
    [("s", addName "spotify" $ namedScratchpadAction scratchPads "spotify-nsp")
    ,("d", addName "discord" $ namedScratchpadAction scratchPads "discord-nsp")
    ,("t", addName "tmux" $ namedScratchpadAction scratchPads "tmux-nsp")
    ,("k", addName "keepass" $ namedScratchpadAction scratchPads "keepass-nsp")
    ,("v", addName "vlc" $ namedScratchpadAction scratchPads "vlc-nsp")
    ,("c", addName "calc" $ namedScratchpadAction scratchPads "calc-nsp")
    ,("i", addName "intellij" $ safeSpawn "intellij" [])
    ,("d", addName "dbeaver" $ safeSpawn "dbeaver-flatpak" [])
    ,("g", addName "steam" $ safeSpawn "steam" [])
    ,("e", addName "vscodium" $ safeSpawn "vscodium-flatpak" [])
    ,("h", addName "handbrake" $ safeSpawn "handbrake" [])
    ])
    -- ,("C-M1-l", submapName $ mkNamedKeymap conf
    --  [("l", addName "Lock session" $ spawn "loginctl lock-session")
    --  ,("h", addName "Hibernate" $ spawn "systemctl hibernate")
    --  ,("s", addName "Suspend" $ spawn "systemctl suspend")
    --  ])
   ]

notifyWSHint :: String -> X()
notifyWSHint index = spawn $ "notify-send -t 500 \"workspace: " ++ index ++ "\""

workspaceHint f i = do
  windows $ f i
  notifyWSHint i
