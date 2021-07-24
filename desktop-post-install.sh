#!/bin/bash

# Run as regular user

set -e

mkdir ~/software
git clone https://github.com/pyenv/pyenv.git ~/software/pyenv
git clone https://github.com/pyenv/pyenv-virtualenv.git ~/software/pyenv/plugins/pyenv-virtualenv
git clone https://github.com/pyenv/pyenv-update.git ~/software/pyenv/plugins/pyenv-update
