#!/bin/bash

set -e

mkdir -p ~/.local/bin
pushd ~/.local/bin
downloadUrl=$(
	wget --quiet -O - https://github.com/astral-sh/ruff/releases \
	| grep -oE --color=no 'href="([^ ]+-x86_64-unknown-linux-gnu.tar.gz)"' \
	| sed 's|href="||; s|"$||' \
	| head -1
)
downloadFile="ruff.tar.gz"
wget -O "$downloadFile" "$downloadUrl"
tar xfz "$downloadFile"
mv ruff-x86_64-unknown-linux-gnu/ruff .
rm "$downloadFile"
rmdir "ruff-x86_64-unknown-linux-gnu"
chmod +x ruff
popd
