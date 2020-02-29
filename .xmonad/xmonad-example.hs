import System.IO
import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Layout.BoringWindows
import XMonad.Layout.Minimize
import XMonad.Layout.NoBorders
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Run(spawnPipe)


-- Colors and Borders
xmobarTitleColor = "#FFB6B0" -- Current window title
xmobarCurrentWorkspaceColor = "#CEFFAC"  -- Current workspace

defaults = def {
    modMask = mod1Mask, -- use the Windows button as mod
    terminal = "urxvt",
    manageHook = composeAll [
                            className =? "mpv" --> doFloat,
                            className =? "obs" --> doShift "9",
                            manageDocks,
                            isFullscreen --> doFullFloat,
                            manageHook def],
    layoutHook = avoidStruts $ smartBorders $ minimize $ boringWindows $ layoutHook desktopConfig,
    handleEventHook = handleEventHook def <+> XMonad.Hooks.EwmhDesktops.fullscreenEventHook,
    startupHook = setWMName "LG3D"
} `additionalKeys` myKeys

myKeys = [
            ((mod1Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
        , ((mod1Mask .|. shiftMask, xK_p), spawn "dmenu_run -nb orange -nf '#444' -sb yellow -sf black -fn Monospace-9:normal")
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
        , ((mod1Mask, xK_i), spawn "firefox")
        , ((mod1Mask, xK_n), spawn "standard-notes")
        , ((mod1Mask .|. shiftMask, xK_i), spawn ("firefox" ++ " -private-window"))
--        , ((mod1Mask, xK_Return), spawn "termite")
        , ((mod1Mask, xK_Return), spawn "alacritty")
        , ((mod1Mask .|. shiftMask, xK_Return), spawn "urxvt")
        --, ((mod1Mask .|. shiftMask, xK_BackSpace), kill)
        , ((mod1Mask .|. shiftMask, xK_BackSpace), kill)
        , ((mod1Mask,               xK_space ), sendMessage NextLayout)
          -- ((mod1Mask, xK_m), withFocused minimizeWindow),
          -- ((mod1Mask .|. shiftMask, xK_m), sendMessage RestoreNextMinimizedWin),
          -- ((mod1Mask, xK_apostrophe), sendMessage ToggleStruts),
          -- ((mod1Mask, xK_Tab), focusDown),
          -- ((mod1Mask .|. shiftMask, xK_Tab), focusUp),
          -- ((mod1Mask .|. controlMask, xK_p), spawn "passmenu"),
          -- ((mod1Mask .|. shiftMask, xK_p), spawn "~/Projects/pa-client/input.py"),
          -- ((mod1Mask, xK_w), spawn "~/Projects/wall-changer/main.py"),
          -- ((mod1Mask .|. shiftMask, xK_w), spawn "~/Projects/wall-changer/main.py -c"),
          -- ((mod1Mask, xK_n), spawn "touch ~/.pomodoro_session"),
          -- ((mod1Mask .|. shiftMask, xK_n), spawn "rm ~/.pomodoro_session")
         ]

main = do
    --xmproc <- spawnPipe "xmobar /home/henninb/.config/xmobar/xmobarrc"
    xmproc <- spawnPipe "xmobar ~/.xmonad/xmobar.hs"
    xmonad . docks $ ewmh $ defaults {
      logHook =  dynamicLogWithPP $
        --defaultPP{ppOutput = System.IO.hPutStrLn xmproc,
        def{ppOutput = System.IO.hPutStrLn xmproc,
            ppTitle = xmobarColor xmobarTitleColor "" . shorten 100,
            ppCurrent =
              xmobarColor xmobarCurrentWorkspaceColor "" . wrap "[" "]",
            ppSep = "   ", ppWsSep = " ",
            ppLayout =
              \ x ->
                case x of
                    "Spacing 6 Mosaic" -> "[:]"
                    "Spacing 6 Mirror Tall" -> "[M]"
                    "Spacing 6 Hinted Tabbed Simplest" -> "[T]"
                    "Spacing 6 Full" -> "[ ]"
                    _ -> x,
            ppHiddenNoWindows = showNamedWorkspaces}
      -- defaultPP {
      --       ppOutput = System.IO.hPutStrLn xmproc
      --     , ppTitle = xmobarColor xmobarTitleColor "" . shorten 100
      --     , ppCurrent = xmobarColor xmobarCurrentWorkspaceColor "" . wrap "[" "]"
      --     , ppSep = "   "
      --     , ppWsSep = " "
      --     , ppLayout  = (\ x -> case x of
      --         "Spacing 6 Mosaic"                      -> "[:]"
      --         "Spacing 6 Mirror Tall"                 -> "[M]"
      --         "Spacing 6 Hinted Tabbed Simplest"      -> "[T]"
      --         "Spacing 6 Full"                        -> "[ ]"
      --         _                                       -> x )
      --     , ppHiddenNoWindows = showNamedWorkspaces
      -- }
} where showNamedWorkspaces wsId = if any (`elem` wsId) ['a'..'z']
                                       then pad wsId
                                       else ""
