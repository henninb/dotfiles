import           XMonad.Util.XUtils
import           XMonad
import           XMonad.Core
import           XMonad.Config.Prime
import           XMonad.Util.Font
import           XMonad.StackSet               as W
import           FileLogger
import           Control.Monad
import           Data.List
import Foreign.C.String

workspacesGrouped :: X [(WorkspaceId, [String])]
workspacesGrouped = do
  ws <- gets windowset
  let x = map (W.workspace) (W.current ws : W.visible ws)
  let y = (W.hidden ws)
  sequence $ fmap (\v -> fmap ((,) $ W.tag v) (getWorkspaceWindowTitles v)) $ x ++ y


getWorkspaceWindowTitles :: Workspace i l Window -> X [String]
getWorkspaceWindowTitles w = do
  withDisplay $ \d ->
    (liftIO $ forM
      (integrate' $ stack w)
      (\z -> getWindowTitle z d)
    )

getWindowTitle :: Window -> Display -> IO String
getWindowTitle w d = getTextProperty d w wM_NAME >>= (peekCString . tp_value)
