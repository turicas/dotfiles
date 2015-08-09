#!/bin/bash

apt-get update
apt-get remove apache2 exim4
apt-get install bash-completion build-essential byobu bzr curl fakeroot \
		   git htmldoc htop iotop iperf iptraf lynx make markdown mercurial \
		   mtr nmap ntpdate pandoc python-dev python-pip python-setuptools \
		   subversion sudo tcptraceroute unzip unzip vim-nox w3m zip
apt-get -y autoremove
apt-get clean
pip install virtualenv virtualenvwrapper ipython
