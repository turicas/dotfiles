# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# bash history config
HISTCONTROL=ignoredups:ignorespace
HISTSIZE=1000000
HISTFILESIZE=2000000
HISTTIMEFORMAT="[%Y-%m-%d %H:%M:%S] "
shopt -s histappend


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color|rxvt-unicode) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# change prompt
dvcs_info() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ git\[\1\]/'
    hg branch 2> /dev/null | sed -e 's/\(.*\)/ hg\[\1\]/'
}

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] $(dvcs_info)\n\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w $(dvcs_info)\n\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac
export PS1='($(pyenv version-name)) '$PS1


# source more bashrc files
[ -f ~/.bashrc.local ] && source ~/.bashrc.local
[ -f ~/.bash_aliases ] && source ~/.bash_aliases


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Custom commands

hack() {
	project_name="$1"
	if [[ $project_name = "." ]]; then
		project_name=$(basename $(pwd))
	fi
	projects_home=~/projects

	if [ -z "$project_name" ]; then
		echo "ERROR - Usage: $0 <project-name>"
		exit 1
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
}

mp4togif() {
	TEMP_DIR="/tmp/gif-$(basename $1)"
	mkdir -p "$TEMP_DIR"

	ffmpeg -i "$1" -r 30 "$TEMP_DIR/frame-%03d.jpg"
	convert -delay 3 -loop 0 "$TEMP_DIR/*.jpg" $(pwd)/$(basename $1).gif

	rm -rf "$TEMP_DIR"
}

json_escape () {
    printf '%s' $1 | python -c 'import json,sys; print(json.dumps(sys.stdin.read()))'
}

msync() {  # rsync with my preferred options
	#-P: --partial --progress
	#-a: --archive
	#-c: --checksum
	#-h: --human-readable
	#-v: --verbose
	#-z: --compress
	rsync -aczPhhhv $@
}

http-server() {
    docker run -p 8000:80 -v $(pwd):/usr/share/nginx/html nginx
}

# env vars exports
export GOPATH=$HOME/.go
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$HOME/projects/dotfiles/bin:$GOPATH/bin:$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
