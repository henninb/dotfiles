

```
mkdir -p "$HOME/chroot"
debootstrap --variant=buildd --arch amd64 hardy "$HOME/chroot/hardy" http://archive.ubuntu.com/ubuntu/

sudo debootstrap --variant=buildd --arch amd64 jammy "$HOME/chroot/jammy" http://archive.ubuntu.com/ubuntu/
debootstrap --variant=buildd --arch amd64 groovy "$HOME/chroot/groovy" http://archive.ubuntu.com/ubuntu/

sudo debootstrap --arch amd64 sid "$HOME/chroot/sid" http://deb.debian.org/debian/

sudo debootstrap --arch amd64 bullseye "$HOME/chroot/bullseye" http://deb.debian.org/debian/
```

