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

    io $ appendFile "/tmp/.xmonad-title-log" (title ++ "\n")
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
    , ppCurrent = wrap ("%{B" ++ "#400473" ++ "}" ++ "%{F" ++ "#FF69B4" ++ "}") " %{B- F-}" . wrap "[" "]" -- hotpink foreground, could try ff1d8e
    -- , ppCurrent = wrap ("%{B" ++ "#008000" ++ "}" ++ "%{F" ++ "#FF69B4" ++ "}") " %{B- F-}" . wrap "[" "]" -- hotpink foreground, could try ff1d8e --background green
    -- , ppCurrent = wrap ("%{B" ++ "#343434" ++ "}" ++ "%{F" ++ "#FF69B4" ++ "}") " %{B- F-}" . wrap "[" "]" -- hotpink foreground, could try ff1d8e
    , ppVisible = wrap ("%{F" ++ "#FF1493" ++ "} ") " %{F-}"
    -- , ppHiddenNoWindows = wrap ("%{F" ++ "#928374" ++ "} ") " %{F-}" --lightgrey foreground
    -- , ppHiddenNoWindows = id
    -- , ppUrgent = wrap ("%{F" ++ "#FF0000" ++ "} ") " %{F-}"  --red foreground
    , ppUrgent = withFG red
    -- , ppHidden = wrap " " "
    -- , ppHidden = withFG gray . withMargin . withFont 5 . (`wrapClickableWorkspace` "__hidden__")
    -- , ppHidden = withFG gray . withMargin . withFont 5 . (`wrapClickableWorkspace` showNamedWorkspaces id)
    , ppHidden = wrap "<" ">" . unwords . map wrapOpenWorkspaceCmd . words
    , ppHiddenNoWindows = withFG gray . wrap "{" "}" . unwords . map wrapOpenWorkspaceCmd . words
    -- , ppHiddenNoWindows  = withFG gray . withMargin . withFont 5 . (`wrapClickableWorkspace` "__empty__")"
    , ppOrder = \(workSpace:l:t:ex) -> [workSpace,l]++ex++[t]
    , ppWsSep = (withFG gray . withMargin) ":"
    , ppSep = (withFG gray . withMargin) "|"
    , ppTitle = myAddSpaces 25
    , ppExtras = [currentWorkSpace]
    }    where
      withMargin = wrap " " " "
      withFont fNum = wrap ("%{T" ++ show (fNum :: Int) ++ "}") "%{T}"
      withBG color = wrap ("%{B" ++ color ++ "}") "%{B-}"
      withFG color = wrap ("%{F" ++ color ++ "}") "%{F-}"
      --wrapOnClickCmd command     = wrap ("%{A1:" ++ command ++ ":}") "%{A}"
      -- wrapClickableWorkspace wsp = wrapOnClickCmd ("xdotool key super+" ++ wsp)
      wrapOpenWorkspaceCmd wsp
        | all isDigit wsp = wrapOnClickCmd ("xdotool key super+" ++ wsp) wsp
        | otherwise = wsp
      wrapOnClickCmd cmd = wrap ("%{A1:" ++ cmd ++ ":}") "%{A}"
      showNamedWorkspaces1 wsId = pad wsId
