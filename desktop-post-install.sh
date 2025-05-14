#!/bin/bash

set -e

if [[ $(id -u) == 0 ]]; then
	echo "ERROR: must not be run as root!"
	exit 1;
fi

./create-symlinks.sh

git clone https://github.com/pyenv/pyenv.git ~/.pyenv
git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
git clone https://github.com/pyenv/pyenv-update.git ~/.pyenv/plugins/pyenv-update

source ~/.bashrc
for version in 3.9 3.10 3.11 3.12 3.13; do
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
./install/fonts.sh
./install/neovim.sh
./install/tree-sitter.sh
./install/webdrivers.sh
./install/scripts.sh


# CSS for pandoc (markdown -> HTML)
mkdir -p ~/.local/css
wget -O ~/.local/css/pandoc.css https://gist.githubusercontent.com/killercup/5917178/raw/40840de5352083adb2693dc742e9f75dbb18650f/pandoc.css
