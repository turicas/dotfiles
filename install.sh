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

apt-get -y install libmariadbd-dev libssl-dev libxslt-dev libxml2-dev \
    htop iotop powertop lsof libpq-dev postgresql-client libffi-dev \
    libtiff-dev libjpeg-dev libwebp-dev libopenjpeg-dev nodejs npm \
    docker.io flashplugin-nonfree xchat
# TODO: arduino, firefox nightly, googletalk-plugin, skype

adduser turicas docker
adduser turicas sudo
npm install grunt grunt-cli bower marked

if [ ! -e "/usr/bin/node" ]; then
    ln -s /usr/bin/node{js,}
fi

aptitude -y remove apache2 exim4
easy_install pip
pip install virtualenv virtualenvwrapper httpie youtube-dl

# URxvt stuff
URXVT_PERL=/usr/lib/urxvt/perl/
mkdir projects
cd projects/
sudo -u turicas git clone https://github.com/muennich/urxvt-perls.git
sudo -u turicas git clone https://github.com/majutsushi/urxvt-font-size.git
cp urxvt-font-size/font-size $UXRVT_PERL
cp urxvt-perls/{clipboard,keyboard-select,url-select} $URXVT_PERL
