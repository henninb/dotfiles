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

currentWorkSpace :: X (Maybe String)
currentWorkSpace = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

polybarLogHook = def
    { ppOutput = polybarOutput
    , ppCurrent = withForeground lightpink . withBackground darkpurple . wrap "[" "]"
    , ppVisible = withForeground hotpink
    , ppUrgent = withForeground red
    , ppHidden = wrap "<" ">" . unwords . map wrapOpenWorkspaceCmd . words
    , ppHiddenNoWindows = withForeground gray . wrap "{" "}" . unwords . map wrapOpenWorkspaceCmd . words
    , ppOrder = \(workSpace:l:t:ex) -> [workSpace,l]++ex++[t]
    , ppWsSep = (withForeground gray . withMargin) ":"
    , ppSep = (withForeground gray . withMargin) "|"
    , ppTitle = myAddSpaces 25
    , ppExtras = [currentWorkSpace]
    }    where
      withMargin = wrap " " " "
      withBackground color = wrap ("%{B" ++ color ++ "}") "%{B-}"
      withForeground color = wrap ("%{F" ++ color ++ "}") "%{F-}"
      wrapOpenWorkspaceCmd wsp
        | all isDigit wsp = wrapOnClickCmd ("xdotool key super+" ++ wsp) wsp
        | otherwise = wsp
      wrapOnClickCmd cmd = wrap ("%{A1:" ++ cmd ++ ":}") "%{A}"
      showNamedWorkspaces1 wsId = pad wsId
