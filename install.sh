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
    tmux screen byobu bash-completion terminator urxvt xsel \
    unzip sudo curl lynx w3m htop \
    git gitk mercurial bzr subversion \
    make fakeroot build-essential python-setuptools python-dev \
    markdown pandoc htmldoc \
    chromium chromium-inspector \
    gimp inkscape

aptitude -y remove apache2 exim4
easy_install pip
pip install virtualenv virtualenvwrapper tox py3status

# URxvt stuff
URXVT_PERL=/usr/lib/urxvt/perl/
mkdir code
cd code/
sudo -u turicas git clone https://github.com/muennich/urxvt-perls.git
sudo -u turicas git clone https://github.com/majutsushi/urxvt-font-size.git
cp urxvt-font-size/font-size $UXRVT_PERL
cp urxvt-perls/{clipboard,keyboard-select,url-select} $URXVT_PERL
