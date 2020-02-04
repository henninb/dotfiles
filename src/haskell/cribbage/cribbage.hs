import System.Random
import Data.List

--shuffleDeck n = take n . unfoldr (Just . random)
--deckList = shuffleDeck 52

deck = [0..51]

getShuffledDeck :: Int -> IO([Int])
getShuffledDeck 0 = return []
getShuffledDeck n = do
  r  <- randomRIO (0,51)
  rs <- getShuffledDeck (n-1)
  return (r:rs)

getTopCard = 1

cardRankList = 'A':'2':'3':'4':'5':'6':'7':'8':'9':'T':'J':'Q':'K':[]

cardSuitList = 'H':'D':'C':'S':[]

cardValueList = 1:2:3:4:5:6:7:8:8:10:10:10:10:[]

--let n = runRandom (randR(1, length (deck))) gen :: Int

--n = randR (1, 51 [1..51])

deckLength = length deck

firstCard = deck !! 4 `mod` 4
secondCard = deck !! 5 `mod` 4
thirdCard = deck !! 6 `mod` 4
forthCard = deck !! 7 `mod` 4

listBySuit = [x `mod` 4 | x <- deck]
listByRank = [x `div` 4 + 1 | x <- deck]
--listGetSuit = [x * 4 | x <- [0..51]]
