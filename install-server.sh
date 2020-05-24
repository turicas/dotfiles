#!/bin/bash

# System packages
apt update
apt full-upgrade
apt install $(cat server-apt-packages.txt)
apt autoremove
apt clean

# Python packages
pip3 install -r server-pip-packages.txt

# Docker
apt remove docker docker-engine docker.io containerd runc
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
apt update
apt install docker-ce docker-ce-cli containerd.io
cat server-docker-images.txt | while read image; do
	docker pull $image
done
# TODO: Fix docker: echo '@{PROC}=/proc/' > /etc/apparmor.d/tunables/proc

# Dokku
wget -nv -O - https://packagecloud.io/dokku/dokku/gpgkey | apt-key add -
export SOURCE="https://packagecloud.io/dokku/dokku/ubuntu/"
export OS_ID="$(lsb_release -cs 2>/dev/null || echo "trusty")"
echo "utopicvividwilyxenialyakketyzestyartfulbionic" | grep -q "$OS_ID" || OS_ID="trusty"
echo "deb $SOURCE $OS_ID main" | tee /etc/apt/sources.list.d/dokku.list
apt update
apt install dokku
dokku plugin:install-dependencies --core
dokku plugin:install https://github.com/dokku/dokku-postgres.git postgres
dokku plugin:install https://github.com/dokku/dokku-letsencrypt.git
dokku plugin:install https://github.com/dokku/dokku-mysql.git mysql
dokku plugin:install https://github.com/dokku/dokku-redis.git redis
mv /var/lib/dokku/services /mnt/data/dokku-services
mkdir /var/lib/dokku/services
echo "/mnt/data/dokku-services /var/lib/dokku/services none bind 0 0" >> /etc/fstab
mount /var/lib/dokku/services
