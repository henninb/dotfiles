#!/usr/bin/env sh

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ]; then
  wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
  echo deb https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list
  sudo apt -y update

  sudo apt install -y jenkins

  sudo systemctl enable jenkins
  sudo systemctl start jenkins
  sudo systemctl status jenkins

  sudo ufw allow 8080
  sudo ufw status

  sudo cat /var/lib/jenkins/secrets/initialAdminPassword
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge --update --newuse dev-util/jenkins-bin
else
  echo "$OS is not yet implemented."
  exit 1
fi

echo http://localhost:8080

exit 0
