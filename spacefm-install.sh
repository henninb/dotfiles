#!/bin/sh

sudo apt install -y spacefm udevil

cd "$HOME/projects"
git clone git@github.com:IgnorantGuru/spacefm.git
cd spacefm

exit 0
