module Local.MouseBinding (myMouseBindings) where

import XMonad
-- import qualified Data.Map as M
import Data.Map (Map(..), fromList)
-- import qualified XMonad.StackSet as W
import XMonad.StackSet (shiftMaster)

myMouseBindings :: XConfig l -> Map (KeyMask, Button) (Window -> X ())
myMouseBindings XConfig {XMonad.modMask = modm} = fromList
    [
--     -- mod-button1, Set the window to floating mode and move by dragging
     ((modm, button1),
   \ w -> focus w >> mouseMoveWindow w >> windows shiftMaster),
--     -- mod-button2, Raise the window to the top of the stack
     ((modm, button2), \ w -> focus w >> windows shiftMaster),
--     -- mod-button3, Set the window to floating mode and resize by dragging
      ((modm, button3),
   \ w -> focus w >> mouseResizeWindow w >> windows shiftMaster)
    ]
