module Local.Colors (myBorderColor, red, myFocusBorderColor, gray, purple, aqua, lightpink, lightgray, hotpink, darkpurple, white) where

import XMonad
import Data.Map as M

myBorderColor :: String
myBorderColor = "#282828"

almostBlack :: String
almostBlack = "#282828"


lightpurple :: String
lightpurple = "#5B51C9"

myFocusBorderColor :: String
myFocusBorderColor = lightpurple

red :: String
red = "#FB4934"

gray :: String
gray = "#888974"

purple :: String
purple = "#D3869B"

aqua :: String
aqua = "#8EC07C"

lightpink :: String
lightpink = "#FF69B4"

lightgray :: String
lightgray = "#928374"

hotpink :: String
hotpink = "#FF1493"

darkpurple :: String
darkpurple = "#400473"

white :: String
white = "#FFFFFF"

colorSchemes =
    [("Orange",       "#FD971F")
    ,("DarkGray",     "#1B1D1E")
    ,("Pink",         "#F92672")
    ,("NormalBorder", "#CCCCC6")
    ,("FocusedBorder","#fd971f")
    ,("Black",        "#121212")
    ,("Red",          "#c90c25")

    ,("Green",        "#2a5b6a")
    ,("Yellow",       "#c9c925")
    ,("Blue",         "#5c5dad")
    ,("Magenta",      "#6f4484")
    ,("Cyan",         "#2B7694")
    ,("White",        "#D6D6D6")
    ,("PureBlack",    "#000000")
    ,("PureWhite",    "#FFFFFF")

    ,("Foreground",   "#efefef")
    ,("Background",   "#2d2d2d")
    ,("Separator",    "#393939")
    ,("RedHaruka",    "#c90c25")
    ,("BlueUnknown",  "#5c5dad")
    ,("Decoration",   "#2980b9")
    ]

myColor key = M.findWithDefault "#ffffff" key (fromList colorSchemes)
