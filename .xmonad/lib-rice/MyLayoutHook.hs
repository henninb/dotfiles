module MyLayoutHook
( myLayoutHook
, commonLayout, screenshotLayout, workingLayout, browserLayout
) where

import XMonad

-- hooks --
import XMonad.Hooks.ManageDocks

import XMonad.Layout.ToggleLayouts

-- layout --
import XMonad.Layout.Spacing
import XMonad.Layout.Gaps
import XMonad.Layout.SimpleFloat
import XMonad.Layout.NoBorders
import XMonad.Layout.ThreeColumns
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Renamed (renamed, Rename(CutWordsLeft, Replace))
--import XMonad.Layout.Named

-- own module: configuration decomposition --
import MyWorkspaces

------------------------------------------------------------------------

-- toggleLayouts ??
-- Layout Hook
myLayoutHook
    = onWorkspaces [wsTerm] screenshotLayout
    $ onWorkspaces [wsEdit, wsPlace] workingLayout
    $ onWorkspaces [wsNet, wsMail] browserLayout
    $ onWorkspaces [ws6, ws7, ws8, ws9] commonLayout commonLayout

commonLayout = renamed [Replace "common"]
    $ avoidStruts
    $ gaps [(U,5), (D,5)]
--    $ spacing 10
    $ Tall 1 (5/100) (1/3)

screenshotLayout = renamed [Replace "screenshot"]
    $ avoidStruts
    $ gaps [(U,25), (D,25)]
--    $ spacing 16
    $ Mirror
    $ Tall 1 (5/100) (1/2)
--  $ Tall 1 (30/1280) (794/1280)
--  $ ThreeColMid 2 (3/100) (1/2)

workingLayout = renamed [Replace "working"]
    $ avoidStruts
    $ gaps [(U,5), (D,5)]
--    $ spacing 10
    $ layoutHook def
--    $ layoutHook defaultConfig

browserLayout = renamed [Replace "browser"]
    $ noBorders
    $ gaps [(U,40), (D,40)] Full
--  $ simpleFloat
