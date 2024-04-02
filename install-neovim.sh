#!/bin/bash

set -e

mkdir -p ~/.local/opt
cd ~/.local/opt
wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
tar xfvz nvim-linux64.tar.gz
rm nvim-linux64.tar.gz
rm -rf ~/.local/bin/nvim
cd -

ln -s ~/.local/opt/nvim-linux64/bin/nvim ~/.local/bin/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim
