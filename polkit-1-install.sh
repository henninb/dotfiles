#!/bin/sh

cat > 51-admin.conf <<EOF
[Configuration]
# AdminIdentities=unix-user:henninb;unix-group:wheel
# AdminIdentities=unix-user:brian;unix-group:wheel
AdminIdentities=unix-user:brian
EOF

# cat > udisk <<EOF
# polkit.addRule(function(action, subject) {
#     if (action.id == "org.freedesktop.udisks2.filesystem-mount" &&
#         subject.user == "henninb") {
#         return "yes";
#     }
# });
# EOF

cat > 99-allow-sudo-group-to-do-anything-without-password.pkla <<EOF
[AllowSudoGroupToDoAnythingWithoutPassword]
Identity=unix-group:wheel
Action=*
ResultAny=yes
EOF

# need to remove other 51 files
sudo mv -v 51-admin.conf /etc/polkit-1/localauthority.conf.d/
sudo mv -v 99-allow-sudo-group-to-do-anything-without-password.pkla /etc/polkit-1/localauthority/50-local.d/
sudo mkdir -p /etc/polkit-1/rules.d/
# echo /etc/polkit-1/rules.d/10-udisks2.rules
# echo ls -l /usr/share/polkit-1/actions
# echo sudo vi /usr/share/polkit-1/actions/org.freedesktop.UDisks2.policy
# echo "<allow_active>auth_admin_keep</allow_active>"
# echo "<allow_active>yes</allow_active>"

exit 0
