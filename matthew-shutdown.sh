 while true
           do
             num="$(shuf -i1-1000 -n1)"
             echo "$num"
             sleep "$num"
             ssh matthew "sudo shutdown -h now"
             echo 'restarted'
           done
           exit 0
