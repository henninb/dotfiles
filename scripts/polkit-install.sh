#!/bin/sh

# might not be needed
cat > 51-admin.conf <<EOF
[Configuration]
# AdminIdentities=unix-user:henninb;unix-group:wheel
# AdminIdentities=unix-user:brian;unix-group:wheel
AdminIdentities=unix-user:brian
EOF

#  archlinux
cat > 49-nopasswd_global.rules <<EOF
polkit.addRule(function(action, subject) {
    if (subject.isInGroup("wheel")) {
        return polkit.Result.YES;
    }
});
EOF

# debian based
cat > 99-allow-sudo-group-to-do-anything-without-password.pkla <<EOF
[AllowSudoGroupToDoAnythingWithoutPassword]
Identity=unix-group:wheel
Action=*
ResultAny=yes
EOF

doas groupadd wheel
doas usermod -a -G wheel "$(whoami)"
# need to remove other 51 files
echo sudo mkdir -p /etc/polkit-1/rules.d/
sudo mv -v 51-admin.conf /etc/polkit-1/localauthority.conf.d/
sudo mv -v 99-allow-sudo-group-to-do-anything-without-password.pkla /etc/polkit-1/localauthority/50-local.d/
sudo mv -v 99-allow-sudo-group-to-do-anything-without-password.pkla /etc/polkit-1/localauthority.conf.d/
sudo mv -v 49-nopasswd_global.rules /etc/polkit-1/rules.d/
# echo /etc/polkit-1/rules.d/10-udisks2.rules
# echo ls -l /usr/share/polkit-1/actions

exit 0

# vim: set ft=sh:
