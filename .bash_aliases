#!/bin/bash

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


# SSH
alias ssh="LC_ALL=en_US.UTF-8 ssh"
alias proxy-ssh="ssh -NfD 0.0.0.0:1234 lindomar 2> /dev/null"
alias lindomar="ssh lindomar"
alias webfaction="ssh webfaction"

# Music
alias music-at-work="totem ~/Music/zelda-64-ocarina-of-time 2> /dev/null &" # <3
