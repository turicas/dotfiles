#!/bin/bash

# File manipulation
alias l='ls -lhatr'
alias ls='ls --color=yes'
alias grep='grep --color=yes'
alias fgrep='fgrep --color=yes'
alias egrep='egrep --color=yes'

# Disks
alias disk-destroy='sudo dd if=/dev/urandom bs=8M status=progress oflag=sync'
alias mdd='time dd status=progress oflag=sync bs=1M'

# SSH
alias ssh="LC_ALL=en_US.UTF-8 ssh"

# Git
alias gf='git fetch --all --prune'

# rsync with my preferred options
#-a: --archive
#-A: --acls
#-c: --checksum
#-z: --compress
#-X: --xattrs
#-N: --crtimes
#-P: --partial --progress
#-h: --human-readable
#-v: --verbose
alias msync='rsync -aAczXPhhhv'

# Docker
alias dce='docker compose exec'
alias http-server='docker run -p 8000:80 -v $(pwd):/usr/share/nginx/html nginx'

alias yt-sub='yt-dlp --sub-langs=pt --write-auto-sub --skip-download --no-cache-dir --progress --output="%(id)s"'
