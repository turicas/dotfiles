#!/bin/bash

set -e

if [[ $(id -u) != 0 ]]; then
       echo "ERROR: must be run as root!"
       exit 1;
fi

# System packages
apt update
apt install -y nala
nala full-upgrade -y
nala install -y $(cat server-apt-packages.txt)

# Python packages
pip3 install -r server-pip-packages.txt

# Docker base install
nala emove docker docker.io containerd runc
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian bullseye stable"
nala update
nala install -y docker-ce docker-ce-cli containerd.io

# Pre-pull some docker images
cat server-docker-images.txt | while read image; do
   docker pull $image
done
# TODO: Fix docker: echo '@{PROC}=/proc/' > /etc/apparmor.d/tunables/proc

# Dokku base install
wget -nv -O - https://packagecloud.io/dokku/dokku/gpgkey | apt-key add -
OS_ID="$(lsb_release -cs 2>/dev/null || echo "bionic")"
echo "xenial bionic focal" | grep -q "$OS_ID" || OS_ID="bionic"
echo "deb https://packagecloud.io/dokku/dokku/ubuntu/ ${OS_ID} main" | tee /etc/apt/sources.list.d/dokku.list
nala update
nala install -y dokku
dokku plugin:install-dependencies --core
dokku config:set --global DOKKU_RM_CONTAINER=1

# Install Dokku plugins:
dokku plugin:install https://github.com/dokku/dokku-maintenance.git maintenance
dokku plugin:install https://github.com/dokku/dokku-postgres.git postgres
dokku plugin:install https://github.com/dokku/dokku-letsencrypt.git
dokku plugin:install https://github.com/dokku/dokku-mysql.git mysql
dokku plugin:install https://github.com/dokku/dokku-redis.git redis

# Optional - move dokku services storage to another partition:
# mv /var/lib/dokku/services /mnt/data/dokku-services
# mkdir /var/lib/dokku/services
# echo "/mnt/data/dokku-services /var/lib/dokku/services none bind 0 0" >> /etc/fstab
# mount /var/lib/dokku/services

# Finish installation
nala autoremove -y
nala clean
