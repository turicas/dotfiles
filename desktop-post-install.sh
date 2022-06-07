#!/bin/bash

# Run as regular user

set -e

./create-symlinks.sh

git clone https://github.com/pyenv/pyenv.git ~/.pyenv
git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
git clone https://github.com/pyenv/pyenv-update.git ~/.pyenv/plugins/pyenv-update

source ~/.bashrc
for version in 3.7 3.8 3.9 3.10; do
	pyenv install $(pyenv install --list | egrep --color=no "^ *${version}" | tail -1 | sed 's/ *//')
done
