fizzBuzzOne :: (Show a, Integral a) => a -> String
fizzBuzzOne i | i `mod` 3 == 0 && i `mod` 5 == 0 = "fizzbuzz"
fizzBuzzOne i | i `mod` 5 == 0 = "buzz"
fizzBuzzOne i | i `mod` 3 == 0 = "fizz"
fizzBuzzOne i = show i

fizzBuzz :: (Show a, Integral a) => [a] -> [String]
fizzBuzz xs = map fizzBuzzOne xs
-- fizzBuzz [] = []
-- fizzBuzz (x:xs) = fizzBuzzOne x : fizzBuzz xs

--main = putStrLn "hello world"
main :: IO()
main = putStrLn $ unlines $ fizzBuzz [1..100]
