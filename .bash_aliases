#!/bin/bash

# File manipulation
alias l='ls -lhatr'
alias ls='ls --color=yes'
alias grep='grep --color=yes'
alias fgrep='fgrep --color=yes'
alias egrep='egrep --color=yes'
# rsync with my preferred options
#-a: --archive
#-c: --checksum
#-z: --compress
#-P: --partial --progress
#-h: --human-readable
#-v: --verbose
# TODO: What's the difference between this and `rsync -aczPhhhv`?
alias mysync='rsync -aAXvzP'

# Disks
alias clean-disk='sudo dd if=/dev/urandom bs=1M status=progress oflag=sync'
alias mydd='time dd status=progress oflag=sync bs=1M'

# SSH
alias ssh="LC_ALL=en_US.UTF-8 ssh"

# Git
alias gf='git fetch --all --prune'

# Docker
alias dce='docker compose exec'
