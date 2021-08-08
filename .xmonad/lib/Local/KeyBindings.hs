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
import XMonad.Actions.CycleWS (nextWS, prevWS, toggleWS)
import XMonad.Layout.ZoomRow (zoomIn, zoomOut, zoomReset)
import XMonad.Layout.WindowArranger -- for DecreaseRight, IncreaseUp
import Graphics.X11.ExtraTypes -- for xF86XK_Paste
import XMonad.Util.Paste (sendKey) -- for sendKey
import XMonad.Util.Run
import XMonad.Prompt.Input
import XMonad.Actions.Submap
import XMonad.Actions.UpdateFocus
import XMonad.Layout.Minimize
import XMonad.Prompt
import XMonad.Actions.DynamicWorkspaces
import XMonad.Prompt.Window (WindowPrompt (..), allWindows, windowMultiPrompt, wsWindows)
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig (mkKeymap, mkNamedKeymap)
import qualified XMonad.Util.ExtensibleState as XState
import XMonad.Util.NamedScratchpad (namedScratchpadAction)
import qualified XMonad.Actions.Search as S
import qualified XMonad.Util.NamedActions as NamedActions
import qualified XMonad.Util.Run as Run
import qualified System.IO as IO
import Control.Monad
import Data.Monoid

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

myEmacs = "emacsclient -c -a 'emacs' "

lockScreen :: X ()
lockScreen = spawn "xscreensaver-command -lock"

-- viewShift :: WorkspaceId -> Query (Endo (StackSet WorkspaceId l Window ScreenId sd))
-- viewShift = doF . liftM2 (.) W.greedyView W.shift

-- viewShift = doF . liftM2 (.) W.greedyView W.shift
viewShift :: WorkspaceId -> Query (Endo (W.StackSet WorkspaceId l Window ScreenId sd))
viewShift = doF . liftM2 (.) W.greedyView W.shift

emacs :: X ()
emacs = do
  name <- gets (W.tag . W.workspace . W.current . windowset)
  spawn ("e -cs " ++ name)

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

spawnToWorkspace :: String -> String -> X ()
spawnToWorkspace program workspace = do
              spawn program
              windows $ W.greedyView workspace . W.shift workspace

-- submapName :: (HasName a) => [((KeyMask, KeySym), a)] -> NamedAction
-- submapName = NamedAction . (submap . M.map getAction . M.fromList &&& showKm)
--                 . map (second NamedAction)

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

showKeyBindings :: [((XMonad.KeyMask, XMonad.KeySym), NamedActions.NamedAction)] -> NamedActions.NamedAction
showKeyBindings x =
  NamedActions.addName "Show Keybindings" $
  XMonad.io $ do
    h <- Run.spawnPipe "yad --text-info"
    Run.hPutStr h (unlines $ NamedActions.showKm x)
    IO.hClose h
    return ()

-- keyMaps :: [(String, X ())]
-- keyMaps =
--         musicKeys

