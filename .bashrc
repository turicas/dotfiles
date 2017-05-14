# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return


# bash history config
HISTCONTROL=ignoredups:ignorespace
HISTSIZE=1000000
HISTFILESIZE=2000000
HISTTIMEFORMAT="[%Y-%m-%d %H:%M:%S] "
shopt -s histappend


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# change prompt
dcvs_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ git\[\1\]/'
    hg branch 2> /dev/null | sed -e 's/\(.*\)/ hg\[\1\]/'
}
PS1='\u@$(cat /etc/hostname):\[\033[01;34m\]\w\[\033[00m\] $(dcvs_branch)\n$ '


# (virtualenv & virtualenvwrapper)-related things
export WORKON_HOME="$HOME/.virtualenvs"
source /usr/local/bin/virtualenvwrapper.sh


# env vars exports
export GOPATH=$HOME/.go
export PATH="$HOME/bin:$GOPATH/bin:$HOME/node_modules/.bin:$PATH"


# bash completion
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi


# source more bashrc files
[ -f ~/.bashrc.local ] && source ~/.bashrc.local
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

hack() {
	cd ~/projects/$1
	workon $1
}

ghc() {  # GitHub clone
	cd ~/projects/
	git clone git@github.com:$1.git
}

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# added by travis gem
#[ -f /home/turicas/.travis/travis.sh ] && source /home/turicas/.travis/travis.sh

# Add RVM to PATH for scripting
#export PATH="$PATH:$HOME/.rvm/bin"
#source /home/turicas/.rvm/scripts/rvm
