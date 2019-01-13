#!/bin/sh

sudo zfs list shows
sudo vm img FreeBSD-11.2-RELEASE-amd64.raw.xz

sudo vm create -t freebsd-zvol -i FreeBSD-11.2-RELEASE-amd64.raw freebsd-cloud
sudo vm start freebsd-cloud

exit 0
