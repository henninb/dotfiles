{-# LANGUAGE PatternSynonyms #-}

module Local.Prompts (searchList, myXPConfig', myXPConfigBottom) where

import XMonad
import XMonad.Prompt (XPConfig(..), XP(..), fgColor, position, height, autoComplete, maxComplRows, moveCursor, startOfLine, moveHistory, quit, endOfLine, deleteString, setSuccess, killWord, setDone, mkComplFunFromList', killBefore, killAfter, moveWord, pasteString, pattern Next, pattern Prev, pattern Top, pattern Bottom)
-- import XMonad.Prompt
import XMonad.Prompt.FuzzyMatch (fuzzyMatch)
import Control.Arrow (first)
import Data.Map (Map(..), fromList)
import XMonad.StackSet (focusUp', focusDown')
import XMonad.Actions.Search (SearchEngine(..), stackage, duckduckgo, hoogle, vocabulary, amazon, youtube, wikipedia, wayback, searchEngine, thesaurus, images, google)
import XMonad.Util.Run (runProcessWithInput)
import XMonad.Prompt.Input (inputPromptWithCompl, (?+))

superKeyMask :: KeyMask
superKeyMask = mod4Mask

myFont :: String
myFont = "xft:monofur for Powerline:bold:size=9:antialias=true:hinting=true"

archwiki, ebay, news, reddit, urban :: SearchEngine
archwiki = searchEngine "archwiki" "https://wiki.archlinux.org/index.php?search="
ebay     = searchEngine "ebay" "https://www.ebay.com/sch/i.html?_nkw="
news     = searchEngine "news" "https://news.google.com/search?q="
reddit   = searchEngine "reddit" "https://www.reddit.com/search/?q="
urban    = searchEngine "urban" "https://www.urbandictionary.com/define.php?term="

searchList :: [(String, SearchEngine)]
searchList = [ ("a", archwiki)
    , ("d", duckduckgo)
    , ("e", ebay)
    , ("g", google)
    , ("h", hoogle)
    , ("i", images)
    , ("n", news)
    , ("r", reddit)
    , ("s", stackage)
    , ("t", thesaurus)
    , ("v", vocabulary)
    , ("b", wayback)
    , ("u", urban)
    , ("w", wikipedia)
    , ("y", youtube)
    , ("z", amazon)
  ]

myXPKeymap :: Map (KeyMask,KeySym) (XP ())
myXPKeymap = fromList $
     map (first $ (,) controlMask)   -- control + <key>
     [ (xK_z, killBefore)            -- kill line backwards
     , (xK_k, killAfter)             -- kill line forwards
     , (xK_a, startOfLine)           -- move to the beginning of the line
     , (xK_e, endOfLine)             -- move to the end of the line
     , (xK_m, deleteString Next)     -- delete a character foward
     , (xK_b, moveCursor Prev)       -- move cursor forward
     , (xK_f, moveCursor Next)       -- move cursor backward
     , (xK_BackSpace, killWord Prev) -- kill the previous word
     , (xK_v, pasteString)           -- paste a string
     , (xK_g, quit)                  -- quit out of prompt
     , (xK_bracketleft, quit)
     ]
     ++
     map (first $ (,) superKeyMask)       -- meta key + <key>
     [ (xK_BackSpace, killWord Prev) -- kill the prev word
     , (xK_f, moveWord Next)         -- move a word forward
     , (xK_b, moveWord Prev)         -- move a word backward
     , (xK_d, killWord Next)         -- kill the next word
     , (xK_n, moveHistory focusUp')   -- move up thru history
     , (xK_p, moveHistory focusDown') -- move down thru history
     ]
     ++
     map (first $ (,) 0) -- <key>
     [ (xK_Return, setSuccess True >> setDone True)
     , (xK_KP_Enter, setSuccess True >> setDone True)
     , (xK_BackSpace, deleteString Prev)
     , (xK_Delete, deleteString Next)
     , (xK_Left, moveCursor Prev)
     , (xK_Right, moveCursor Next)
     , (xK_Home, startOfLine)
     , (xK_End, endOfLine)
     , (xK_Down, moveHistory focusUp')
     , (xK_Up, moveHistory focusDown')
     , (xK_Escape, quit)
     ]

myXPConfig :: XPConfig
myXPConfig = def
      { font                = myFont
      , bgColor             = "#292d3e"
      , fgColor             = "#d0d0d0"
      , bgHLight            = "#c792ea"
      , fgHLight            = "#000000"
      , borderColor         = "#535974"
      , promptBorderWidth   = 0
      , promptKeymap        = myXPKeymap
      , position            = Top
      , height              = 20
      , historySize         = 256
      , historyFilter       = id
      , defaultText         = []
      , autoComplete        = Just 100000  -- set Just 100000 for .1 sec
      , showCompletionOnTab = False
      -- , searchPredicate     = isPrefixOf
      , searchPredicate     = fuzzyMatch
      , alwaysHighlight     = True
      , maxComplRows        = Nothing      -- set to Just 5 for 5 rows
      }

myXPConfig' :: XPConfig
myXPConfig' = myXPConfig
      { autoComplete = Nothing
      }

tmuxRun :: IO [String]
tmuxRun = lines <$> runProcessWithInput "tmux" ["list-sessions", "-F", "#{session_name}"] ""

-- tmuxPrompt :: XPConfig -> X ()
-- tmuxPrompt c = io tmuxRun >>= \as -> inputPromptWithCompl c "tmux" (mkComplFunFromList' as) ?+ tmuxStart as

tmuxStart :: [String] -> String -> X ()
tmuxStart ss s = asks (terminal . config) >>= \term -> attachOrCreate term s
 where
   attachOrCreate t s' = spawn $ t ++ " -e tmux new -s " ++ s' ++ " -A"

myXPConfigBottom :: XPConfig
myXPConfigBottom = def
    {
      font = myFont
    , bgColor = "#000000"
    , borderColor = "#000000"
    , fgColor = "#E6E6FA"
    , position = Bottom
    , height = 28
    , autoComplete = Nothing
    }
