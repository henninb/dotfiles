module Local.Layouts (myLayouts) where

import XMonad
import XMonad.Layout.Renamed
import XMonad.Hooks.ManageDocks
import XMonad.Layout.PerWorkspace
import XMonad.Layout.LimitWindows
import XMonad.Layout.NoBorders
import XMonad.Layout.Gaps
import XMonad.Layout.Grid
import XMonad.Layout.ComboP
import XMonad.Layout.Spacing
import XMonad.Layout.Minimize
import XMonad.Layout.FixedColumn
import XMonad.Layout.ThreeColumns
import XMonad.Layout.ResizableTile
import XMonad.Layout.TwoPane
import XMonad.Layout.Magnifier
import XMonad.Layout.Tabbed
import XMonad.Layout.WindowNavigation
import XMonad.Config.Desktop
import qualified XMonad.Layout.BoringWindows as B
import XMonad.Layout.IM
import XMonad.Layout.Circle (Circle (..))
import XMonad.Layout.Reflect (reflectHoriz)

import Local.Workspaces (myWorkspaces)

-- ws1 :: String
-- ws1 = "1"
-- ws2 = "2"
-- ws3 = "3"
-- ws4 = "4"
-- ws5 = "5"
-- ws6 = "6"
-- ws7 = "7"
-- ws8 = "8"
-- ws9 = "9"
-- ws0 = "0"

myLayouts = renamed [CutWordsLeft 1] . avoidStruts . minimize . B.boringWindows $ workspaceLayouts

  -- layout per workspace
workspaceLayouts =
        -- onWorkspace [myWorkspaces!!0] my3FT $
        onWorkspace "1" my3FT $
        onWorkspace "2" myAll $
        onWorkspace "3" myFTM $
        onWorkspace "4" my3FT $
        onWorkspace "5" myFTM $
        onWorkspace "8" terminalLayout $
        onWorkspace "0" mediaLayout $
        onWorkspace "6" myFT myAll -- all layouts for all other workspaces
 where
    tiled = Tall nmaster delta ratio
    nmaster = 1
    delta = 3/100
    ratio = 1/2


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
terminalLayout = renamed [Replace "Terminals"]
      $ gaps [(U,5), (D,5)]
      $ simpleTall 50 ||| simpleThree 33 ||| Mirror (simpleTall 53)
-- codingLayout = renamed [Replace "Coding"]
--       $ twoPaneTabbed ||| twoPaneTall ||| simpleTall 50
mediaLayout = renamed [Replace "Media"]
      -- $ mySpacing
      $ simpleTwo 40 ||| Grid ||| simpleThree 33
readingLayout = renamed [Replace "Reading"]
      -- $ mySpacing
      $ simpleTwo 50 ||| simpleThree 50
panelLayout = renamed [Replace "Control"]
      -- $ mySpacing
      $ Grid ||| Mirror (simpleTall 50) ||| simpleThree 33
-- circleLayout = renamed [Replace "cir" ]
--       $ Mirror Tall 1 (3/100) (1/2) ||| tiled ||| Circle

-- twoPaneTabbed =
--   configurableNavigation noNavigateBorders $
--   combineTwoP (Spacing $ TwoPane 0.03 0.50)
--       Full
--       (tabbed shrinkText def)
--       (ClassName "Firefox" `Or` ClassName "qpdfview")

twoPaneTall =
  windowNavigation $
  combineTwoP (TwoPane 0.03 0.50) Full (Mirror $ simpleThree 60) (ClassName "Firefox" `Or` ClassName "Brave")

--simpleTall :: Rational -> ResizableTall a
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
