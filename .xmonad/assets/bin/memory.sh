#!/bin/sh

# MEM_TOTAL=$(free | awk 'FNR == 2 {print $2}')
# MEM_USED=$(free | awk 'FNR == 2 {print $3}')
# MEM_USED_MUL=$(expr $MEM_USED \* 100)
# sleep 1
# echo -n $(expr $MEM_USED_MUL / $MEM_TOTAL)


#mem=$(free | awk '/Mem/ {printf "%dM/%dM\n", $3 / 1024.0, $2 / 1024.0 }')
#echo -e "MEM: $mem"
mem_total="$(free | awk 'FNR == 2 {print $2}')"
mem_used="$(free | awk 'FNR == 2 {print $3}')"
mem_used_mul="$(expr $mem_used \* 100)"

echo "$(expr "$mem_used_mul" / "$mem_total")%"

exit 0
