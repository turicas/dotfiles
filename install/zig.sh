#!/bin/bash

set -e

mkdir -p ~/.local/opt
cd ~/.local/opt
VERSION="0.14.0"
wget "https://ziglang.org/download/$VERSION/zig-linux-x86_64-$VERSION.tar.xz"
tar xfvJ "zig-linux-x86_64-$VERSION.tar.xz"
rm "zig-linux-x86_64-$VERSION.tar.xz"
cd -
rm -f ~/.local/bin/zig
ln -s ~/.local/opt/zig-*-$VERSION/zig ~/.local/bin/
