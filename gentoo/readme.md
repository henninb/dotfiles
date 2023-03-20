eix net-misc/rsync dev-libs/openssl
sudo emerge --unmerge dev-libs/openssl-compat
equery -q list openssl
equery d "dev-libs/openssl-1.1.1"
equery -CN depends dev-libs/openssl | grep ":0/1.1"
