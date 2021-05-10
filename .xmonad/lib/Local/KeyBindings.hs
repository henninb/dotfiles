-- module XMonad.Local.KeyBindings (keys, rawKeys) where
module Local.KeyBindings (keyMaps) where

import qualified Data.Map as M
import Graphics.X11.Xlib
-- import System.Directory
-- import System.FilePath ((</>))
import XMonad hiding (keys)
import XMonad.Actions.CopyWindow (kill1)
import XMonad.Actions.DynamicProjects (switchProjectPrompt)
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
import XMonad.Layout.ZoomRow (zoomIn, zoomOut, zoomReset)
import XMonad.Layout.WindowArranger -- for DecreaseRight, IncreaseUp
import Graphics.X11.ExtraTypes -- for xF86XK_Paste
import XMonad.Util.Paste (sendKey) -- for sendKey
-- import XMonad.Local.Layout (selectLayoutByName, toggleLayout)
-- import XMonad.Local.Layout.Columns (IncMasterCol (..))
-- import XMonad.Local.Music (radioPrompt)
-- import qualified XMonad.Local.Prompt as Local
-- import XMonad.Local.Tagging
-- import XMonad.Local.Workspaces (asKey, scratchPads, viewPrevWS)
import XMonad.Prompt
import XMonad.Prompt.Window (WindowPrompt (..), allWindows, windowMultiPrompt, wsWindows)
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig (mkKeymap)
import qualified XMonad.Util.ExtensibleState as XState
import XMonad.Util.NamedScratchpad (namedScratchpadAction)

import Local.Workspaces

-- | Join all the key maps into a single list and send it through @mkKeymap@.
-- keys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
-- keys c = mkKeymap c (rawKeys c)

-- -- | Access the unprocessed key meant to be fed into @mkKeymap@.
-- rawKeys :: XConfig Layout -> [(String, X ())]
-- rawKeys c = concatMap ($ c) keymaps
--   where
--     keymaps =
--       [
--         baseKeys,
--         windowKeys,
--         -- windowTagKeys,
--         workspaceKeys,
--         -- layoutKeys,
--         screenKeys,
--         applicationKeybindings,
--         musicKeys
--       ]

superKeyMask :: KeyMask
superKeyMask = mod4Mask

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
                 , (superKeyMask .|. shiftMask, xK_q)
                 , (superKeyMask .|. shiftMask, xK_c)
                 -- , (superKeyMask, xK_space)
                 ]

baseKeys :: [(String, X ())]
baseKeys =
  [
    -- ("M-x r", restartIntoDebugging),
    -- ("M-x <Space>", messageMenu c Local.promptConfig),
    -- ("M-.", repeatLastXMessage)
  ]

-- | Window focusing, swapping, and other actions.
windowKeys :: [(String, X ())]
windowKeys =
  -- Focusing Windows:
  [
    ("M-m", windows W.focusMaster)
  , ("M-j", windows W.focusDown)
  , ("M-k", windows W.focusUp)
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

    -- ("M-'", nextMatch History (return True))
  -- , ("M-w k", windows W.focusUp)
  -- , ("M-w j", windows W.focusDown)
  -- , ("M-u", focusUrgent)
  -- , ("M-o", windowPromptGoto)
  -- , ("M-j", windowGo D False)
  -- , ("M-k", windowGo U False)
  -- , ("M-l", windowGo R False)
  -- , ("M-h", windowGo L False)
  -- , ("M-C-m", windows W.focusMaster)
   -- -- Moving Windows:
  -- , ("M-C-l", windowSwap R False)
  -- , ("M-C-h", windowSwap L False)
  -- , ("M-C-j", windowSwap D False)
  -- , ("M-C-k", windowSwap U False)
  -- , ("M-<U>", rotSlavesUp)
  -- , ("M-<D>", rotSlavesDown)
   -- -- Promote current window to master.
  -- , ("M-m", whenX (swapHybrid False) promote)
   -- -- Resizing Windows:
  -- , ("M-S-h", sendMessage Shrink)
  -- , ("M-S-l", sendMessage Expand)
  -- , ("M-S-j", sendMessage MirrorShrink)
  -- , ("M-S-k", sendMessage MirrorExpand)
   -- -- Window Layers and Killing and Yanking:
  -- , ("M-C-;", switchLayer)
  -- , ("M-w t", withFocused $ windows . W.sink) -- Tile window.
  -- , ("M-q", kill1) -- Kill the current window.
  -- , ("M-S-y", withFocused minimizeWindow >> windows W.focusDown)
  -- , ("M-S-p", withLastMinimized maximizeWindowAndFocus)
  ]

