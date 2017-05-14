#!/bin/bash

alias l='ls -lhatr'

# enable color support of ls and also add handy aliases
alias ls='ls --color=yes'
alias grep='grep --color=yes'
alias fgrep='fgrep --color=yes'
alias egrep='egrep --color=yes'

# SSH
alias ssh="LC_ALL=en_US.UTF-8 ssh"
alias proxy-ssh="ssh -NfD 0.0.0.0:1234 lindomar 2> /dev/null"
alias lindomar="ssh lindomar"
alias webfaction="ssh webfaction"

# Music
alias music-at-work="totem ~/Music/zelda-64-ocarina-of-time 2> /dev/null &" # <3

# Erlang
alias erl='rlwrap -a erl'

# Git
alias gf='git fetch --all --prune'

# Ledger
alias balance='ledger --price-db ~/money/prices.dat -f ~/money/ledger.dat \
	                  --no-total --current --market balance not Equity'
