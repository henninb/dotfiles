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

------------------------------------------------------------------------
-- Top

csbdTopBackground = "echo '^fg("++dcColor++")^p(;-10)^r("++screenWidth++"x5)' |"
    ++ " dzen2 -ta c -h 35 -w "++screenWidth++" "
    ++ dzenArgs ++ dzenColors

------------------------------------------------------------------------

scriptSSID = "\
 \  WIFI=$(iw dev | grep Interface | awk '{print $2}');\
 \  if [ \"$WIFI\" ]; then \
 \    SSID=$(iw dev $WIFI link | grep SSID: | awk '{print $2}');\
 \    echo -n '^i(.xmonad/assets/monitor/wireless.xbm) ';\
 \    echo -n $SSID;\
 \  fi; "

csbdTopLeftScript = "\
 \  echo -n '^fg("++dcColor++")\
    \^i(.xmonad/assets/deco/mt1.xbm)^fg()  ';\
 \ "++ scriptSSID ++"\
 \  echo -n ' ^fg("++dcColor++")\
    \^i(.xmonad/assets/deco/arrow.xbm)^fg()';\
 \  echo -n '^bg("++dcColor++")  ';\
 \  echo -n '^fg("++spColor++"):: ^fg()';\
 \  sh ~/.xmonad/assets/bin/chunk_net_speed.sh;\
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

------------------------------------------------------------------------

scriptCPU = "\
 \  echo -n '^fg("++spColor++") :: ^fg()\
    \^i(.xmonad/assets/monitor/cpu.xbm) ';\
 \  sh ~/.xmonad/assets/bin/chunk_cpu_usage.sh;"

scriptMem = "\
 \  echo -n '^fg("++spColor++"):: ^fg()\
    \^i(.xmonad/assets/monitor/mem.xbm) ';\
 \  mem_total=$(free | awk 'FNR == 2 {print $2}');\
 \  mem_used=$(free | awk 'FNR == 2 {print $3}');\
 \  echo -n $[$mem_used * 100 / $mem_total];"

scriptPac = "\
 \  echo -n '^fg("++spColor++")\
    \^ca(1, .xmonad/assets/bin/pacshow)';\
 \  echo -n '^fg("++spColor++") :: ^fg()\
    \^i(.xmonad/assets/monitor/pacman.xbm) ';\
 \  echo -n `pacman -Qu | wc -l`;\
 \  echo -n '^ca()^fg()';"

scriptDiskUsage = "\
 \  echo -n ':: ';\
 \  echo -n '^i(.xmonad/assets/monitor/diskette.xbm) ';\
 \  DISK=$(df /home -h | awk  'FNR == 2 {print $5}' | sed s/%//);\
 \  if [[ $DISK -gt 90 ]]; \
 \  then FORE='red'; \
 \  else FORE='#cccccc'; \
 \  fi; \
 \  echo -n $(echo $DISK | gdbar -bg '"++spColor++"' -fg $FORE -h 3 -w 60);"

csbdTopRightScript = "\
 \  echo -n '^fg("++dcColor++")\
    \^i(.xmonad/assets/deco/arrow.xbm)^fg()';\
 \  echo -n '^bg("++dcColor++")';\
 \ "++ scriptCPU ++"\
 \ "++ scriptMem ++"\
 \ "++ scriptPac ++"\
 \  echo -n '^bg()';\
 \  echo -n '^fg("++dcColor++")\
    \^i(.xmonad/assets/deco/arrow_rev.xbm)^fg()';\
 \ "++ scriptDiskUsage ++"\
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

------------------------------------------------------------------------

scriptMPD = "\
 \  MPDSTAT=$(mpc status | grep playing);\
 \  if [ \"$MPDSTAT\" ]; then \
 \  echo -n '^fg(#91ba0d)^i(.xmonad/assets/monitor/music.xbm) ^fg()';\
 \  echo -n $(mpc --format %artist% | head -n 1);\
 \  echo -n '^fg(#91ba0d) | ^fg()';\
 \  echo -n $(mpc --format %title% | head -n 1);\
 \  fi; "

scriptAlsa = "\
 \  echo -n '^ca()';\
 \  echo -n '^ca(3, amixer -q set Master toggle)';\
 \  echo -n '^ca(4, amixer -q set Master 5%+ unmute)';\
 \  echo -n '^ca(5, amixer -q set Master 5%- unmute)';\
 \  echo -n ' :: ';\
 \ \
 \  AVOL=$(amixer get Master | awk 'END{print $5}' | sed -E 's/\\[|\\]|%//g');\
 \  ASTATUS=$(amixer get Master | awk 'END{print $6}' | sed -E 's/\\[|\\]//g');\
 \  if [[ $ASTATUS = 'on' ]]; \
 \  then \
 \    echo -n '^i(.xmonad/assets/monitor/spkr_01.xbm) ';\
 \    echo -n $(echo $AVOL | gdbar -bg '"++spColor++"' -fg '#d6d6d6' -h 3 -w 60);\
 \  else \
 \    echo -n '^i(.xmonad/assets/monitor/spkr_02.xbm) ';\
 \    echo -n $(echo 0 | gdbar -bg '"++spColor++"' -fg '#d6d6d6' -h 3 -w 60);\
 \  fi; \
 \ \
 \  echo -n '^ca()^ca()^ca()^ca()^fg()';"

csbdTopCenterScript = "\
 \  echo -n '^fg("++spColor++")';\
 \ "++ scriptMPD ++"\
 \ "++ scriptAlsa ++"\
 \  echo ;"

csbdTopCenter = "sleep 0.5 && "
    ++ " while sleep 1; do"
    ++   csbdTopCenterScript
    ++ " done"
    ++ " |" -- pipe
    ++ " dzen2 -ta c -h 18 -x 0 -y 4 "
    ++ " -w `expr "++screenWidth++" - 600` -x 300 "
    ++ dzenArgs ++ dzenColors

------------------------------------------------------------------------
-- Bottom

csbdBottomBackground = ""
    ++ "echo '^fg("++dcColor++")^p(;21)^r("++screenWidth++"x5)' |"
    ++ " dzen2 -ta c -h 35 -y -35 -w "++screenWidth++" "
    ++ dzenArgs ++ dzenColors

------------------------------------------------------------------------

csbdBottomLeft = "sleep 1; "
    ++ " dzen2 -ta l -h 25 -y -30 "
    ++ " -w `expr "++screenWidth++" / 2` "
    ++ dzenArgs ++ dzenColors

------------------------------------------------------------------------

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

------------------------------------------------------------------------

csbdBottomCenter = "sleep 2; "
    ++ " dzen2 -ta c -h 20 -y -25 "
--  ++ " -w 500 -x `expr "++screenWidth++" / 2 - 250` "
    ++ " -w 450 -x `expr "++screenWidth++" / 2 - 150` " --  1280 or 1024
    ++ dzenArgs ++ dzenColors

--    test your color
--    ++ " -fg '#afafaf' -bg '#6d6d6d' "


