#!/bin/bash

apt-get update
apt-get -y install aptitude

aptitude -y install \
    vim-gnome vim-nox exuberant-ctags \
    iptraf iperf nmap tcptraceroute mtr ntpdate \
    i3 nitrogen xscreensaver scrot \
    zip unzip xarchiver \
    cheese mplayer vlc \
    quicksynergy openssh-server \
    tmux screen byobu bash-completion terminator \
    unzip sudo curl lynx w3m htop \
    git gitk mercurial bzr subversion \
    make fakeroot build-essential python-setuptools python-dev \
    markdown pandoc htmldoc \
    chromium chromium-inspector \
    gimp inkscape

aptitude -y remove apache2 exim4
easy_install pip
pip install virtualenv virtualenvwrapper tox py3status
