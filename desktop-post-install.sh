#!/bin/bash

# Run as regular user

set -e

./create-symlinks.sh

git clone https://github.com/pyenv/pyenv.git ~/.pyenv
git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
git clone https://github.com/pyenv/pyenv-update.git ~/.pyenv/plugins/pyenv-update

source ~/.bashrc
for version in 3.7 3.8 3.9 3.10 3.11 3.12; do
	pyenv install $(pyenv install --list | egrep --color=no "^ *${version}" | tail -1 | sed 's/ *//')
done

# Rust
rustup default stable

# exiftool GPX format
mkdir -p ~/.local/share/exiftool
wget -O ~/.local/share/exiftool/gpx.fmt "https://raw.githubusercontent.com/exiftool/exiftool/master/fmt_files/gpx.fmt"

# Link `ntfs-3g` executables so `fsck` will find it
sudo ln -s /usr/bin/ntfsfix /sbin/fsck.ntfs
sudo ln -s /usr/bin/ntfsfix /sbin/fsck.ntfs-3g

# Other software
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install --noninteractive flathub com.obsproject.Studio
./install/fonts.sh
./install/neovim.sh
./install/tree-sitter.sh
./install/webdrivers.sh
./install/scripts.sh
