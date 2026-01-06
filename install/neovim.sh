#!/bin/bash

set -e

mkdir -p ~/.local/opt ~/.local/bin
cd ~/.local/opt
nvim_url=$(
  wget --quiet -O - https://github.com/neovim/neovim/releases \
    | grep -oE --color=no 'href="(/[^ ]+/nvim-linux-x86_64.tar.gz)"' \
    | sed 's|href="|https://github.com|; s|"$||' \
    | head -1
)
wget "$nvim_url"
filename=$(basename "$nvim_url")
tar xfvz "$filename"
rm "$filename"
rm -rf ~/.local/bin/nvim
cd -

mkdir -p ~/.local/bin/ ~/.config/nvim/
ln -s ~/.local/opt/nvim-linux-x86_64/bin/nvim ~/.local/bin/nvim
if [[ ! -e ~/.config/nvim/init.vim ]]; then
  ln -s ~/.vimrc ~/.config/nvim/init.vim
fi
