module Local.Workspaces (myWorkspaces, scratchPads, viewPrevWS, projects, terminalProject) where

import XMonad
import Control.Monad (unless)
import XMonad.Util.NamedScratchpad
import XMonad.Actions.DynamicProjects
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
-- data MyWorkspace = WebWorkspace
--                  | MailWorkspace
--                  | CodeWorkspace
--                  | ChatWorkspace
--                  | WinWorkspace
--                  | MusicWorkspace
--                  deriving (Enum, Bounded)

-- myWorkspaces :: [MyWorkspace]
-- myWorkspaces = enumFrom minBound

-- toWorkspaceId :: MyWorkspace -> WorkspaceId
-- toWorkspaceId WebWorkspace = "web"
-- toWorkspaceId MailWorkspace = "mail"
-- toWorkspaceId CodeWorkspace = "code"
-- toWorkspaceId ChatWorkspace = "chat"
-- toWorkspaceId WinWorkspace = "win"
-- toWorkspaceId MusicWorkspace = "music"

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

-- myWorkspaces :: [String]
-- myWorkspaces = map show [1..9 :: Int]

scratchPads :: [NamedScratchpad]
scratchPads = [   NS "terminal-nsp" spawnTerm findTerm manageTerm
                , NS "discord-nsp" spawnDiscord findDiscord manageDiscord
                , NS "tmux-nsp" spawnTmux findTmux manageTmux
                , NS "calc-nsp" spawnCalc findCalc manageCalc
                , NS "keepass-nsp" "keepassxc" (className =? "KeePassXC" <||> className =? "keepassxc") (customFloating $ W.RationalRect 0.50 0.05 0.4 0.87)
                , NS "vlc-nsp" "vlc" (className =? "vlc") (customFloating $ W.RationalRect 0.50 0.05 0.4 0.87)
                , NS "spotify-nsp" "spotify" (className =? "Spotify") (customFloating $ W.RationalRect 0.50 0.05 0.4 0.87)
              ]
    where
    full = customFloating $ W.RationalRect 0.05 0.05 0.9 0.9
    top = customFloating $ W.RationalRect 0.0 0.0 1.0 0.5
    h = 0.9
    w = 0.9
    t = 0.95 - h
    l = 0.95 - w
    spawnTerm = "st" ++  " -n suckless-terminal"
    findTerm = resource =? "suckless-terminal"
    manageTerm = customFloating $ W.RationalRect l t w h
    spawnTmux = "st -t tmux-nsp -e tmux new-session -A -s scratch"
    findTmux = title =? "tmux-nsp"
    manageTmux = customFloating $ W.RationalRect l t w h
    spawnDiscord = "discord-flatpak"
    findDiscord = resource =? "discord"
    manageDiscord = customFloating $ W.RationalRect l t w h
    spawnCalc  = "qalculate-gtk"
    findCalc   = className =? "Qalculate-gtk"
    manageCalc = customFloating $ W.RationalRect l t w h
               where
                 h = 0.5
                 w = 0.4
                 t = 0.75 -h
                 l = 0.70 -w


viewPrevWS :: X ()
viewPrevWS = do
  ws <- gets windowset
  let hs = filter (\w -> StackSet.tag w /= "NSP") $ StackSet.hidden ws
  unless (null hs) (windows . StackSet.view . StackSet.tag $ head hs)

-- clickableWorkspaces  = clickable
--   ["^i(me.xbm) me"
--   ,"^i(shell.xbm) code"
--   ,"^i(web.xbm) web"
--   ,"^i(docs.xbm) docs"
--   ,"^i(tunes.xbm) tunes"
--   ,"^i(mail.xbm) mail"]
--       where clickable l     = [ "^ca(1,xdotool key super+" ++ show n ++ ")" ++ ws ++ "^ca()" |
--                               (i,ws) <- zip [1..] l,
--                               let n = i ]

-- myWorkspaces1           = clickable . (map dzenEscape) $ ["1","2","3","4","5", "6", "7", "8", "9", "0"]
clickableWorkspaces :: [String]
clickableWorkspaces = clickable ["1","2","3","4","5", "6", "7", "8", "9", "0"]
  where clickable l     = [ "^ca(1,xdotool key super+" ++ show n ++ ")" ++ ws ++ "^ca()" |
                            (i,ws) <- zip [1..] l,
                            let n = i ]
