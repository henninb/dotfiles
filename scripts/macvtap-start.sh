#!/bin/sh

sudo ip link add link enp3s0 name macvtap0 type macvtap mode private

exit 0
