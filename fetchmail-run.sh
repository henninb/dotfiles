#!/bin/sh

echo "$MAIL"
echo procmail fetchmail postfix mutt neomutt abook mailq
echo mutt -f /var/spool/mail/henninb
#fetchmail -vvv
fetchmail
# fetchmail -vvv -d0 -avNk -m "/usr/sbin/sendmail -i -f %F -- %T" pop.gmail.com
echo touch /var/spool/mail/henninb

# sendmail checks
# mailq
# sendmail -bp
# sudo postsuper -d ALL deferred

# postfix actions
#sudo mkfifo /var/spool/postfix/public/pickup
#sudo systemctl restart postfix
# sudo newaliases
# echo archlinux.localdomain >> /etc/hosts

exit 0
