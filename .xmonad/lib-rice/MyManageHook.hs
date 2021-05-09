module MyManageHook
( myManageHook
) where

import XMonad

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.InsertPosition
import Control.Monad
import qualified XMonad.StackSet as W

import MyWorkspaces

myManageHook = composeAll . concat $
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
  , [title =? "Outlast" --> doFullFloat                        ]
  , [title =? "Palth of Exile" --> doFullFloat                 ]
  , [title =? "IntelliJ IDEA" --> doFullFloat                  ]

  , [insertPosition Below Newer                                ]
  ]

  where
    viewShift = doF . liftM2 (.) W.greedyView W.shift
    role = stringProperty "WM_WINDOW_ROLE"
    name = stringProperty "WM_NAME"
    doFocusCenterFloat = doF W.shiftMaster <+> doF W.swapDown <+> doCenterFloat
    doFocusFullFloat = doFullFloat
    myFloats      = ["Vlc"]
    myFullFloats  = ["feh", "intellij"]
    myGfxs        = ["Inkscape", "Gimp"]
    myFs          = ["ranger_startup"]
    myIgnores = ["desktop", "desktop_window"]
    myNames   = ["Google Chrome Options", "Chromium Options", "Firefox Preferences"]
    myBrowser = ["Firefox"]
    myEditor = ["Geany"]
    myPlace = ["Thunar"]
    myMail = ["Thunderbird"]
