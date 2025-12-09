#!/bin/bash

set -e

mkdir -p ~/.local/opt
pushd ~/.local/opt
VERSION="39.0.1"
URL="https://github.com/bytecodealliance/wasmtime/releases/expanded_assets/v${VERSION}"
wasmtime_url=$(
	wget --quiet -O - "$URL" \
	| grep -oE --color=no 'href="(/[^ ]+-x86_64-linux.tar.xz)"' \
	| sed 's|href="|https://github.com|; s|"$||' \
	| head -1
)
FILENAME=$(basename "$wasmtime_url")
wget -O "$FILENAME" "$wasmtime_url"
tar xfvJ "$FILENAME"
rm "$FILENAME"
rm -f ~/.local/bin/wasmtime
ln -s ~/.local/opt/wasmtime*$VERSION*/wasmtime ~/.local/bin/
popd
