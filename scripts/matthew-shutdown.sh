#!/bin/sh

 while true
           do
             num="$(shuf -i1-1000 -n1)"
             echo "$num"
             sleep "$num"
             sudo su - matthew -c ./notify 'are you there?'
             ssh matthew "sudo shutdown -h now"
             echo 'restarted'
           done
exit 0

# vim: set ft=sh
