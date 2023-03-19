module Local.DzenLogHook (dzenLogHook) where

import XMonad
import XMonad.Hooks.DynamicLog (PP(..), ppLayout, ppTitle, ppSep, ppWsSep, ppHidden, ppHiddenNoWindows, ppExtras, ppOrder, ppUrgent, ppVisible, ppCurrent, ppOutput, wrap, shorten)
import Data.Char (isDigit)
import Control.Monad (join)
import XMonad.Util.Run (hPutStrLn)
import Data.Function (on)
import XMonad.StackSet (stack, workspace, current, integrate')
import GHC.IO.Handle.Types
import System.IO (stderr)
-- import XMonad.Actions.DynamicWorkspaces (switchTo)
--import XMonad (windows)

import Local.Colors

-- stripDzen s = aux s [] -- strip dzen formatting to undo ppHidden
--   where aux [] acc = acc
--         aux x  acc = (\(good,bad) -> aux (dropDzen bad) (acc++good)) $ span (/= '^') x
--             where dropDzen b = drop 1 $ dropWhile (/= ')') b
myPurple :: String
myPurple = "#663399"

dzenOutput :: MonadIO m => String -> m ()
dzenOutput barOutputString =
    io $ appendFile "/tmp/.xmonad-info" (barOutputString ++ "\n")

--TODO: wrap not working
currentWindowCount :: [X (Maybe String)]
currentWindowCount = [gets $ Just . wrap "" "" . show . length . integrate' . stack . workspace . current . windowset]

clickableWorkspaceNew :: String -> String
clickableWorkspaceNew ws = "^ca(1,xdotool key super+" ++ ws ++ ") " ++ ws ++ " ^ca(0, " ++ switchCommand ws ++ ")"
  where switchCommand w = "xmonadctl workspace " ++ w ++ " || " ++ "xdotool key super+" ++ w ++ " || " ++ "windows W.greedyView \"" ++ w ++ "\""

-- hiddenDetails :: [X (Maybe String)]
-- hiddenDetails = [withWindowSet (fmap safeUnpack . extraFormatting)] -- init takes out the last space
--   where
--     safeUnpack s = if T.null s then Nothing else (Just . T.unpack) s
--     extraFormatting = fmap (\s -> front `T.append` s `T.append` back)
--       where
--         front = T.pack "<fc=lightgray>"
--         back = T.pack "</fc>"

dzenLogHook :: Handle -> PP
dzenLogHook h = def
  {
      -- for troubleshooting - logs are posted to ~/.local/share/sddm/xorg-session.log
      -- ppOutput = \s -> hPutStrLn h s >> hPutStrLn stderr s
      ppOutput  =   hPutStrLn h
    , ppCurrent = withForeground myPurple . withBackground lightpink . withMargin . clickableWorkspace
    , ppVisible = withForeground white . withMargin . clickableWorkspace
    , ppUrgent = withForeground red . withMargin
    , ppHidden = withForeground white . withMargin . clickableWorkspace
    , ppHiddenNoWindows = withForeground gray . withMargin .clickableWorkspace
    , ppOrder  =  \(ws:l:t:_) -> [ws,l, t]
    , ppWsSep = ""
    , ppSep = "    "
    , ppLayout = withForeground white . wrap "^ca(1,xdotool key super+space)" "^ca()"
    --TODO: what would the clickable do?
    , ppTitle =  withForeground white . wrap "^ca(1,xdotool key super+shift+x)" "^ca()"  . shorten 80 . withMargin
    , ppExtras = currentWindowCount
  } where
      clickableWorkspace ws = "^ca(1,xdotool key super+" ++ ws ++ ") " ++ ws ++ " ^ca()"
      withFont = wrap "^fn(monofur for Powerline-16)" "^fn()"
      withForeground color = wrap ("^fg(" ++ color ++ ")") "^fg()" . withFont
      withBackground color = wrap ("^bg(" ++ color ++ ")") "^bg()"
      withMargin = wrap " " " "

