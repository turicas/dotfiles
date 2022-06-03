#!/bin/bash

# Run as root

set -e

# APT packages
apt update
apt -y install $(cat server-apt-packages.txt) $(cat desktop-apt-packages.txt)
apt -y upgrade
apt -y dist-upgrade
apt clean

mkdir -p /etc/apt/keyrings

# Docker (via APT)
apt remove docker docker-engine docker.io containerd runc
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian bullseye stable" | sudo tee /etc/apt/sources.list.d/docker.list
apt update
apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
apt clean

# Dropbox (via APT)
echo "deb [arch=amd64] http://linux.dropbox.com/debian sid main" > /etc/apt/sources.list.d/dropbox.list
apt update
apt install -y dropbox
apt clean

# Google Chrome (via .deb)
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i google-chrome-stable_current_amd64.deb

# pip packages
pip3 install -r desktop-pip-packages.txt

# Users and groups
adduser turicas docker
adduser turicas sudo
adduser turicas dialout
