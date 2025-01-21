#!/bin/bash

# File manipulation
alias l='ls -lhatr'
alias ls='ls --color=yes'
alias grep='grep --color=yes'
alias fgrep='fgrep --color=yes'
alias egrep='egrep --color=yes'

# Disks
alias disk-destroy='sudo dd status=progress oflag=sync bs=8M if=/dev/urandom'
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

# MinIO client
alias mc='docker run --rm -v $(pwd):/data -v $HOME/.mc:/root/.mc minio/mc'


# Python
alias ipython="ipython3"
alias ipy="ipython3"

# Custom commands

hack() {
	project_name="$1"
	if [[ $project_name = "." ]]; then
		project_name=$(basename $(pwd))
	fi
	projects_home=~/projects

	if [ -z "$project_name" ]; then
		echo "ERROR - Usage: $0 <project-name>"
		return
	fi

	project_path=$projects_home/$project_name
	env_file=$project_path/.env
	docker_compose_file_1=$project_path/compose.yaml
	docker_compose_file_2=$project_path/compose.yml
	docker_compose_file_3=$project_path/docker-compose.yaml
	docker_compose_file_4=$project_path/docker-compose.yml
	cd $project_path

	# Export environment variables
	if [ -f "$env_file" ]; then
		set -o allexport
		source "$env_file"
		set +o allexport
	fi

	# Activate virtualenv
	if [[ -e "$(which pyenv)" && -e "$(pyenv prefix $project_name 2> /dev/null)" ]]; then
		pyenv activate $project_name
	fi

	# Run needed containers
	if [ -f "$docker_compose_file_1" ]; then
		docker compose -p $project_name -f $docker_compose_file_1 up -d
	elif [ -f "$docker_compose_file_2" ]; then
		docker compose -p $project_name -f $docker_compose_file_2 up -d
	elif [ -f "$docker_compose_file_3" ]; then
		docker compose -p $project_name -f $docker_compose_file_3 up -d
	elif [ -f "$docker_compose_file_4" ]; then
		docker compose -p $project_name -f $docker_compose_file_4 up -d
	fi

	if [ -f ".activate" ]; then
		source .activate
	fi
}

ghc() {  # GitHub Clone
	cd ~/projects/
	git clone git@github.com:$1.git
	cd $(basename $1)
}

json_escape () {
    printf '%s' $1 | python -c 'import json,sys; print(json.dumps(sys.stdin.read()))'
}

reencode() {
    if [[ -z $2 ]]; then
        echo "ERROR - usage: $0 <input-video> <output-video>"
        return
    fi
    ffmpeg \
        -nostdin \
        -loglevel quiet \
        -stats \
        -i "$1" \
        -c:v libx265 -crf 28 \
        -x265-params log-level=quiet \
        -c:a aac -b:a 128k \
        -preset medium \
        -map_metadata 0 -map_chapters 0 -map 0 \
        "$2"
}

reencode-to-full-hd() {
    if [[ -z $2 ]]; then
        echo "ERROR - usage: $0 <input-video> <output-video>"
        return
    fi
    ffmpeg \
        -nostdin \
        -loglevel quiet \
        -stats \
        -i "$1" \
        -c:v libx265 -crf 28 \
        -x265-params log-level=quiet \
        -vf scale=1920:1080,setsar=1:1 \
        -c:a aac -b:a 128k \
        -preset medium \
        -map_metadata 0 -map_chapters 0 -map 0 \
        "$2"
}

start-remote-vnc-server() {
	remoteIP="$1"

	if [[ -z $remoteIP ]]; then
		echo "ERROR - usage: $0 <remote-ip>"
		exit
	fi

	ssh -t -L 5900:localhost:5900 "$remoteIP" 'x11vnc -localhost -display :0'
}

start-vnc-client() {
	vncviewer -PreferredEncoding=ZRLE localhost:0
}

workspace-refresh() {
	hdmiConnected=$(xrandr --query | grep --color=no ' connected ' | sed 's/ .*//' | sort | grep --color=no HDMI-1 | wc -l)
	if [[ $hdmiConnected == 1 ]]; then
		xrandr --output HDMI-1 --auto --left-of eDP-1
		i3-msg '[workspace="1"]' move workspace to output HDMI-1
		i3-msg '[workspace="2"]' move workspace to output eDP-1
		i3-msg '[workspace="3"]' move workspace to output HDMI-1
		i3-msg '[workspace="4"]' move workspace to output eDP-1
		i3-msg '[workspace="5"]' move workspace to output eDP-1
	else
		xrandr --output HDMI-1 --off
	fi
}

pdf-search() {
	# Searches for text inside PDF files in the current directory, recursively
	query=$1

	if [[ -z $query ]]; then
		echo "ERROR - usage: ${FUNCNAME[0]} <query>"
		return
	fi

	find -iname '*.pdf' | while read filename; do
		result=$(pdftotext -enc UTF-8 -layout "$filename" - | grep -E "$query")
		if [[ ! -z $result ]]; then
			echo "${filename}:"
			echo "$result"
			echo
		fi
	done
}


repo-contents() {
	git ls-tree -r HEAD --name-only \
		| grep -Ev '^(\.gitignore|LICENSE)$' \
		| sort \
		| while read filename; do
		echo -e "---------- START: $filename ----------\n$(cat $filename)\n---------- END: $filename ----------\n\n"
	done
}
