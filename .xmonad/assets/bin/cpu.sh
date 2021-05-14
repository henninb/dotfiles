#!/bin/sh


#TODO: unlikely this works

# cpu
CPU=(`cat /proc/stat | grep '^cpu '`) # Get the total CPU statistics.
unset CPU[0]                          # Discard the "cpu" prefix.
IDLE=${CPU[4]}                        # Get the idle CPU time.

# Calculate the total CPU time.
TOTAL=0
for VALUE in "${CPU[@]}"; do
  let "TOTAL=$TOTAL+$VALUE"
done

DIFF_IDLE="$IDLE-$PREV_IDLE"
DIFF_TOTAL="$TOTAL-$PREV_TOTAL"
DIFF_USAGE="$(calc 1000*($DIFF_TOTAL-$DIFF_IDLE)/$DIFF_TOTAL+5)/10"

PREV_TOTAL="$TOTAL"
PREV_IDLE="$IDLE"

cpu="$DIFF_USAGE "
echo "$DIFF_USAGE"

exit 0
