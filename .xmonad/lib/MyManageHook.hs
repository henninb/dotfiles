module MyManageHook  
( myManageHook
) where

import XMonad

-- hooks --
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.InsertPosition

-- miscelllanous --
import Control.Monad
import qualified XMonad.StackSet as W

-- own module: configuration decomposition --
import MyWorkspaces

------------------------------------------------------------------------

-- Window Management 

myManageHook = (composeAll . concat $
  [
    [resource  =? r --> doIgnore           | r <- myIgnores    ]

  , [className =? b --> viewShift wsNet    | b <- myBrowser    ]
  , [className =? b --> viewShift wsEdit   | b <- myEditor     ]
  , [className =? b --> viewShift wsPlace  | b <- myPlace      ]
  , [className =? b --> viewShift wsMail   | b <- myMail       ]  
  , [className =? c --> viewShift ws6      | c <- myGfxs       ]
  , [role      =? r --> doShift   ws6      | r <- myFs         ]

  , [name      =? n --> doCenterFloat      | n <- myNames      ]
  , [className =? c --> doCenterFloat      | c <- myFloats     ]
  , [className =? c --> doFullFloat        | c <- myFullFloats ]

  , [isDialog       --> doFocusCenterFloat                     ]
  , [isFullscreen   --> doFullFloat                            ]

  , [insertPosition Below Newer                                ]
  ])

  where
    viewShift = doF . liftM2 (.) W.greedyView W.shift

    role = stringProperty "WM_WINDOW_ROLE"
    name = stringProperty "WM_NAME"

    doFocusCenterFloat = doF W.shiftMaster <+> doF W.swapDown <+> doCenterFloat

    doFocusFullFloat   = doFullFloat

    -- classnames
    myFloats      = ["MPlayer", "Vlc", "Smplayer", "Lxappearance", "XFontSel"]
    myFullFloats  = ["feh", "Mirage", "Zathura", "Mcomix"]
    myGfxs        = ["Inkscape", "Gimp"]

    -- roles
    myFs          = ["ranger_startup"]

    -- resources
    myIgnores = ["desktop", "desktop_window"]
 
    -- names
    myNames   = ["Google Chrome Options", "Chromium Options", "Firefox Preferences"]
  
    -- browser
    myBrowser = ["Midori", "midori4", "Chromium", "Firefox", "Navigator"]
 
    -- editor
    myEditor = ["Geany"]

    -- editor
    myPlace = ["Thunar"]

    -- mail
    myMail = ["Mail", "Thunderbird"]
