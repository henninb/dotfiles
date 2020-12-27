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
# echo sudo postconf -e 'message_size_limit = 104857600'
# I am setting up the following values in main.cf

# mailbox_size_limit = 0
# message_size_limit = 0
# virtual_mailbox_limit = 0

exit 0
