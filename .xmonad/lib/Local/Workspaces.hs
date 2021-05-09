module Local.Workspaces (myWorkspaces, scratchPads) where

import XMonad
-- import qualified Data.Map as M
-- import Graphics.X11.Xlib
-- -- import System.Directory
-- -- import System.FilePath ((</>))
-- import XMonad hiding (keys)
-- import XMonad.Actions.CopyWindow (kill1)
-- import XMonad.Actions.DynamicProjects (switchProjectPrompt)
-- import XMonad.Actions.GroupNavigation (Direction (..), nextMatch)
-- import XMonad.Actions.Minimize
-- import XMonad.Actions.Navigation2D
-- import XMonad.Actions.PhysicalScreens (onNextNeighbour, onPrevNeighbour)
-- import XMonad.Actions.Promote (promote)
-- import XMonad.Actions.RotSlaves (rotSlavesDown, rotSlavesUp)
-- import XMonad.Actions.SwapPromote (swapHybrid)
-- import XMonad.Actions.TagWindows (addTag, delTag, withTagged)
-- import XMonad.Hooks.ManageDocks (ToggleStruts (..))
-- import XMonad.Hooks.UrgencyHook (focusUrgent)
-- import XMonad.Layout.LayoutBuilder (IncLayoutN (..))
-- import XMonad.Layout.Maximize (maximizeRestore)
-- import XMonad.Layout.ResizableTile
-- import XMonad.Layout.Spacing
-- import XMonad.Layout.ZoomRow (zoomIn, zoomOut, zoomReset)
-- import XMonad.Layout.WindowArranger -- for DecreaseRight, IncreaseUp
-- import Graphics.X11.ExtraTypes -- for xF86XK_Paste
-- import XMonad.Util.Paste (sendKey) -- for sendKey
-- -- import XMonad.Local.Layout (selectLayoutByName, toggleLayout)
-- -- import XMonad.Local.Layout.Columns (IncMasterCol (..))
-- -- import XMonad.Local.Music (radioPrompt)
-- -- import qualified XMonad.Local.Prompt as Local
-- -- import XMonad.Local.Tagging
-- -- import XMonad.Local.Workspaces (asKey, scratchPads, viewPrevWS)
-- import XMonad.Prompt
-- import XMonad.Prompt.Window (WindowPrompt (..), allWindows, windowMultiPrompt, wsWindows)
-- import qualified XMonad.StackSet as W
-- import XMonad.Util.EZConfig (mkKeymap)
-- import qualified XMonad.Util.ExtensibleState as XState
-- import XMonad.Util.NamedScratchpad (namedScratchpadAction)
import XMonad.Util.NamedScratchpad
import qualified XMonad.StackSet as W


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

myWorkspaces :: [String]
myWorkspaces = [ws1, ws2, ws3, ws4, ws5, ws6, ws7, ws8, ws9, ws0]

scratchPads :: [NamedScratchpad]
scratchPads = [ NS "terminal" spawnTerm findTerm manageTerm
                 , NS "discord" spawnDiscord findDiscord manageDiscord ]
    where
    full = customFloating $ W.RationalRect 0.05 0.05 0.9 0.9
    top = customFloating $ W.RationalRect 0.0 0.0 1.0 0.5
    h = 0.9
    w = 0.9
    t = 0.95 -h
    l = 0.95 -w
    spawnTerm  = "st" ++  " -n scratchpad"
    findTerm   = resource =? "scratchpad"
    manageTerm = customFloating $ W.RationalRect l t w h
    spawnDiscord  = "discord-flatpak"
    findDiscord   = resource =? "discord"
    manageDiscord = customFloating $ W.RationalRect l t w h
