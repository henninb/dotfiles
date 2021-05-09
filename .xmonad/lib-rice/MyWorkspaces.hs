module MyWorkspaces
( myWorkspaces
, wsTerm, wsNet, wsEdit, wsPlace, wsMail, ws6, ws7, ws8, ws9
) where

-- hooks --
import XMonad.Hooks.DynamicLog

-- Workspaces
--["1:web", "2:term", "3:mail", "4:files", "5:steam", "6:media", "7:audio", "8:misc", "9:other"]
myWorkspacenames = ["1:term", "2:web", "3:steam", "4:place", "5:mail", "6:media", "7:audio", "8:misc", "9:other"]

myWorkspaces :: [String]
myWorkspaces = clickable . map dzenEscape $ myWorkspacenames
    where clickable l = [ x ++ ws ++ "^ca()^ca()^ca()" |
                        (i,ws) <- zip "123456789" l,
                        let n = i
                            x = "^ca(1,xdotool key super+" ++ show n ++ ")"]

[wsTerm, wsNet, wsEdit, wsPlace, wsMail, ws6, ws7, ws8, ws9] = myWorkspaces

