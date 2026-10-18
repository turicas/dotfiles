#!/bin/bash

mkdir -p ~/.local/bin
filename="$HOME/.local/bin/lsofgraph"
rm -rf "$filename"
wget -O "$filename" https://raw.githubusercontent.com/zevv/lsofgraph/refs/heads/master/lsofgraph
chmod +x "$filename"
