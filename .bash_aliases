#!/bin/bash

# File manipulation
alias l='ls -lhatr'
alias ls='ls --color=yes'
alias grep='grep --color=yes'
alias fgrep='fgrep --color=yes'
alias egrep='egrep --color=yes'

# Disks
alias disk-destroy='time sudo dd status=progress oflag=sync bs=8M if=/dev/urandom'
alias mdd='time sudo dd status=progress oflag=sync bs=1M'

# SSH
alias ssh="LC_ALL=en_US.UTF-8 ssh"

# Git
alias gap='git add -p'
alias gca='git commit --amend'
alias gci='git commit'
alias gdc='git diff --cached'
alias gdf='git diff'
alias gdn='git diff --no-index'
alias gfa='git fetch --all'
alias gfp='git fetch --all --prune'
alias gka='gitk --all &'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias gri='git rebase -i origin/develop'
alias grs='git restore --staged'
alias gsl='git stash list'
alias gsp='git stash pop'
alias gss='git stash save'
alias gst='git status'
alias gsv='git show -v'

# GitHub Clone
ghc() {
  cd ~/projects/
  git clone git@github.com:$1.git
  cd $(basename $1)
}
# Gitlab Clone
glc() {
  cd ~/projects/
  git clone git@gitlab.com:$1.git
  cd $(basename $1)
}

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

json_escape () {
  printf '%s' $1 | python -c 'import json,sys; print(json.dumps(sys.stdin.read()))'
}

vnc-start-remote-server() {
  remoteIP="$1"

  if [[ -z $remoteIP ]]; then
    echo "ERROR - usage: $0 <remote-ip>"
    exit
  fi

  ssh -t -L 5900:localhost:5900 "$remoteIP" 'x11vnc -localhost -display :0'
}

vnc-start-client() {
  vncviewer -PreferredEncoding=ZRLE localhost:0
}

pdfsearch() {
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


gitcontents() {
  git ls-tree -r HEAD --name-only \
    | grep -Ev '^(\.gitignore|LICENSE)$' \
    | sort \
    | while read filename; do
        echo "---------- START: $filename ----------"
        cat "$filename"
        echo -e "\n---------- END: $filename ----------\n"
      done
}

conngraph() {
  ssh_info="$1"; shift
  if [[ -z $ssh_info ]]; then
    echo "ERROR - Usage: $0 <ssh-info>"
    exit 1
  fi

  filename=$(mktemp --suffix=.png)
  ssh $ssh_info sudo lsof -n -F \
    | lsofgraph \
    | unflatten -l 1 -c 6 \
    | dot -T png > "$filename"
  eog "$filename"
  rm "$filename"
}

randstr() {
  echo $(cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 16)
}

docker-ls-files() {
  image_name=$(echo "build-context-$(randstr)" | tr 'A-Z' 'a-z')
  docker image build --cache-from busybox --no-cache -t "$image_name" -f - . <<EOF
FROM busybox
WORKDIR /app
COPY . /app
CMD ["find", "/app", "-type", "f"]
EOF
  docker run --rm "$image_name" | sed 's/^\/app\///' | sort
  docker image rm "$image_name" > /dev/null
}
