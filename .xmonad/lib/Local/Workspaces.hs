module Local.Workspaces (myWorkspaces, scratchPads, viewPrevWS) where

import XMonad
import Control.Monad (unless)
import XMonad.Util.NamedScratchpad
import qualified XMonad.StackSet as W
import qualified XMonad.StackSet as StackSet

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

viewPrevWS :: X ()
viewPrevWS = do
  ws <- gets windowset
  let hs = filter (\w -> StackSet.tag w /= "NSP") $ StackSet.hidden ws
  unless (null hs) (windows . StackSet.view . StackSet.tag $ head hs)

