#!/bin/bash

# APT packages
apt-get update
apt-get -y install \
    aptitude vim-gnome vim-nox \
    iptraf iperf nmap tcptraceroute mtr ntpdate \
    i3 i3status nitrogen xscreensaver xbacklight scrot \
    zip unzip xarchiver \
    cheese mplayer vlc \
    quicksynergy openssh-server \
    tmux screen byobu bash-completion terminator rxvt-unicode xsel \
    sudo curl lynx w3m htop \
    git gitk mercurial bzr subversion \
    make fakeroot build-essential python-setuptools python-pip python-dev \
    python-requests markdown pandoc htmldoc \
    python3.6 python3.6-dev \
    chromium chromium-inspector \
    gimp inkscape xchat suckless-tools vlc mplayer iotop powertop iftop \
    pm-utils libmariadbd-dev libssl-dev libxslt-dev libxml2-dev \
    htop iotop powertop lsof libpq-dev postgresql-client \
    libffi-dev libtiff-dev libjpeg-dev libwebp-dev \
    libopenjpeg-dev nodejs npm docker.io flashplugin-nonfree \
    rlwrap erlang erlang-dev erlang-doc \
    xchat pm-utils x11-xserver-utils uim \
    kazam beep dnsutils
apt-get -y remove apache2 exim4
apt-get upgrade
apt-get dist-upgrade

# pip packages
easy_install pip
pip install virtualenv virtualenvwrapper ipython ipython[notebook] \
            bpython pypython httpie youtube-dl

# npm packages
npm install grunt grunt-cli bower marked
if [ ! -e "/usr/bin/node" ]; then
    ln -s /usr/bin/node{js,}
fi

# TODO: arduino, firefox nightly, googletalk-plugin, skype

# Users and groups

adduser turicas docker
adduser turicas sudo


# URxvt stuff
URXVT_PERL=/usr/lib/urxvt/perl/
mkdir projects
cd projects/
sudo -u turicas git clone https://github.com/muennich/urxvt-perls.git
sudo -u turicas git clone https://github.com/majutsushi/urxvt-font-size.git
cp urxvt-font-size/font-size $UXRVT_PERL
cp urxvt-perls/{clipboard,keyboard-select,url-select} $URXVT_PERL
wget -c -t 0 https://media.unpythonic.net/emergent-files/01340900642/unichr \
	-O $URXVT_PERL/unichr


# vim-erlang

mkdir -p ~/.vim/bundle
cd ~/.vim/bundle
git clone git@github.com:vim-erlang/vim-erlang-runtime.git
git clone git@github.com:vim-erlang/vim-erlang-compiler.git
git clone git@github.com:vim-erlang/vim-erlang-omnicomplete.git
git clone git@github.com:vim-erlang/vim-erlang-tags.git
