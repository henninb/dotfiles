dnf repoquery --installed kernel\* --qf '%{name}'

dnf install --skip-broken $(for i in $(dnf repoquery --installed kernel\* --qf '%{name}'); do echo $i-$(dnf --quiet --disablerepo=* --enablerepo=inttf repoquery --queryformat '%{version}-%{release}' kernel |sort -V |tail -1); done)

rpm -q kernel
hostnamectl

dnf info kernel

sudo dnf install kernel --best

https://linuxhint.com/check-version-update-fedora-linux-kernel/
