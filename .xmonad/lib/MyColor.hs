module MyColor 
( myColor
) where

-- colorschemes
import Data.Map as M

------------------------------------------------------------------------

-- Dzen2 Bar

-- Reading:
-- http://learnyouahaskell.com/modules

------------------------------------------------------------------------

-- Color names are easier to remember:
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
