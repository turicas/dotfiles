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

# Users and groups
for group in dialout docker libvirt sudo; do
	adduser turicas $group
done
