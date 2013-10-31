#!/bin/bash

apt-get update
apt-get -y install aptitude

aptitude -y install \
    vim-gnome vim-nox exuberant-ctags \
    iptraf iperf nmap tcptraceroute mtr ntpdate \
    i3 nitrogen xscreensaver scrot \
    cheese zip unzip mplayer \
    quicksynergy openssh-server \
    tmux screen byobu bash-completion terminator \
    unzip sudo curl lynx w3m htop \
    git gitk mercurial bzr subversion \
    make fakeroot build-essential python-setuptools python-dev markdown \
    chromium chromium-inspector \
    gimp inkscape

aptitude -y remove apache2 exim4
easy_install pip
pip install virtualenv virtualenvwrapper py3status
