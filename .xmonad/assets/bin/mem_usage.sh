#!/bin/bash

MEM_TOTAL=$(free | awk 'FNR == 2 {print $2}')
MEM_USED=$(free | awk 'FNR == 2 {print $3}')
MEM_USED_MUL=$(expr $MEM_USED \* 100)
sleep 1
echo -n $(expr $MEM_USED_MUL / $MEM_TOTAL)
exit 0
