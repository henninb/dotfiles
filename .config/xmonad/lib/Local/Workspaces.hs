module Local.Workspaces (myWorkspaces, scratchPads, viewPrevWS, projects, terminalProject) where

import XMonad
import Control.Monad (unless)
import XMonad.Util.NamedScratchpad ( NamedScratchpad(..), customFloating)
import XMonad.Actions.DynamicProjects ( Project(..), projectStartHook, projectName, projectDirectory)
import XMonad.StackSet ( RationalRect(..), tag, view, hidden )

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

terminalProject :: Project
terminalProject =
  Project {
    projectName = "terminal"
    , projectDirectory = "~/projects"
    , projectStartHook = Just $ spawn "alacritty"
  }

scratchProject :: Project
scratchProject = Project { projectName = "scratch"
            , projectDirectory = "~/"
            , projectStartHook = Nothing
            }

projects :: [Project]
projects = [ terminalProject ]

myWorkspaces :: [String]
myWorkspaces = [ws1, ws2, ws3, ws4, ws5, ws6, ws7, ws8, ws9, ws0]


-- myWorkspaces        = map show [1..9]


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

viewPrevWS :: X ()
viewPrevWS = do
  ws <- gets windowset
  let hs = filter (\w -> tag w /= "NSP") $ hidden ws
  unless (null hs) (windows . view . tag $ head hs)

clickableWorkspaces :: [String]
clickableWorkspaces = clickable [ws1, ws2, ws3, ws4, ws5, ws6, ws7, ws8, ws9, ws0]
  where clickable l     = [ "^ca(1,xdotool key super+" ++ show n ++ ")" ++ ws ++ "^ca()" |
                            -- (i,ws) <- zip [1..] l,
                            (i, ws) <- zip myWorkspaces l,
                            let n = i ]

-- myClickableWorkspaces :: [String]
-- myClickableWorkspaces = clickable . (map xmobarEscape)
--            -- $ [" 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 ", " 9 "]
--            $ [" dev ", " www ", " sys ", " doc ", " vbox ", " chat ", " mus ", " vid ", " gfx "]
--     where
--         clickable l = [ "<action=xdotool key super+" ++ show (n) ++ ">" ++ ws ++ "</action>" |
--                   (i,ws) <- zip [1..9] l,
--                   let n = i ]
