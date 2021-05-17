module Main where

import Data.Time
import Prelude

startDate :: Day
startDate = fromGregorian 2021 4 24

engineerNumber :: Integer
engineerNumber = 6

nextOncallDay :: Day -> Integer -> IO Day
nextOncallDay prevDay numOfPeople = do
  now <- currDay
  let diff = diffDays now startDate
  let dayCountOne = numOfPeople * 3
  let interval = div diff dayCountOne
  let dayCount = (numOfPeople * 3) + (interval * dayCountOne)
  let futureDate = addDays dayCount prevDay
  return futureDate

currDay :: IO Day
currDay = do localDay . zonedTimeToLocalTime <$> getZonedTime

main :: IO()
main = do
  today <- currDay
  futureDate <- nextOncallDay startDate engineerNumber
  print (diffDays futureDate today)
