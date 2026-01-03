#!/bin/bash

set -e

if [[ $(id -u) == 0 ]]; then
	echo "ERROR: must not be run as root!"
	exit 1;
fi

# Create symlinks in $HOME using GNU stow
for package in */; do
  if [[ $package != "install/" ]]; then
    echo "Creating symlinks for package ${package}..."
    stow --target=$HOME $package
  fi
done

git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
for version in 3.8 3.9 3.10 3.11 3.12 3.13 3.14; do
	pyenv install $version
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
flatpak install --noninteractive flathub org.kde.kdenlive
#./install/scripts.sh
#./install/tree-sitter.sh
./install/duckdb.sh
./install/fonts.sh
./install/neovim.sh
./install/ruff.sh
./install/wasmtime.sh
./install/webdrivers.sh
./install/zig.sh

# CSS for pandoc (markdown -> HTML)
mkdir -p ~/.local/css
wget -O ~/.local/css/pandoc.css https://gist.githubusercontent.com/killercup/5917178/raw/40840de5352083adb2693dc742e9f75dbb18650f/pandoc.css
