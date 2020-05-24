#!/bin/bash

# APT packages
apt update
apt -y install $(cat server-apt-packages.txt) $(cat desktop-apt-packages.txt)
apt -y upgrade
apt -y dist-upgrade
apt clean

# pip packages
pip3 install -r desktop-pip-packages.txt

# TODO: arduino dropbox

# Users and groups
adduser turicas docker
adduser turicas sudo
adduser turicas dialout

mkdir ~/software
git clone git@github.com/pyenv/pyenv.git ~/software/pyenv
git clone https://github.com/pyenv/pyenv-virtualenv.git ~/software/pyenv/plugins/pyenv-virtualenv
