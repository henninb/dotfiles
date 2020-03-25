#!/bin/sh

cat > 51-ubuntu-admin.conf <<EOF
[Configuration]
AdminIdentities=unix-user:henninb
EOF

cat > udisk <<EOF
polkit.addRule(function(action, subject) {
    if (action.id == "org.freedesktop.udisks2.filesystem-mount" &&
        subject.user == "henninb") {
        return "yes";
    }
});
EOF

exit 0
