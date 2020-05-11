#!/bin/sh

sudo flatpak remote-add flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.slack.Slack
echo flatpak run com.slack.Slack

exit 0
