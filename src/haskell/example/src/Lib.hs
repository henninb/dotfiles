module Lib
    ( someFunc, helloFunc
    ) where

data Transaction = Transaction Integer String Integer String String Integer String String Double Int
  deriving Show


transaction = Transaction 1 "guid" 1 "credit" "chase_brian" 1 "aliexpress.com" "none" 12.51 1

someFunc :: IO ()
someFunc = print $ show transaction

helloFunc :: IO ()
helloFunc = putStrLn "hello world"
