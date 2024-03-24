#!/bin/sh
#
curl -sLO https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-382.0.0-linux-x86_64.tar.gz
tar -xf google-cloud-cli-*-linux-x86_64.tar.gz
sudo mv google-cloud-sdk /opt/
rm -f google-cloud-cli-*-linux-x86_64.tar.gz
# cp /opt/google-cloud-sdk/completion.bash.inc /etc/bash_completion.d/
# echo 'export PATH=$PATH:/opt/google-cloud-sdk/bin' >>/etc/profile
# echo 'source /opt/google-cloud-sdk/path.bash.inc' >>/etc/profile
# export PATH=$PATH:/opt/google-cloud-sdk/bin
# source /opt/google-cloud-sdk/path.bash.inc
gcloud config set disable_usage_reporting true
gcloud --version

exit 0
