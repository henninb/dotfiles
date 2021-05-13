togglevga = do { screencount <- LIS.countScreens
    ; if screencount > 1
       then do
      let screenWidth = "1280"
      spawn "xrandr --output LVDS-0 --off --output HDMI-0 --auto"
      return screenWidth
       else do
      let screenWidth = "683"
      spawn "xrandr --output LVDS-0 --auto"
      return screenWidth
    ;}
