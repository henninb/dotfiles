#!/usr/bin/env bash

SLEEP=2

#cblue="^fg(#92bbd0)"
cgray="^fg(#999999)"
cwhite="^fg(#ffffff)"
cnormal="^fg(#dddddd)"
cred="^fg(#bc4547)"
cyellow="^fg(#a88c29)"
cgreen="^fg(#00aa6c)"
#cpurple="^fg(#9542f4)"

fs_icon="^i($HOME/.xmonad/assets/icons/diskette.xbm)"
cpu_icon="^i($HOME/.xmonad/assets/icons/cpu.xbm)"
mem_icon="^i($HOME/.xmonad/assets/icons/mem.xbm)"

sunny="^i($HOME/.xmonad/assets/icons/sunny.xbm)"
rainny="^i($HOME/.xmonad/assets/icons/rainny.xbm)"
snowy="^i($HOME/.xmonad/assets/icons/snowy.xbm)"
stormydaniels="^i($HOME/.xmonad/assets/icons/stormydaniels.xbm)"
cloudy="^i($HOME/.xmonad/assets/icons/cloudy.xbm)"
#partially="^i($HOME/.xmonad/assets/icons/partially.xbm)"
foggy="^i($HOME/.xmonad/assets/icons/fog.xbm)"
sunny="^i($HOME/.xmonad/assets/icons/sunny.xbm)"

function wrapper {
  if [ "$1" -eq 0 ]; then
    echo "000${cwhite}"
  elif [ ${#1} -ge 3 ]; then
    echo "${cwhite}$1"
  else
    echo "$(printf "%02d" "$1" | sed "s/\(^0\+\)/\1${cwhite}/")"
  fi
}

function colorcho {
  if [ "$1" -ge 0 ] && [ "$1" -lt 50 ]; then
    echo "${cgreen}"
  elif [ "$1" -ge 50 ] && [ "$1" -lt 75 ]; then
    echo "${cyellow}"
  elif [ "$1" -ge 75 ] && [ "$1" -le 100 ]; then
    echo "${cred}"
  elif [ "$1" -eq 101 ]; then
    echo "${cwhite}"
  fi
}

# cpu
PREV_TOTAL=0
PREV_IDLE=0

temper=$(curl -s wttr.in/Minneapolis?lang=es | sed -n 4p | sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" | perl -nE 'say/([0-9]+)+|([0-9]+)+-+([0-9]+)/' )
forecast=$(curl -s wttr.in/Minneapolis?lang=es | sed -n 3p | sed 's/\x1B\[[0-9;]\+[A-Za-z]//g'| sed -e 's/[\"\\\/_..()\*-]//g' | awk '{print $1 " " $2}' | sed -e 's/-//')

case $(echo $forecast | awk '{print $1}') in
 Soleado)
 weaicon="${cyellow}${sunny}"
 ;;
 Cielo)
 weaicon="${cgray}${cloudy}"
 ;;
 Parcialmente)
 weaicon="${cyellow}${sunny}${cgray}${cloudy}"
 ;;
 Niebla)
 weaicon="${cgray}${foggy}"
 ;;
 Neblina)
 weaicon="${cgray}${foggy}"
 ;;
 Despejado)
 weaicon="${cyellow}${sunny}"
 ;;
 Lluvia)
 weaicon="${cgray}${rainny}"
 ;;
 Tormenta)
 weaicon="${cwhite}${stormydaniels}"
 ;;
 Nieve)
 weaicon="${cwhite}${snowy}"
 ;;
esac

while :; do

root_used=$(df / | grep -Eo '[0-9]+%' | sed s/%//)
data_total=$(free | sed -n 3p | awk '{print $2}')
data_used=$(free | sed -n 3p | awk '{print $3}')
data_percent=$(($data_used * 100))
if [ "$data_used" == "0" ]; then
  data_used=1
fi
data_percent=$(($data_percent / $data_total))
storage_used=$(df /dev/sda2 | grep -Eo '[0-9]+%' | sed s/%//)
homesize=$(sudo du -hs $HOME | awk '{print $1}' | sed s/[A-Z]//)

root="$(colorcho $root_used)${fs_icon} ${cgray}ROOT $(wrapper $root_used)%"
# data="$(colorcho $data_percent)${fs_icon} ${cgray}SWAP $(wrapper $data_percent)%"
# storage="$(colorcho $storage_used)${fs_icon} ${cgray}BOOT $(wrapper $storage_used)%"
home="${color_sec1}${fs_icon} /home ${color_sec2}$(wrapper $homesize)G"

# cpu
CPU=$(cat /proc/stat | grep '^cpu ')
unset CPU[0]                          # Discard the "cpu" prefix.
IDLE=${CPU[4]}                        # Get the idle CPU time.
# top -b -n 1

# Calculate the total CPU time.
TOTAL=0
for VALUE in "${CPU[@]}"; do
  TOTAL="$TOTAL+$VALUE"
done

# Calculate the CPU usage since we last checked.
DIFF_IDLE="$IDLE-$PREV_IDLE"
DIFF_TOTAL="$TOTAL-$PREV_TOTAL"
DIFF_USAGE="(1000*($DIFF_TOTAL-$DIFF_IDLE)/$DIFF_TOTAL+5)/10"

# Remember the total and idle CPU times for the next check.
PREV_TOTAL="$TOTAL"
PREV_IDLE="$IDLE"

cpu="$(colorcho $DIFF_USAGE)${cpu_icon}${cgray} $(wrapper ${DIFF_USAGE})%"

memory_total=$(free -m | awk 'FNR == 2 {print $2}')
memory_used=$(free -m | awk 'FNR == 2 {print $3}')
memory_free_percent=$[$memory_used * 100 / $memory_total]
mem="$(colorcho $memory_free_percent)${mem_icon}${cgray} $(wrapper ${memory_free_percent})%"

echo -e "${weaicon}${cnormal} ${temper}f${cnormal} | $cpu | $mem | ${cgray} | $root | $home"

sleep $SLEEP; done
n
