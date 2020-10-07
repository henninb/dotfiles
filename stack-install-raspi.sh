#!/bin/sh

mkdir -p /home/pi/.stack/programs/arm-linux/ghc-8.0.1/bin/

set +ex

# A script to install stack on Raspbian

# Use stack installer script to install stack
curl -sSL https://get.haskellstack.org/ | sh

# Use apt-get to install llvm
sudo apt-get install llvm-3.7

# Write a wrapper for ghc to be called with, parameterizing GHC with ARM settings
cat > ~/.stack/programs/arm-linux/ghc-8.0.1/bin/ghc-arm-wrapper.sh <<EOF
#!/bin/sh
ghc-8.0.1 -opta-march=armv7-a $@
EOF

chmod "*.sh"


# Setup symlinks for stack / ghc
sudo ln -s /usr/bin/opt-3.7 /usr/bin/opt
sudo ln -s /usr/bin/llc-3.7 /usr/bin/llc
rm ~/.stack/programs/arm-linux/ghc-8.0.1/bin/ghc
ln ~/.stack/programs/arm-linux/ghc-8.0.1/bin/ghc-arm-wrapper.sh ~/.stack/programs/arm-linux/ghc-8.0.1/bin/ghc

exit 0
