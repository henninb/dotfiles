#!/bin/sh

# input file example
# dir | name | unique_id

for i in $(cat f.txt); do
  new_name=$(echo "$i" | awk -F '|' '{print $2}')
  uid=$(echo "$i" | awk -F '|' '{print $3}')
  dir=$(echo "$i" | awk -F '|' '{print $1}')
  pass=$(lpass show --password "$uid")
  # pass add "new_name"
  echo "$pass" | pass insert -m "$new_name"
  #if [ -z "$dir" ]; then
  #  #echo "$dir | $uid"2>&1 | tee -a lpass-update-$$.log
  #  echo > /dev/null
  #else
  #  echo "$dir | $uid"2>&1 | tee -a lpass-update-$$.log
  #  lpass mv "$uid" "$dir"
  #fi
  #echo "$new_name | $uid"2>&1 | tee -a lpass-update-$$.log
  #echo "$new_name" | lpass edit --sync=now --non-interactive --name "$uid" 2>&1 | tee -a lpass-update-$$.log
done

exit 0


while IFS= read -r line
do
  echo "Line: $line"
done < f.txt
