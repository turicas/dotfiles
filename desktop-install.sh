#!/bin/bash

# Run as root

set -e

# APT packages
apt update
apt install -y nala
nala install -y $(cat server-apt-packages.txt) $(cat desktop-apt-packages.txt)
nala upgrade -y
nala dist-upgrade -y
nala clean

mkdir -p /etc/apt/keyrings

# Docker (via APT)
nala remove -y docker docker.io containerd runc
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian bullseye stable" | tee /etc/apt/sources.list.d/docker.list
nala update
nala install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
nala clean

# Dropbox (via DEB)
nala install -y libpango1.0-0
nala clean
wget -O "/tmp/dropbox.deb" "https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2020.03.04_amd64.deb"
dpkg -i "/tmp/dropbox.deb"
rm "/tmp/dropbox.deb"

# Google Chrome (via .deb)
wget -O "/tmp/google-chrome.deb" https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i "/tmp/google-chrome.deb"
rm "/tmp/google-chrome.deb"

# pip packages
pip3 install -r desktop-pip-packages.txt

# Users and groups
for group in dialout docker libvirt sudo; do
	adduser turicas $group
done
