#!/bin/sh

sudo df | grep "/$" | awk '{print $5}'

exit 0
