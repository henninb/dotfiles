#!/bin/sh

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install flathub com.slack.Slack
echo flatpak run com.slack.Slack

exit 0
