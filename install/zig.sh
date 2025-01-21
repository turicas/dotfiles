#!/bin/bash

set -e

mkdir -p ~/.local/opt
cd ~/.local/opt
wget https://ziglang.org/download/0.13.0/zig-linux-x86_64-0.13.0.tar.xz
tar xfvJ zig-linux-x86_64-0.13.0.tar.xz
rm zig-linux-x86_64-0.13.0.tar.xz
rm -rf ~/.local/bin/zig
cd -
ln -s ~/.local/opt/zig-*/zig ~/.local/bin/
