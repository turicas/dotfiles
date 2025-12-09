#!/bin/bash

set -e

mkdir -p ~/.local/opt
cd ~/.local/opt
VERSION="0.15.2"
URL="https://ziglang.org/download/${VERSION}/zig-x86_64-linux-${VERSION}.tar.xz"
FILENAME=$(basename "$URL")
wget "$URL"
tar xfvJ "$FILENAME"
rm "$FILENAME"
cd -
rm -f ~/.local/bin/zig
ln -s ~/.local/opt/zig-*-$VERSION/zig ~/.local/bin/
