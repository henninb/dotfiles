module Local.Layouts where

import XMonad
import XMonad.Layout.Renamed
import XMonad.Hooks.ManageDocks
import XMonad.Layout.PerWorkspace
import XMonad.Layout.LimitWindows
import XMonad.Layout.NoBorders
import XMonad.Layout.Gaps
import XMonad.Layout.Minimize
import XMonad.Layout.FixedColumn
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Magnifier
import qualified XMonad.Layout.BoringWindows as B

myLayouts = renamed [CutWordsLeft 1] . avoidStruts . minimize . B.boringWindows $ perWS

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
