#!/bin/bash

# File manipulation
alias l='ls -lhatr'
alias ls='ls --color=yes'
alias grep='grep --color=yes'
alias fgrep='fgrep --color=yes'
alias egrep='egrep --color=yes'

# Disks
alias clean-disk='sudo dd if=/dev/urandom bs=1M status=progress oflag=sync'

# SSH
alias ssh="LC_ALL=en_US.UTF-8 ssh"

# Git
alias gf='git fetch --all --prune'

alias mysync='rsync -aAXvzP'

# Docker
alias dce='docker compose exec'
