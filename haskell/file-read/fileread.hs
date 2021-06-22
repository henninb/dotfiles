import System.IO
import Control.Monad
import Data.List.Split (splitOn)
import Data.Char (isSpace)
import Data.List (isPrefixOf)
-- import Data.Text

-- mySplit :: [Char] -> [[Char]]


-- readLinesFromFile filename = do
--   handle <- openFile filename ReadMode
--   contents <- hGetContents handle
--   return $ readLines contents
trim :: String -> String
trim = reverse . dropWhile isSpace . reverse . dropWhile isSpace

remove :: String -> String -> String
remove w "" = ""
remove w s@(c:cs)
  | w `isPrefixOf` s = remove w (drop (length w) s)
  | otherwise = c : remove w cs

main = do
  handle <- openFile "file.txt" ReadMode
  contents <- hGetContents handle
  -- let songs = lines contents

  let toTup [artist, track] = (trim artist, remove ".mp3" (trim track))
  let mySongs = toTup . splitOn "-" <$> lines contents
  -- let songs = splitOn "\n" contents
  -- mapM_ putStr songs
  -- let x = (map read . splitOn "-") $ lines contents
  -- let y = (map (map read . splitOn ",") $ lines contents :: String)
  -- mapM_ print songs
  mapM_ print mySongs
  print (length mySongs)
  hClose handle
