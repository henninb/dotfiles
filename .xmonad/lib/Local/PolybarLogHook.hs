module Local.PolybarLogHook (polybarLogHook, eventLogHookForPolybar) where

import XMonad
import XMonad.Hooks.DynamicLog
import Data.Char (isDigit)
import Control.Monad (join)
import Data.List (sortBy)
import Data.Function (on)
import XMonad.Util.NamedWindows (getName)
import qualified XMonad.StackSet as W

import Local.Colors

myPurple :: String
myPurple = "#663399"

myAddSpaces :: Int -> String -> String
myAddSpaces len str = sstr ++ replicate (len - length sstr) ' '
  where
    sstr = shorten len str

polybarOutput barOutputString =
  io $ appendFile "/tmp/.xmonad-info" (barOutputString ++ "\n")

eventLogHookForPolybar = do
    winset <- gets windowset
    title <- maybe (return "") (fmap show . getName) . W.peek $ winset
    let currWs = W.currentTag winset
    let wss = map W.tag $ W.workspaces winset

    -- io $ appendFile "/tmp/.xmonad-title-log" (title ++ "\n")
    io $ appendFile "/tmp/.xmonad-info" (wsStr currWs wss ++ "\n")

    where
      fmt currWs workSpace
            | currWs == workSpace = "[" ++ workSpace ++ "]"
            | otherwise    = " " ++ workSpace ++ " "
      wsStr currWs wss = join $ map (fmt currWs) $ sortBy (compare `on` (!! 0)) wss
      wrapOpenWorkspaceCmd wsp
          | all isDigit wsp = wrapOnClickCmd ("xdotool key super+" ++ wsp) wsp
          | otherwise = wsp
      wrapOnClickCmd cmd = wrap ("%{A1:" ++ cmd ++ ":}") "%{A}"

currentWindowCount :: X (Maybe String)
currentWindowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

-- words   :: String -> [String]
-- unwords :: [String] -> String
polybarLogHook = def
    {
      ppOutput = polybarOutput
    , ppCurrent = withForeground myPurple . withBackground lightpink . withMargin
    , ppVisible = withForeground white . withMargin
    , ppUrgent = withForeground red . withMargin
    , ppHidden = withForeground white . withMargin . unwords . map wrapOpenWorkspaceCmd . words
    , ppHiddenNoWindows = withForeground gray . withMargin . unwords . map wrapOpenWorkspaceCmd . words
    , ppOrder = \(workSpace:l:t:ex) -> [workSpace,l]++ex++[t]
    , ppWsSep = ""
    , ppSep = withForeground gray "   |"
    , ppLayout    = wrap "%{A1:xdotool key super+space:}" "%{A}"
    , ppTitle = myAddSpaces 25
    , ppExtras = [currentWindowCount]
    } where
        withMargin = wrap " " " "
        withBackground color = wrap ("%{B" ++ color ++ "}") "%{B-}"
        withForeground color = wrap ("%{F" ++ color ++ "}") "%{F-}"
        wrapOpenWorkspaceCmd wsp
          | all isDigit wsp = wrapOnClickCmd ("xdotool key super+" ++ wsp) wsp
          | otherwise = wsp
        wrapOnClickCmd cmd = wrap ("%{A1:" ++ cmd ++ ":}") "%{A}"
        showNamedWorkspaces1 = pad