myRemoveKeys :: [(KeyMask, KeySym)]
myRemoveKeys = [
                   (superKeyMask .|. shiftMask, xK_space)
                 , (superKeyMask, xK_q)
                 , (superKeyMask, xK_e)
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

keybinds :: XConfig Layout -> [((KeyMask, KeySym), NamedActions.NamedAction)]
keybinds conf = let
  subKeys str ks = NamedActions.subtitle str : mkNamedKeymap conf ks
  wsKeys  = map show ([1..9] ++ [0] :: [Int])
  zipM  m nm ks as f = zipWith (\k d -> (m ++ k, NamedActions.addName nm $ f d)) ks as
  zipM' m nm ks as f b = zipWith(\k d -> (m ++ k, NamedActions.addName nm $ f d b)) ks as
  in
    subKeys "System"
    [
    ("M-M1-l", NamedActions.addName "Lock screen" lockScreen)
  , ("M-S-<Escape>", NamedActions.addName "Quit Xmonad" $ spawn "wm-exit xmonad")
  , ("M-S-<Backspace>", NamedActions.addName "Terminate Process" kill1)
  -- , ("M-S-<Backspace>", addName "Kill all" $ confirmPrompt hotPromptTheme "kill all" killAll)
  , ("M-<Escape>", NamedActions.addName "Restart Xmonad" $ spawn "xmonad --recompile && xmonad --restart")
  , ("M-v", NamedActions.addName "Paste" $ sendKey noModMask xF86XK_Paste)
    ] ++
    subKeys "Launchers"
    [
    ("M-S-<Return>", NamedActions.addName "Alternate Terminal"      $ spawn "st")
  , ("M-<Return>", NamedActions.addName "Terminal"        $ spawn "terminal")
  , ("M-S-p", NamedActions.addName "Application Launcher"             $ spawn "dmenu_run -i -nb '#9370DB' -nf '#50fa7b' -sb '#EE82EE' -sf black -fn 'monofur for Powerline'")
  , ("M-<F2>", NamedActions.addName "File Manager" $ spawn "fm")
  , ("M-i", NamedActions.addName "Browser" $ spawn "browser")
  , ("M-S-i", NamedActions.addName "Private Browser" $ spawn ("browser" ++ " --incognito"))
  , ("M-p", NamedActions.addName "Passowrd Manager" $ spawn passmenuRunCmd)
  -- , ("M-<Print>"         , spawn "flameshot gui -p $HOME/screenshots")
  , ("M-<F4>", NamedActions.addName "Screenshot" $ spawn "flameshot gui -p $HOME/screenshots")
  , ("M-b", NamedActions.addName "Red tint" $ spawn "redshift -O 3500")
  , ("M-S-b", NamedActions.addName "Red tint undo" $ spawn "redshift -x")

  , ("M-S-r", NamedActions.addName "Toggle struts" $ sendMessage ToggleStruts)
  , ("M-\\", NamedActions.addName "Minnimize Window" $ withFocused minimizeWindow)
  , ("M-S-\\", NamedActions.addName "Maximize Window" $ withLastMinimized maximizeWindow)
    ] ++
    subKeys "Workspaces"
    ([
          ("M-;", NamedActions.addName "View previous workspace"      viewPrevWS)
        , ("M-<Tab>", NamedActions.addName "toggle betweeen workspaces"  toggleWS)
    ]
    ++ zipM "M-" "Move to workspace" wsKeys [0..] (withNthWorkspace W.greedyView)
    -- ++ zipM "M-S-" "Move window to workspace" wsKeys [0..]  (withNthWorkspace (\i -> W.greedyView i . W.shift i))
    ++ zipM "M-S-" "Move and shift window to workspace" wsKeys [0..]  (withNthWorkspace (liftM2 (.) W.greedyView W.shift))
    ++ zipM "M-C-" "Copy window to workkspace" wsKeys [0..] (withNthWorkspace copy)
    ++ zipM "M1-C-" "Shift window to workkspace" wsKeys [0..] (withNthWorkspace W.shift)
    )

    ++
    subKeys "Audio"
    [
    ("<XF86AudioLowerVolume>", NamedActions.addName "Lower Volume" $ spawn "amixer set Master 5%- unmute")
  , ("<XF86AudioRaiseVolume>", NamedActions.addName "Raise Volume" $ spawn "amixer set Master 5%+ unmute")
  , ("<XF86AudioMute>", NamedActions.addName "Toggle Mute" $ spawn "amixer set Master toggle")
  , ("<XF86AudioPlay>", NamedActions.addName "Toggle Play" $ spawn "mpc toggle")
  , ("<XF86AudioPrev>", NamedActions.addName "Previous" $ spawn "mpc prev")
  , ("<XF86AudioNext>", NamedActions.addName "Next" $ spawn "mpc next")
    ]

   ++
   subKeys "Scratchpads"
   [
   ("M-S-o", NamedActions.addName "submap" $ submap . M.fromList $
            [
              ((0, xK_s),    namedScratchpadAction scratchPads "spotify-nsp")
            , ((0, xK_d),    namedScratchpadAction scratchPads "discord-nsp")
            , ((0, xK_t),    namedScratchpadAction scratchPads "tmux-nsp")
            , ((0, xK_k),    namedScratchpadAction scratchPads "keepas-nsp")
            , ((0, xK_v),    namedScratchpadAction scratchPads "vlc-nsp")
            , ((0, xK_c),    namedScratchpadAction scratchPads "calc-nsp")
            , ((0, xK_i),    spawn "intellij")
            , ((0, xK_d),    spawn "dbeaver-flatpak")
            , ((0, xK_g),    spawn "steam")
            , ((0, xK_e),    spawn "vscodium-flatpak")
            , ((0, xK_h),    spawn "handbrake")
            ])
   ]
   ++
   subKeys "Windows"
   [
    ("M-m", NamedActions.addName "Focus on master" $ windows W.focusMaster)
  , ("M-S-m", NamedActions.addName "Swap master" $ windows W.swapMaster)
  , ("M-S-j", NamedActions.addName "Swap down" $ windows W.swapDown)
  , ("M-S-k", NamedActions.addName "Swap up" $ windows W.swapUp)
  , ("M-j", NamedActions.addName "" $ windowGo D False)
  , ("M-k", NamedActions.addName "" $ windowGo U False)
  , ("M-l", NamedActions.addName "" $ windowGo R False)
  , ("M-h", NamedActions.addName "" $ windowGo L False)
  , ("M-<Up>", NamedActions.addName "" $ sendMessage (MoveUp 10))
  , ("M-<Down>", NamedActions.addName "" $ sendMessage (MoveDown 10))
  , ("M-<Right>", NamedActions.addName "" $ sendMessage (MoveRight 10))
  , ("M-<Left>", NamedActions.addName "" $ sendMessage (MoveLeft 10))
  , ("M-S-<Up>", NamedActions.addName "" $ sendMessage (IncreaseUp 10))
  , ("M-S-<Down>", NamedActions.addName "" $ sendMessage (IncreaseDown 10))
  , ("M-S-<Right>", NamedActions.addName "" $ sendMessage (IncreaseRight 10))
  , ("M-S-<Left>", NamedActions.addName "" $ sendMessage (IncreaseLeft 10))
  , ("M-C-<Up>", NamedActions.addName "" $ sendMessage (DecreaseUp 10))
  , ("M-C-<Down>", NamedActions.addName "" $ sendMessage (DecreaseDown 10))
  , ("M-C-<Right>", NamedActions.addName "" $ sendMessage (DecreaseRight 10))
  , ("M-C-<Left>", NamedActions.addName "" $ sendMessage (DecreaseLeft 10))
  , ("M-S-h", NamedActions.addName "" $ sendMessage Shrink)
  , ("M-S-l", NamedActions.addName "" $ sendMessage Expand)
   ]
