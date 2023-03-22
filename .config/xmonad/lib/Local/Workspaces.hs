module Local.Workspaces (myWorkspaces, viewPrevWS, projects, terminalProject, scratchPads) where

import XMonad
import Control.Monad (unless)
import XMonad.Util.NamedScratchpad ( NamedScratchpad(..), customFloating)
import XMonad.Actions.DynamicProjects ( Project(..), projectStartHook, projectName, projectDirectory)
import XMonad.StackSet ( RationalRect(..), tag, view, hidden )

terminalProject :: Project
terminalProject =
  Project {
    projectName = "terminal"
    , projectDirectory = "~/projects"
    , projectStartHook = Just $ spawn "alacritty"
  }

projects :: [Project]
projects = [ terminalProject ]

wsNames :: [String]
wsNames = ["1","2","3","4","5","6","7","8","9","0"]

myWorkspaces :: [String]
myWorkspaces = wsNames

viewPrevWS :: X ()
viewPrevWS = do
  ws <- gets windowset
  let hs = filter (\w -> tag w /= "NSP") $ hidden ws
  unless (null hs) (windows . view . tag $ head hs)

clickableWorkspaces :: [String]
clickableWorkspaces = clickable wsNames
  where clickable l     = [ "^ca(1,xdotool key super+" ++ show n ++ ")" ++ ws ++ "^ca()" |
                            (i, ws) <- zip [1..] l,
                            let n = i ]

scratchPads :: [NamedScratchpad]
scratchPads = [   NS "terminal-nsp" spawnTerm findTerm manageTerm
                , NS "discord-nsp" spawnDiscord findDiscord manageDiscord
                , NS "tmux-nsp" spawnTmux findTmux manageTmux
                , NS "calc-nsp" spawnCalc findCalc manageCalc
                , NS "keepass-nsp" "keepassxc" (className =? "KeePassXC" <||> className =? "keepassxc") (customFloating $ RationalRect 0.50 0.05 0.4 0.87)
                , NS "vlc-nsp" "vlc" (className =? "vlc") (customFloating $ RationalRect 0.50 0.05 0.4 0.87)
                , NS "spotify-nsp" "spotify" (className =? "Spotify") (customFloating $ RationalRect 0.50 0.05 0.4 0.87)
              ]
    where
    full = customFloating $ RationalRect 0.05 0.05 0.9 0.9
    top = customFloating $ RationalRect 0.0 0.0 1.0 0.5
    h = 0.9
    w = 0.9
    t = 0.95 - h
    l = 0.95 - w
    spawnTerm = "st" ++  " -n suckless-terminal"
    findTerm = resource =? "suckless-terminal"
    manageTerm = customFloating $ RationalRect l t w h
    spawnTmux = "st -t tmux-nsp -e tmux new-session -A -s scratch"
    findTmux = title =? "tmux-nsp"
    manageTmux = customFloating $ RationalRect l t w h
    spawnDiscord = "discord-flatpak"
    findDiscord = resource =? "discord"
    manageDiscord = customFloating $ RationalRect l t w h
    spawnCalc  = "qalculate-gtk"
    findCalc   = className =? "Qalculate-gtk"
    manageCalc = customFloating $ RationalRect l t w h
               where
                 h = 0.5
                 w = 0.4
                 t = 0.75 -h
                 l = 0.70 -w
