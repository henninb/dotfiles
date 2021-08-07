-- module XMonad.Local.KeyBindings (keys, rawKeys) where
module Local.KeyBindings (keyMaps, myRemoveKeys, superKeyMask, showKeyBindings, keybinds) where

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
import XMonad.Prompt.Window (WindowPrompt (..), allWindows, windowMultiPrompt, wsWindows)
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig (mkKeymap, mkNamedKeymap)
import qualified XMonad.Util.ExtensibleState as XState
import XMonad.Util.NamedScratchpad (namedScratchpadAction)
import qualified XMonad.Actions.Search as S
import qualified XMonad.Util.NamedActions as NamedActions
import qualified XMonad.Util.Run as Run
import qualified System.IO as IO

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

showKeyBindings :: [((XMonad.KeyMask, XMonad.KeySym), NamedActions.NamedAction)] -> NamedActions.NamedAction
showKeyBindings x =
  NamedActions.addName "Show Keybindings" $
  XMonad.io $ do
    h <- Run.spawnPipe "yad --text-info"
    Run.hPutStr h (unlines $ NamedActions.showKm x)
    IO.hClose h
    return ()

keyMaps :: [(String, X ())]
keyMaps =
        baseKeys ++
        windowKeys ++
        workspaceKeys ++
        screenKeys ++
        applicationKeybindings ++
        musicKeys

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

baseKeys :: [(String, X ())]
baseKeys =
  [
  ]

-- | Window focusing, swapping, and other actions.
windowKeys :: [(String, X ())]
windowKeys =
  [
    ("M-m", windows W.focusMaster)
  , ("M-S-m", windows W.swapMaster)
  , ("M-S-j", windows W.swapDown)
  , ("M-S-k", windows W.swapUp)
  , ("M-j", windowGo D False)
  , ("M-k", windowGo U False)
  , ("M-l", windowGo R False)
  , ("M-h", windowGo L False)
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
  , ("M-S-h", sendMessage Shrink)
  , ("M-S-l", sendMessage Expand)
  ]

workspaceKeys :: [(String, X ())]
workspaceKeys =
      [
          ("M-;"     , viewPrevWS)
        , ("M-<Tab>" , toggleWS)
        -- , ("M-?"     , helpCommand)
      ]
        -- change active workspace
      ++ [("M-" ++ workSpace, windows $ W.greedyView workSpace) | workSpace <- myWorkspaces ]
      -- move window and change active workspace
      ++ [("M-S-" ++ workSpace, windows $ W.greedyView workSpace . W.shift workSpace) | workSpace <- myWorkspaces ]
      -- move window
      ++ [("M1-S-" ++ workSpace, windows $ W.shift workSpace) | workSpace <- myWorkspaces ]
      --  copy window
      ++ [("M-C-" ++ workSpace, windows $ copy workSpace) | workSpace <- myWorkspaces ]
         -- where
         --  helpCommand :: X ()
         --  helpCommand = spawn ("echo " ++ show help ++ " | xmessage -file -")

screenKeys :: [(String, X ())]
screenKeys =
  [
  ]

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


applicationKeybindings :: [(String, X ())]
applicationKeybindings =
  [
    ("M-S-<Return>"      , spawn "st")
  , ("M-<Return>"        , spawn "terminal")
  , ("M-S-p"             , spawn "dmenu_run -i -nb '#9370DB' -nf '#50fa7b' -sb '#EE82EE' -sf black -fn 'monofur for Powerline'")
  , ("M-<F2>"             , spawn "fm") --filemanager ~/.local/bin/fm
  , ("M-i"               , spawn "browser")
  , ("M-S-i"             , spawn ("browser" ++ " --incognito"))
  , ("M-p"               , spawn passmenuRunCmd)
  , ("M-<Print>"         , spawn "flameshot gui -p $HOME/screenshots")
  , ("M-<F4>"            , spawn "flameshot gui -p $HOME/screenshots")
  , ("M-b"               , spawn "redshift -O 3500")
  , ("M-S-b"             , spawn "redshift -x")
  , ("M-M1-l"            , lockScreen)
  , ("M-S-<Escape>"      , spawn "wm-exit xmonad")
  , ("M-S-<Backspace>"   , kill1) -- Kill the current window.
  , ("M-<Escape>"        , spawn "xmonad --recompile && xmonad --restart")

  , ("M-v"               , sendKey noModMask xF86XK_Paste)
  , ("M-S-r"            , sendMessage ToggleStruts)
  , ("M-\\"              , withFocused minimizeWindow)
  , ("M-S-\\"            , withLastMinimized maximizeWindow)

-- scratchpads
  , ("M-S-o",  submap . M.fromList $
            [ ((0, xK_s),    namedScratchpadAction scratchPads "spotify-nsp")
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

      -- Appending search engine prompts to keybindings list.
    ++ [("M-s " ++ k, S.promptSearch myXPConfig' f) | (k,f) <- searchList ]
    ++ [("M-S-s " ++ k, S.selectSearch f) | (k,f) <- searchList ]

musicKeys :: [(String, X ())]
musicKeys =
  [
    ("<XF86AudioLowerVolume>", spawn "amixer set Master 5%- unmute")
  , ("<XF86AudioRaiseVolume>", spawn "amixer set Master 5%+ unmute")
  , ("<XF86AudioMute>", spawn "amixer set Master toggle")
  , ("<XF86AudioPlay>", spawn "mpc toggle")
  , ("<XF86AudioPrev>", spawn "mpc prev")
  , ("<XF86AudioNext>", spawn "mpc next")
  ]

keybinds :: XConfig Layout -> [((KeyMask, KeySym), NamedActions.NamedAction)]
keybinds conf = let
  subKeys str ks = NamedActions.subtitle str : mkNamedKeymap conf ks
  in
    subKeys "System"
    [
      -- (        "M-q"                  , addName "Restart XMonad"                            $ spawn "\"$HOME/.xmonad/rebuild.sh\" && xmonad --restart")
    -- , (        "M-S-q"                , addName "Quit XMonad"                               $ confirmPrompt P.dangerPrompt "Quit XMonad?" $ io (exitWith ExitSuccess))
    -- , (        "M-x"                  , addName "Lock screen"                               $ spawn C.lock)
    -- , (        "M-S-x"                , addName "Switch autolock"                           $ spawn C.autolockToggle)
    ]
