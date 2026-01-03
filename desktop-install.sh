#!/bin/bash

set -e

if [[ $(id -u) != 0 ]]; then
       echo "ERROR: must be run as root!"
       exit 1;
fi

# Choose the best mirror
apt update && apt install -y netselect-apt
# TODO: change country if machine is outside Brazil
netselect-apt -n -t 100 -c Brazil testing
mv sources.list /etc/apt
apt modernize-sources

# APT packages
apt update
apt install -y $(cat server-apt-packages.txt) $(cat desktop-apt-packages.txt)
apt upgrade -y
apt dist-upgrade -y
apt clean

install -m 0755 -d /etc/apt/keyrings

# Google Chrome (via .deb)
wget -O "/tmp/google-chrome.deb" https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i "/tmp/google-chrome.deb"
rm "/tmp/google-chrome.deb"

# Users and groups
for group in dialout docker libvirt sudo; do
	adduser turicas $group
done