-- | Navigate windows by using tags.
-- windowTagKeys :: XConfig Layout -> [(String, X ())]
-- windowTagKeys _ =
--   [
--     ("M-/", tagPrompt Local.promptConfig >> sendMessage (IncLayoutN 0)),
--     ("M-a", primaryJumpTagUp),
--     ("M-C-a", secondaryJumpTagUp),
--     ("M-t a", addFocusTag),
--     ("M-t d", rmFocusTag),
--     ("M-t j", tagPrompt' Local.promptConfig [SetJumpTag]),
--     ("M-t r", rmFocusTagAll >> addFocusTag)
--   ]
--     ++ numberedTags
--   where
--     addFocusTag :: X ()
--     addFocusTag = do
--       withFocused (addTag "focus")
--       sendMessage (IncLayoutN 0)
--     rmFocusTag :: X ()
--     rmFocusTag = do
--       withFocused (delTag "focus")
--       sendMessage (IncLayoutN 0)
--     rmFocusTagAll :: X ()
--     rmFocusTagAll = withTagged "focus" (delTag "focus")
--     numberedTags :: [(String, X ())]
--     numberedTags = do
--       key <-
--         map show ([0 .. 9] :: [Int])
--           ++ map (("F" ++) . show) ([1 .. 12] :: [Int])
--       (prefix, action) <- numberedTemplate
--       return (prefix ++ asKey key, action key)
--     numberedTemplate :: [(String, String -> X ())]
--     numberedTemplate =
--       [ ("M-M1", focusTag'),
--         ("M-M1-C-", toggleTagOnCurrentWindow)
--       ]

-- | Keys for manipulating workspaces.
workspaceKeys :: [(String, X ())]
workspaceKeys =
      [("M-;", viewPrevWS)]
        -- change active workspace
      ++ [("M-" ++ workSpace, windows $ W.greedyView workSpace) | workSpace <- myWorkspaces ]
      -- move window and change active workspace
      ++ [("M-S-" ++ workSpace, windows $ W.greedyView workSpace . W.shift workSpace) | workSpace <- myWorkspaces ]
      -- move window
      ++ [("M1-S-" ++ workSpace, windows $ W.shift workSpace) | workSpace <- myWorkspaces ]
-- | Keys for manipulating workspaces.
-- workspaceKeys :: XConfig Layout -> [(String, X ())]
-- workspaceKeys conf =
--   [ ("M-<Space>", switchProjectPrompt Local.promptConfig),
--     ("M-<Esc>", spawn "rofi -show Desktop"),
--     ("M-;", viewPrevWS)
--   ]
--     ++ workspaceByIndex
--   where
--     workspaceByIndex :: [(String, X ())]
--     workspaceByIndex = do
--       (name, num) <- zip (workspaces conf) ([1 .. 9] ++ [0])
--       (key, action) <- workspaceTemplate
--       pure (key num, action name)
--     workspaceTemplate :: [(Int -> String, String -> X ())]
--     workspaceTemplate =
--       [ (("M-" <>) . show, windows . W.greedyView),
--         (("M-C-" <>) . show, windows . W.shift)
--       ]

-- | Layout switching and manipulation.
-- layoutKeys :: XConfig Layout -> [(String, X ())]
-- layoutKeys c =
--   [ ("M-<Backspace>", selectLayoutByName Local.promptConfig),
--     ("M-w <Esc>", setLayout (layoutHook c)), -- Reset to default layout.
--     ("M-z", withFocused (sendMessage . maximizeRestore)),
--     ("M-f", toggleLayout "Full"),
--     ("M-S-f", toggleLayout "Focus"),
--     ("M-c", toggleLayout "Single"),
--     ("M-=", sendMessage (IncMasterN 1)),
--     ("M--", sendMessage (IncMasterN (-1))),
--     ("M-S-=", sendMessage (IncLayoutN 1)),
--     ("M-S--", sendMessage (IncLayoutN (-1))),
--     ("M-C-=", sendMessage (IncMasterCol 1)),
--     ("M-C--", sendMessage (IncMasterCol (-1))),
--     ("M-s", sendMessage ToggleStruts >> spawn "polybar-msg cmd toggle")
--   ]

-- | Keys to manipulate screens (actual physical monitors).
-- screenKeys :: XConfig Layout -> [(String, X ())]
screenKeys :: [(String, X ())]
screenKeys =
  [
    -- ("M-S-0", onNextNeighbour def W.view),
    -- ("M-S-9", onPrevNeighbour def W.view),
    -- ("M-d", screenSwap L True),
    ("C-M1-l", spawn "loginctl lock-session")
  ]

-- | Keys for launching applications.
applicationKeybindings :: [(String, X ())]
applicationKeybindings =
  [
    ("M-S-<Return>"      , spawn "st")
  , ("M-<Return>"        , spawn "alacritty")
  , ("M-S-p"             , spawn "dmenu_run -nb '#9370DB' -nf '#50fa7b' -sb '#EE82EE' -sf black -fn 'monofur for Powerline'")
  , ("M-S-f"             , spawn "spacefm")
  -- , ("M-<F2>"            , spawnToWorkspace "spacefm" ( myWorkspaces !! 7 ))
  , ("M-f"               , spawn "st -e lf")
  , ("M-i"               , spawn "browser")
  , ("M-S-i"             , spawn ("browser" ++ " --incognito"))
  , ("M-y"               , spawn "passmenu -nb '#9370DB' -nf '#50fa7b' -sb '#EE82EE' -sf black -fn 'monofur for Powerline'")
  -- , ("M-<Print>"         , spawn "flameshot gui -p $HOME/screenshots")
  , ("M-<F4>"            , spawn "flameshot gui -p $HOME/screenshots")
  , ("M-b"               , spawn "redshift -O 3500")
  , ("M-S-b"             , spawn "redshift -x")
  , ("M-<F3>"            , spawn "intellij")
  , ("M-C-n"             , spawn ("st" ++ " -e newsboat"))
    -- ("M-C-u", Local.webAppPrompt Local.promptConfig),
    -- ("M-S-]", namedScratchpadAction scratchPads "emacs"),
    -- ("M-S-[", namedScratchpadAction scratchPads "browser")
  , ("M-S-<Escape>"      , spawn "wm-exit xmonad")
  -- , ("M-S-<Backspace>"   , spawn "xdo close")
  , ("M-S-<Backspace>"   , kill1) -- Kill the current window.
  , ("M-<Escape>"        , spawn "xmonad --recompile && xmonad --restart")

  -- TODO: need to fix the includes
  , ("M-v"               , sendKey noModMask xF86XK_Paste)

  , ("M-<F12>"           , namedScratchpadAction scratchPads "terminal")
  , ("M-<F11>"           , namedScratchpadAction scratchPads "discord")
  ]

-- | Keys for controlling music and volume.
-- musicKeys :: XConfig Layout -> [(String, X ())]
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

-- | Start an Emacs server for the current workspace.
emacs :: X ()
emacs = do
  name <- gets (W.tag . W.workspace . W.current . windowset)
  spawn ("e -cs " ++ name)

-- | Restart XMonad but instead of starting the XMonad in @PATH@,
-- start a debugging version built out of my development tree.
-- restartIntoDebugging :: X ()
-- restartIntoDebugging = do
--   home <- io getHomeDirectory
--   restart (home </> "src/rc/xmonadrc/result/bin/xmonadrc") True

-- windowPromptGoto :: X ()
-- windowPromptGoto = windowMultiPrompt Local.promptConfig modes
--   where
--     modes =
--       [ (Goto, allWindows),
--         (Goto, wsWindows),
--         (BringCopy, allWindows),
--         (Bring, allWindows)
--       ]

-- | A menu of less frequently used actions:
data MessageMenu = MessageMenu

instance XPrompt MessageMenu where
  showXPrompt MessageMenu = "XMonad Action: "

-- messageMenu :: XConfig Layout -> XPConfig -> X ()
-- messageMenu xc conf =
--   mkXPrompt MessageMenu conf' (Local.aListCompFunc conf' actions) go
--   where
--     go :: String -> X ()
--     go selected = maybe (return ()) recordXMessage $ lookup selected actions
--     conf' :: XPConfig
--     conf' = conf {alwaysHighlight = True}
--     actions :: [(String, X ())]
--     actions =
--       [ ("IncLayoutN", sendMessage (IncLayoutN 1)),
--         ("DecLayoutN", sendMessage (IncLayoutN (-1))),
--         ("Next Layout", sendMessage NextLayout),
--         ("IncMasterN", sendMessage (IncMasterN 1)),
--         ("DecMasterN", sendMessage (IncMasterN (-1))),
--         ("ToggleStruts", sendMessage ToggleStruts),
--         ("ToggleSpacing", toggleWindowSpacingEnabled),
--         ("Tile Window", withFocused $ windows . W.sink),
--         ("Screen Spacing Wide", setScreenSpacing (Border 20 20 60 60)),
--         ("Screen Spacing Reset", setScreenSpacing (Border 0 0 0 0)),
--         ("Screen Spacing +5", incScreenSpacing 5),
--         ("Screen Spacing -5", decScreenSpacing 5),
--         ("Window Spacing +5", incWindowSpacing 5),
--         ("Window Spacing -5", decWindowSpacing 5),
--         ("ZoomIn", sendMessage zoomIn),
--         ("ZoomOut", sendMessage zoomOut),
--         ("ZoomReset", sendMessage zoomReset),
--         ("Reset Layout", setLayout (layoutHook xc)),
--         ("WebApp Prompt", Local.webAppPrompt Local.promptConfig)
--       ]

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
