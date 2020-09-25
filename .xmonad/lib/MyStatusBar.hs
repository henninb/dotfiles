module MyStatusBar
( csbdTopCenter
, csbdTopBackground
, csbdTopLeft
, csbdTopRight
, csbdBottomBackground
, csbdBottomLeft
, csbdBottomCenter
, csbdBottomRight
) where

-- csbd = Call Status Bar DZen2

-- own module: configuration decomposition --
import MyColor

------------------------------------------------------------------------

-- Dzen2 Bar

-- Reading:
-- https://github.com/robm/dzen

-- Inspired by
-- https://github.com/harukachan/dotfiles/tree/master/unminimalVarokah

------------------------------------------------------------------------

fgColor = myColor "Foreground"
bgColor = myColor "Background"
dcColor = myColor "Decoration"
spColor = myColor "Separator"

screenWidth = "1280"

font1 = "awesome-9"
font2 = "profont-9"
font3 = "Droid Sans Fallback-9:bold"
font4 = "takaopgothic-9"             -- debian

dzenArgs = " -p -e 'button3=' -fn '"++font1++"' "
dzenColors = " -fg '"++fgColor++"' -bg '"++bgColor++"' "

csbdTopBackground = "echo '^fg("++dcColor++")^p(;-10)^r("++screenWidth++"x5)' |"
    ++ " dzen2 -ta c -h 35 -w "++screenWidth++" "
    ++ dzenArgs ++ dzenColors

csbdTopLeftScript = "\
 \  echo -n '^fg("++dcColor++")\
    \^i(.xmonad/assets/deco/mt1.xbm)^fg()  ';\
 \  echo -n ' ^fg("++dcColor++")\
    \^i(.xmonad/assets/deco/arrow.xbm)^fg()';\
 \  echo -n '^bg("++dcColor++")  ';\
 \  echo -n '^fg("++spColor++"):: ^fg()';\
 \  echo -n '^bg()';\
 \  echo -n '^fg("++dcColor++")\
    \^i(.xmonad/assets/deco/arrow_rev.xbm)^fg()';\
 \  echo ;"

csbdTopLeft = "sleep 0.5 && "
    ++ " while sleep 1; do"
    ++   csbdTopLeftScript
    ++ " done"
    ++ " |" -- pipe
    ++ " dzen2 -ta l -h 21 -y 4 -w 350 -x 0 "
    ++ dzenArgs ++ dzenColors

scriptCPU = "\
 \  echo -n '^fg("++spColor++") :: ^fg()\
    \^i(.xmonad/assets/monitor/cpu.xbm) ';\
 \  sh ~/.xmonad/assets/bin/chunk_cpu_usage.sh;"

scriptMem = "\
 \  echo -n '^fg("++spColor++"):: ^fg()\
    \^i(.xmonad/assets/monitor/mem.xbm) ';\
 \  sh ~/.xmonad/assets/bin/chunk_cpu_usage.sh;"

csbdTopRightScript = "\
 \  echo -n '^fg("++dcColor++")\
    \^i(.xmonad/assets/deco/arrow.xbm)^fg()';\
 \  echo -n '^bg("++dcColor++")';\
 \ "++ scriptCPU ++"\
 \  echo -n '^bg()';\
 \  echo -n '^fg("++dcColor++")\
    \^i(.xmonad/assets/deco/arrow_rev.xbm)^fg()';\
 \ "++ scriptMem ++"\
 \  echo -n ' ^fg("++dcColor++")\
    \^i(.xmonad/assets/deco/mt2.xbm)^fg()';\
 \  echo ;"

csbdTopRight = "sleep 0.5 && "
    ++ " while sleep 1; do"
    ++   csbdTopRightScript
    ++ " done"
    ++ " |" -- pipe
    ++ " dzen2 -ta r -h 21 -y 4 -w 350 -x -350 "
    ++ dzenArgs ++ dzenColors


csbdTopCenterScript = "\
 \  echo -n '^fg("++spColor++")';\
 \  echo ;"

csbdTopCenter = "sleep 0.5 && "
    ++ " while sleep 1; do"
    ++   csbdTopCenterScript
    ++ " done"
    ++ " |" -- pipe
    ++ " dzen2 -ta c -h 18 -x 0 -y 4 "
    ++ " -w `expr "++screenWidth++" - 600` -x 300 "
    ++ dzenArgs ++ dzenColors

csbdBottomBackground = ""
    ++ "echo '^fg("++dcColor++")^p(;21)^r("++screenWidth++"x5)' |"
    ++ " dzen2 -ta c -h 35 -y -35 -w "++screenWidth++" "
    ++ dzenArgs ++ dzenColors

csbdBottomLeft = "sleep 1; "
    ++ " dzen2 -ta l -h 25 -y -30 "
    ++ " -w `expr "++screenWidth++" / 2` "
    ++ dzenArgs ++ dzenColors

scriptClock = "\
 \  echo -n '^i(.xmonad/assets/monitor/clock.xbm) ';\
 \  echo -n $(date +'%a %b %d %H:%M');"

csbdBottomRightScript = "\
 \  echo -n '^fg("++dcColor++")\
    \^i(.xmonad/assets/deco/mr2.xbm)^fg()^bg("++dcColor++")';\
 \ "++ scriptClock ++"\
 \  echo -n '     ^bg()';\
 \  echo;"

csbdBottomRight = "sleep 1.5 && "
    ++ " while sleep 1; do"
    ++   csbdBottomRightScript
    ++ " done"
    ++ " |" -- pipe
    ++ " dzen2 -ta r -h 25 -y -30 -w 200 -x -200 "
    ++ dzenArgs ++ dzenColors

csbdBottomCenter = "sleep 2; "
    ++ " dzen2 -ta c -h 20 -y -25 "
--  ++ " -w 500 -x `expr "++screenWidth++" / 2 - 250` "
--    ++ " -w 450 -x `expr "++screenWidth++" / 2 - 150` " --  1280 or 1024
    ++ " -w 675 -x `expr "++screenWidth++" / 2 - 150` " --  1280 or 1024
    ++ dzenArgs ++ dzenColors

--    test your color
--    ++ " -fg '#afafaf' -bg '#6d6d6d' "

