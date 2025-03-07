import Data.Time
import Data.Time.Clock.POSIX
import Text.Printf

-- Constants
j2000 :: Double
j2000 = 2451545.0

minneapolisLongitude :: Double
minneapolisLongitude = -93.2639  -- Longitude of Minneapolis in degrees

-- Function to convert degrees to radians
degreesToRadians :: Double -> Double
degreesToRadians d = d * pi / 180

-- Function to calculate the Julian Date
julianDate :: UTCTime -> Double
julianDate (UTCTime (ModifiedJulianDay mjd) _) = fromIntegral mjd + 2400000.5

-- Function to calculate the mean sidereal time (MST)
meanSiderealTime :: UTCTime -> Double
meanSiderealTime utcTime = st_hours
  where
    jd = julianDate utcTime
    t = jd - j2000
    g = 357.52911 + 0.98560028 * t
    g_rad = degreesToRadians g
    mst = 280.46061837 + 360.98564736629 * t + 0.000387933 * t^2 - 0.0000000258 * t^3
    mst_rad = degreesToRadians mst
    st = mst + minneapolisLongitude
    st_hours = st / 15.0

-- Main function to print the sidereal time
main :: IO ()
main = do
  now <- getCurrentTime
  let st = meanSiderealTime now
  putStrLn $ "Sidereal Time in Minneapolis: " ++ printf "%.2f" st ++ " hours"
  let (hours, minutes, seconds) = timeToHMS st
  putStrLn $ "Sidereal Time in Minneapolis: " ++ printf "%02d:%02d:%02d" hours minutes seconds

-- Function to convert time in hours to hh:mm:ss format
timeToHMS :: Double -> (Int, Int, Int)
timeToHMS hours = (hour, minute, second)
  where
    hour = floor hours
    minute = floor ((hours - fromIntegral hour) * 60)
    second = round (((hours - fromIntegral hour) * 60 - fromIntegral minute) * 60)
