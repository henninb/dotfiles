curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb
sudo apt install ./keybase_amd64.deb
run_keybase

keybase pgp gen    # if you need a PGP key
keybase pgp select # if you already have one in GPG
keybase pgp import # to pull from stdin or a file
