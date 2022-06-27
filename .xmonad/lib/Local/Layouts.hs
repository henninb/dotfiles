{-# LANGUAGE PatternSynonyms #-}

module Local.Layouts (myLayouts) where

import XMonad hiding ( (|||) )
import XMonad.Layout.Renamed (Rename, renamed, pattern Replace, pattern CutWordsLeft)
import XMonad.Hooks.ManageDocks (AvoidStruts, avoidStruts)
import XMonad.Layout.PerWorkspace (onWorkspace, onWorkspaces)
import XMonad.Layout.LimitWindows (LimitWindows, limitWindows)
import XMonad.Layout.NoBorders (SmartBorder, smartBorders, noBorders)
import XMonad.Layout.Grid (Grid(..))
import XMonad.Layout.ComboP (CombineTwoP, combineTwoP)
import XMonad.Layout.Spacing (Border(..), spacingRaw)
import XMonad.Layout.Minimize (minimize)
import XMonad.Layout.FixedColumn (FixedColumn(..))
import XMonad.Layout.ThreeColumns (ThreeCol(..))
import XMonad.Layout.ResizableTile (ResizableTall(..))
import XMonad.Layout.TwoPane (TwoPane(..))
import XMonad.Layout.Magnifier (magnifiercz')
-- import XMonad.Layout.Tabbed
import XMonad.Layout.WindowNavigation (WindowNavigation, windowNavigation)
import XMonad.Config.Desktop (desktopLayoutModifiers)
import XMonad.Layout.BoringWindows (boringWindows)
import XMonad.Layout.Spiral (SpiralWithDir, spiralWithDir, pattern East, pattern CW)
import XMonad.Layout.IM
import XMonad.Layout.Circle (Circle (..))
import XMonad.Layout.Reflect (reflectHoriz)
import System.Info (os)
import XMonad.Layout.LayoutCombinators ( (|||) )
import XMonad.Layout.LayoutModifier (ModifiedLayout)

import Local.Workspaces (myWorkspaces)

-- mySpacing = if os == "freebsd" then spacingRaw False (Border 14 1 1 1) True (Border 1 1 1 1) True else spacingRaw False (Border 2 1 1 1) True (Border 1 1 1 1) True
-- mySpacing = spacingRaw False (Border 14 1 1 1) True (Border 1 1 1 1) True
mySpacing = spacingRaw False (Border 1 1 1 1) True (Border 1 1 1 1) True

myLayouts = renamed [CutWordsLeft 1] . minimize . boringWindows $ workspaceLayouts

workspaceLayouts =
    onWorkspace (myWorkspaces !! 0) defaultLayoutGroup $
    onWorkspace (myWorkspaces !! 1) defaultLayoutGroup $
    onWorkspace (myWorkspaces !! 2) defaultLayoutGroup $
    onWorkspace (myWorkspaces !! 3) defaultLayoutGroup $
    onWorkspace (myWorkspaces !! 4) defaultLayoutGroup $
    onWorkspace (myWorkspaces !! 5) defaultLayoutGroup $
    onWorkspace (myWorkspaces !! 6) defaultLayoutGroup $
    onWorkspace (myWorkspaces !! 7) defaultLayoutGroup $
    onWorkspace (myWorkspaces !! 8) defaultLayoutGroup $
    onWorkspace (myWorkspaces !! 9) defaultLayoutGroup $
    smartBorders (layoutHook def)

defaultLayoutGroup = mainLayout ||| gridLayout ||| threeColumnLayout ||| spiralLayout ||| fullLayout

fullLayout :: ModifiedLayout Rename (ModifiedLayout AvoidStruts (ModifiedLayout LimitWindows (ModifiedLayout SmartBorder Full))) Window
fullLayout = renamed [Replace "Full"]
      $ avoidStruts
      $ limitWindows 100
      $ smartBorders Full

mainLayout :: ModifiedLayout Rename (ModifiedLayout AvoidStruts (ModifiedLayout SmartBorder (ModifiedLayout LimitWindows Tall))) Window
mainLayout = renamed [Replace "Main"]
      $ avoidStruts
      $ smartBorders
      $ limitWindows 100
      $ Tall 1 (3/100) (1/2)

gridLayout :: ModifiedLayout Rename (ModifiedLayout AvoidStruts (ModifiedLayout SmartBorder (ModifiedLayout LimitWindows Grid))) Window
gridLayout = renamed [Replace "Grid"]
      $ avoidStruts
      $ smartBorders
      $ limitWindows 100 Grid

threeColumnLayout :: ModifiedLayout Rename (ModifiedLayout AvoidStruts (ModifiedLayout SmartBorder (ModifiedLayout LimitWindows ThreeCol))) Window
threeColumnLayout = renamed [Replace "3Column"]
      $ avoidStruts
      $ smartBorders
      $ limitWindows 100
      $ ThreeColMid 1 (3/100) (1/2)

spiralLayout :: ModifiedLayout Rename (ModifiedLayout SmartBorder (ModifiedLayout AvoidStruts (ModifiedLayout LimitWindows SpiralWithDir))) a
spiralLayout  = renamed [Replace "Spiral"]
      $ smartBorders
      $ avoidStruts
      $ limitWindows 100
      $ spiralWithDir East CW (6/7)


twoPaneTall :: ModifiedLayout WindowNavigation (CombineTwoP (TwoPane ()) Full (Mirror ThreeCol)) Window
twoPaneTall =
  windowNavigation $
  combineTwoP (TwoPane 0.03 0.50) Full (Mirror $ simpleThree 60) (ClassName "Firefox" `Or` ClassName "Brave")

--simpleTall :: Rational -> ResizableTall a
simpleTall :: Rational -> ResizableTall a
simpleTall n = ResizableTall 1 (3/100) (n/100) []

simpleThree :: Rational -> ThreeCol a
simpleThree n = ThreeCol 1 (3/100) (n/100)

simpleTwo :: Rational -> TwoPane a
simpleTwo n = TwoPane (3/100) (n/100)

desktopLayouts =
    onWorkspace "1"  mailLayout $
    onWorkspace "2"  webLayout $
    onWorkspaces (map show [3..6]) defLayout $
    onWorkspace "7" threeCols $
    onWorkspace "8" gimpLayout $
    onWorkspace "9" fullLayout $
    smartBorders (layoutHook def)
    where
        defLayout = desktopLayoutModifiers $
            smartBorders $ Tall 1 (3/100) 0.5 ||| Full
        mailLayout = desktopLayoutModifiers $
            smartBorders $ Tall 1 (3/100) 0.65 ||| Full
        webLayout  = desktopLayoutModifiers $
            smartBorders $ Full ||| Tall 1 (3/100) 0.65
        threeCols = desktopLayoutModifiers $ smartBorders $
                ThreeCol 1 (3/100) (1/3) ||| Full ||| Tall 1 (2/100) 0.7
        fullLayout = desktopLayoutModifiers $
            noBorders $ Full ||| Mirror (Tall 1 (3/100) 0.8)
        gimpLayout  = avoidStruts $ withIM 0.11 (Role "gimp-toolbox") $
            reflectHoriz $ withIM 0.15 (Role "gimp-dock") Full
