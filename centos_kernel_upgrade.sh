#!/bin/sh

if [ "$OS" = "CentOS Linux" ]; then
  sudo rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
  sudo rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm

  yum --disablerepo="*" --enablerepo="elrepo-kernel" list available

  # install ml version
  sudo yum remove -y kernel-headers
  sudo yum --enablerepo=elrepo-kernel install -y kernel-ml kernel-ml-headers kernel-ml-devel
  rpm -qa kernel
else
  echo $OS is not yet implemented.
  exit 1
fi

exit 0
